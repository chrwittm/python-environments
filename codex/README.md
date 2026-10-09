# Codex Python environment

A separate Miniforge environment for Codex Python tools. The approved package
versions are defined in `codex.yml`; package-purpose comments are included there.

## Setup or deliberate rebuild

Install [Miniforge](https://github.com/conda-forge/miniforge) for your operating
system and architecture. The scripts default to `$HOME/miniforge3`. Set
`MINIFORGE_ROOT` to an absolute path if installed elsewhere.

From this repository, inspect existing environments first:

```bash
"${MINIFORGE_ROOT:-$HOME/miniforge3}/bin/conda" env list
# If the intended codex prefix exists:
"${MINIFORGE_ROOT:-$HOME/miniforge3}/bin/conda" list \
  --prefix "${MINIFORGE_ROOT:-$HOME/miniforge3}/envs/codex"
```

Deactivate all Conda environments, including base, then run:

```bash
bash codex/rebuild_codex.sh
```

This creates `$HOME/miniforge3/envs/codex` when absent. If present, it lists its
packages and **deletes and recreates that environment** from the YAML. Other
prefixes are not targeted. The script resolves its files relative to itself and
can also be called by absolute path from another working directory.

## Usage and verification

Activation is optional. Invoke Python through the launcher:

```bash
bash codex/run_python.sh --version
bash codex/run_python.sh -c 'import sys, yaml; print(sys.executable); print(yaml.__version__)'
bash codex/run_python.sh -m pip --version
bash codex/run_python.sh /path/to/helper.py
```

The launcher selects the explicit `codex` prefix using `conda run`, forwards stdin,
arguments, and the exit status, and works when another Conda environment is active.
It clears inherited Python package paths and disables user-site packages.
Normal invocation never installs or rebuilds anything. A missing environment
produces an error without an interpreter fallback.

To run an installed skill validator, supply its actual paths:

```bash
bash codex/run_python.sh /path/to/quick_validate.py /path/to/existing-skill
```

## Reproducibility

The YAML pins Python 3.13.16, pip 26.2.1, and PyYAML 6.0.3, tested on macOS arm64.
It omits platform build strings and absolute installation prefixes.
[`locks/osx-arm64.explicit.txt`](locks/osx-arm64.explicit.txt) records all tested
macOS arm64 package builds and checksums.

For exact macOS arm64 recreation, deactivate all environments. Inspect and remove
an existing target only if present, then create from the explicit package file:

```bash
# Only if this prefix already exists:
"$HOME/miniforge3/bin/conda" list --prefix "$HOME/miniforge3/envs/codex"
"$HOME/miniforge3/bin/conda" env remove --prefix "$HOME/miniforge3/envs/codex" --yes
# Create after removal, or directly when absent:
"$HOME/miniforge3/bin/conda" create --prefix "$HOME/miniforge3/envs/codex" \
  --file codex/locks/osx-arm64.explicit.txt --yes
```

Replay requires compatible macOS and upstream package availability. The explicit
file is not an offline package archive.

## Linux and cloud provisioning

Use the same YAML in a separate Miniforge installation for the worker's Linux
architecture. Install Miniforge using the appropriate installer and verify its
published checksum. With no active Conda environment, provision explicitly:

```bash
MINIFORGE_ROOT=/opt/miniforge3 bash /path/to/python-environments/codex/rebuild_codex.sh
MINIFORGE_ROOT=/opt/miniforge3 bash /path/to/python-environments/codex/run_python.sh --version
```

Run provisioning at worker setup, not on each helper invocation. Use the worker's
actual repository path and consistently supply its Miniforge root. Verify Python,
PyYAML, pip, and an installed skill validator on that worker. Linux execution
has not been tested here; do not use the `osx-arm64` explicit file on Linux.
For exact Linux replay, record a separate platform-specific package file using
`conda list --prefix /opt/miniforge3/envs/codex --explicit --md5`.
