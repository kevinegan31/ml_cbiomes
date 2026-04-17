# ml_cbiomes

Materials for the *Machine Learning for Time-Series Data* CBIOMES workshop.

This repository contains tutorials, datasets, and examples used throughout the workshop.

---

## Quick Start

Before the workshop, please complete the following:

1. Install Docker and pull the workshop container
2. Generate a Simons CMAP API key (required for some tutorials)

---

## Installation (Docker)

We will use a pre-built Docker container with all required dependencies.

Instructions for pulling and running the container will be provided soon.

In the meantime, please ensure that [Docker Desktop](https://www.docker.com/products/docker-desktop/) is installed.

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

```
ml_cbiomes/
├── tutorials/   # Workshop tutorials (main content)
├── data/        # Shared datasets and data access instructions
├── README.md
```

* `tutorials/`: Step-by-step notebooks and exercises
* `data/`: Small datasets and instructions for accessing external data (e.g., CMAP)

---

## Workshop Schedule

### Day 1: Time-Series Methods
### Day 2: Neural Networks + PINNs
### Day 3: Hackathon
