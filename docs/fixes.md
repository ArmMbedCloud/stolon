# Build fixes

Source is unchanged from `v0.16.0`. The `Dockerfile` builds the four binaries the way the `Makefile` does, with Go 1.14, and passes `v0.16.0` as the version because the build context has no `.git` for `scripts/git-version.sh`. The rebuilt `stolon-keeper --version` reports `v0.16.0`, as in `platform/stolon:0.16.0-pg12.8-5`.
