# Python Environments

A collection of **reproducible Conda environments** for my local development setup.

Each environment lives in its own folder (for example, `playground` or `quarto-blogging`) and contains:

- a `.yml` file defining the environment (packages, Python version, and channels)
- a rebuild script that recreates the environment safely and reproducibly

Shared helper scripts are stored under the `helpers/` folder.

## 🧩 Repository Structure

```text
python-environments/
├── helpers/
│   └── ensure_no_env.sh           # aborts if any environment is active
│
├── claude-code/
│   ├── claude-code.yml            # environment for Office and PDF document processing
│   └── rebuild_claude-code.sh     # rebuild script for claude-code
│
├── fastai-latest/
│   ├── fastai-latest.yml          # environment for FastAI + PyTorch on Apple Silicon
│   └── rebuild_fastai-latest.sh   # rebuild script for fastai-latest
│
├── playground/
│   ├── playground.yml             # lightweight experimental environment
│   └── rebuild_playground.sh      # rebuild script for playground
│
├── quarto-blogging/
│   ├── quarto-blogging.yml        # environment for nbdev + Quarto publishing
│   └── rebuild_quarto-blogging.sh # rebuild script for blogging setup
│
└── sap-gen-ai/
    ├── sap-gen-ai.yml             # environment for SAP Generative AI Hub SDK
    └── rebuild_sap-gen-ai.sh      # rebuild script for sap-gen-ai
```

## 🧰 Usage

Rebuild scripts resolve their helper and YAML paths relative to their own location,
so they can be run from any working directory. For example, from the repository root:

```bash
bash playground/rebuild_playground.sh
```

Or from the environment's folder:

```bash
cd playground
bash rebuild_playground.sh
```

Each script:

- verifies that no Conda environment is currently active
- removes the existing environment (if present)
- recreates it from the corresponding .yml file

After rebuilding, activate the environment manually:

```bash
conda activate playground
```

## 🧠 Notes

- All environments are managed by Miniforge (Conda/Mamba).
- The base environment is kept clean and used only as a factory for creating other environments.
- You can safely extend this structure by adding new folders with their own *.yml and rebuild scripts.
