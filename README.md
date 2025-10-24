# Python Environments

A collection of **reproducible Conda environments** for my local development setup.

Each environment lives in its own folder (for example, `playground` or `quarto-blogging`) and contains:

- a `.yml` file defining the environment (packages, Python version, and channels)
- a rebuild script that recreates the environment safely and reproducibly

Shared helper scripts are stored under the `helpers/` folder.

## 🧩 Repository Structure

```test
python-environments/
├── helpers/
│   └── ensure_no_env.sh           # aborts if any environment is active
│
├── playground/
│   ├── playground.yml             # lightweight experimental environment
│   └── rebuild_playground.sh      # rebuild script for playground
│
├── quarto-blogging/
│   ├── quarto-blogging.yml        # environment for nbdev + Quarto publishing
│   └── rebuild_quarto-blogging.sh # rebuild script for blogging setup
```

## 🧰 Usage

To rebuild an environment, navigate to its folder and run the rebuild script:

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
