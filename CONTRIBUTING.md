# Contributing

Bug fixes, docs and focused improvements are welcome. For a larger change,
open an issue first so we can discuss the approach.

Fork the repository, make one focused change and open a pull request against
`main`. Explain what changes, why it matters and how you tested it.

```sh
bash -n stayawake
make
```

Follow the existing Bash conventions. Keep platform changes compatible with macOS.

The automated checks run before review. Gabriel reviews each contribution and
decides whether to merge it or request changes.

## Publish a Homebrew update

Create a GitHub release for a stable `vMAJOR.MINOR.PATCH` tag and attach the
standalone executable as a release asset named `stayawake` before publishing.
The **Update Homebrew tap** action verifies the asset against GitHub's SHA-256
digest and updates `gabe-maxxing/homebrew-tap`. You can rerun it manually
after fixing missing assets. The action uses the repository secret
`HOMEBREW_TAP_DEPLOY_KEY`, scoped to the tap.
