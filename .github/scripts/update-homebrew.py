import hashlib
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path


def version_tuple(version):
    if not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+", version):
        raise ValueError(f"Expected a three-part version, got {version!r}")
    return tuple(map(int, version.split(".")))


def update_formula(release_path, formula_path):
    release = json.loads(release_path.read_text())
    tag = release["tag_name"]
    if release["draft"] or release["prerelease"] or not tag.startswith("v"):
        raise ValueError(f"Expected a stable v-prefixed release, got {tag!r}")
    version = tag[1:]
    release_version = version_tuple(version)

    formula = formula_path.read_text()
    current = re.findall(r'^  version "([^"]+)"$', formula, re.MULTILINE)
    if len(current) != 1:
        raise ValueError("Expected exactly one formula version")
    current_version = version_tuple(current[0])
    if release_version < current_version:
        print(f"Keeping stayawake {current[0]} in the tap")
        return

    url = f"https://github.com/gabe-maxxing/stayawake/releases/download/{tag}/stayawake"
    asset = next(
        (item for item in release["assets"] if item["name"] == "stayawake"),
        None,
    )
    if not asset or asset["state"] != "uploaded" or asset["browser_download_url"] != url:
        raise ValueError(f"Release {tag} is missing its published stayawake asset")

    with tempfile.TemporaryDirectory() as directory:
        download = Path(directory) / "stayawake"
        subprocess.run(
            [
                "curl", "--fail", "--silent", "--show-error", "--location",
                "--proto", "=https", "--proto-redir", "=https", "--max-time", "60",
                "--output", str(download), url,
            ],
            check=True,
        )
        digest = hashlib.sha256(download.read_bytes()).hexdigest()
    if asset.get("digest") != f"sha256:{digest}":
        raise ValueError(f"Release {tag} asset does not match GitHub's SHA-256")

    fields = {"url": url, "version": version, "sha256": digest}
    for field, value in fields.items():
        formula, count = re.subn(
            rf'^  {field} "[^"]+"$', f'  {field} "{value}"', formula, flags=re.MULTILINE
        )
        if count != 1:
            raise ValueError(f"Expected exactly one formula {field}")
    formula_path.write_text(formula)


if __name__ == "__main__":
    update_formula(Path(sys.argv[1]), Path(sys.argv[2]))
