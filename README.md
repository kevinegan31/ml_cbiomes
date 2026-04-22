# ml_cbiomes

Materials for the *Machine Learning for Time-Series Data* CBIOMES workshop.

This repository contains tutorials, datasets, and setup information used throughout the workshop.

---

## Quick Start

Before the workshop, please try to complete the following:

1. Install Docker Desktop
2. Pull the workshop container image
3. Clone this repository to your local machine
4. Generate a Simons CMAP API key (required for some tutorials)
5. Run the `linear_regression_example.ipynb` notebook to confirm that your setup is working.

If you are unable to complete any of these steps, please contact the event organizers.

---

## Docker Installation

We will use a pre-built Docker container with all required dependencies for the workshop.

### 1. Install Docker Desktop

Please install Docker Desktop for your operating system:

- [macOS](https://docs.docker.com/desktop/install/mac-install/)
- [Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Linux](https://docs.docker.com/desktop/install/linux-install/)

If Docker is already installed, please make sure it is up to date.

### 2. Pull the workshop image

Open Docker Desktop, go to **Images**, and search for:

`powellb/cbiomes-ml`

Select the `2026` tag and pull the image.

### 3. Clone this repository

Clone this repository to your local machine.  
This folder will be mounted into the container so you can access workshop files and save your work.

```bash
git clone https://github.com/kevinegan31/ml_cbiomes.git
cd ml_cbiomes
```

### 4. Run the container

When launching the container in Docker Desktop:

- Choose a host port such as `8900`
- Mount your local `ml_cbiomes` folder into the container at `/notebooks`

Then open in your browser:

`http://localhost:8900`

This will launch JupyterLab inside the container.

### 5. Test your setup

After launching JupyterLab, navigate to the repository folder, open the notebook, select the `Python` kernel, and run:

`linear_regression_example.ipynb`

This notebook is included as a simple test to confirm that the container is working properly.

If you encounter a `ModuleNotFoundError`, make sure the notebook is using the `Python` kernel (not `python3`).

For more detailed Docker setup instructions (optional), see [`containers.md`](containers.md).

---

## Simons CMAP API Key

Some tutorials require access to the Simons CMAP database.

1. Go to [Simons CMAP](https://simonscmap.com/)
2. Log in or create an account
3. Click on **Documentation** in the top menu
4. Select **API Key**
5. Click **Generate API Key**
6. Save your key for use in the tutorials

You will use this key to access CMAP data via Python (`pycmap`) or R (`cmap4r`).

We recommend completing this step before the workshop begins.

---

## Repository Structure

This repository will be updated as workshop materials are finalized.  
Please pull the latest version before Day 1 and during the workshop as needed.

- `tutorials/`: Step-by-step notebooks and exercises  
- `data/`: Datasets used in tutorials and for exploration 

---

## Workshop Schedule

![Workshop Schedule](figs/ml_workshop_schedule.png)
