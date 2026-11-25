<p align="center">
  <img src="docs/whitney-logo.png" width="112" alt="Whitney, the stayawake logo">
</p>

<h1 align="center">stayawake</h1>

<p align="center">
  <a href="#install-with-homebrew">Install</a> ·
  <a href="#update-with-homebrew">Update</a> ·
  <a href="#whitney-your-terminal-watchdog">Meet Whitney</a> ·
  <a href="#whitneys-bed">Wake Whitney</a>
</p>

**Keep your Mac awake while your agents work.**

Install stayawake when a long-running agent, build, or script needs your Mac
to stay awake. Use `stayawake on` before starting, then `stayawake off` to
restore normal sleep. `stayawake status` tells you which mode you’re in.

**Meet Whitney, the real-life Dogo Argentino behind stayawake.** Her head is the logo and her full-body sprite is your terminal watchdog.

![Animated terminal preview of Whitney on watch, asleep, and showing an example release alert.](docs/whitney-terminal.gif)

[![macOS checks](https://github.com/Gabriellvl/stayawake/actions/workflows/macos.yml/badge.svg)](https://github.com/Gabriellvl/stayawake/actions/workflows/macos.yml)

| Command | What it does |
| --- | --- |
| `stayawake on` | Keeps your Mac awake |
| `stayawake off` | Allows normal sleep |
| `stayawake` or `stayawake status` | Shows the current setting |
| `stayawake buddy` | Shows Whitney the Dogo Argentino, on watch or asleep |
| `stayawake updates` | Checks GitHub for a newer release |
| `stayawake updates --open` | Opens the release page |

## Install with Homebrew

```bash
brew tap gabe-maxxing/tap
brew trust --formula gabe-maxxing/tap/stayawake
brew install gabe-maxxing/tap/stayawake
stayawake status
```

### Update with Homebrew

```bash
brew update
brew trust --formula gabe-maxxing/tap/stayawake
brew upgrade gabe-maxxing/tap/stayawake
```

Homebrew saves trust for this formula, so you only need to grant it once.
Run `stayawake --version` to confirm the installed version. To upgrade all
installed Homebrew packages, use `brew upgrade` without a package name.

Use `brew uninstall gabe-maxxing/tap/stayawake` to remove the command. Run
`stayawake off` before uninstalling if you want to restore normal sleep.

`stayawake --help` lists all commands and `stayawake --version` shows
the installed version. If your installed release predates the terminal buddy,
use [the Git checkout](#run-from-the-repo) to try the latest code.

## Whitney, your terminal watchdog

<img src="docs/whitney-logo.png" width="52" align="right" alt="">

The white Dogo Argentino who inspired stayawake now has three terminal poses.
She stands watch when your Mac is set to stay awake, curls up when it can
sleep, and perks up when there is a new release. Run `stayawake buddy` to see
her and check your Mac's sleep setting.

During normal interactive use, stayawake checks the public GitHub release
page at most once a day after a successful check. A network failure is
retried after 15 minutes. Whitney alerts you once per new version. The check
times out after two seconds. Set `STAYAWAKE_NO_UPDATE_CHECK=1` to disable
automatic checks, or run `stayawake updates` to check on demand. Set
`NO_COLOR=1` for plain text art.

For email, use **Watch → Custom → Releases** on
[GitHub](https://github.com/Gabriellvl/stayawake) and enable email for
watched repositories in your
[notification settings](https://github.com/settings/notifications).

## Demo video

<img src="docs/whitney-logo.png" width="42" align="right" alt="">

*Video coming soon. The terminal GIF above previews the sleep switch and release alerts.*

## Download from GitHub

The [latest release](https://github.com/Gabriellvl/stayawake/releases/latest)
offers the standalone script and a macOS archive with the script, README,
and license. Verify your download with the matching entry in `SHA256SUMS`
(`shasum -a 256 <filename>`).


From the folder containing the downloaded or extracted script:

```bash
mkdir -p "$HOME/.local/bin"
install -m 755 stayawake "$HOME/.local/bin/stayawake"
"$HOME/.local/bin/stayawake"
```

If your shell can't find `stayawake` by name, add this line to your
`~/.zshrc` on macOS and open a new Terminal window:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## MacPorts

An experimental [local Portfile](packaging/macports/sysutils/stayawake/Portfile)
is available for MacPorts users. Clone this repo, add the absolute path to
`packaging/macports` as a `file://` source above the default source in
`sources.conf`, and run `portindex` from that directory. Then run
`sudo port install stayawake` and `stayawake status`. See the
[MacPorts local repository guide](https://guide.macports.org/chunked/development.local-repositories.html).

## Run from the repo

```bash
git clone https://github.com/Gabriellvl/stayawake.git
cd stayawake
./stayawake buddy
./stayawake updates
```

To see both poses on your Mac, run `./stayawake on`, then `./stayawake off`.
These two commands change the system sleep setting and may prompt for your
administrator password. If an agent is running, wait until it finishes before
turning stayawake off.

From the checkout, `make install` installs to `~/.local/bin`. Set
`PREFIX` to use a different location.

## How it works

`stayawake` uses the version of Bash and `pmset` included with macOS.
Switching modes uses `sudo` and applies to all power profiles. The setting
persists after the command exits. Run `stayawake off` to restore normal
sleep behavior.

## Uninstall

Run `stayawake off` if you want normal sleep restored, then run
`make uninstall` from the checkout or remove `~/.local/bin/stayawake`.

## Platform support

The current release supports macOS and uses its built-in `pmset`.
Linux, Windows, BSD, and other systems still need their own sleep backends.

## License

[MIT](LICENSE)

## Whitney's bed

<details>
<summary><img src="docs/whitney-logo.png" width="26" alt=""> &nbsp; Peek in on Whitney</summary>

<p><img src="docs/whitney-asleep.png" width="680" alt="Whitney curled up asleep in the terminal"></p>

<details>
<summary>🐾 Wake Whitney</summary>

<p><img src="docs/whitney-awake.png" width="680" alt="Whitney standing up and on watch in the terminal"></p>

She’s on watch. Close this panel to let her go back to sleep.

</details>
</details>
