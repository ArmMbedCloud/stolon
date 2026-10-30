# Build settings

The source version is `v0.16.0`. The Dockerfile builds four binaries with Go 1.14 and passes `v0.16.0` as the version. The Docker context excludes `.git`, which `scripts/git-version.sh` requires for version discovery.

## Nucloud commands

| Setting | Reason | File |
|---|---|---|
| Nucloud targets use an isolated Makefile branch | `make build` and `make deploy` use Docker without invoking native host prerequisites; other explicit targets retain their native rules. | `Makefile` |
