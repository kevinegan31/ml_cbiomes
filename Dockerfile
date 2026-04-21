FROM quay.io/jupyter/base-notebook

# Never prompt the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=linux

# Define locales.
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LC_MESSAGES=en_US.UTF-8

USER root

# install the locales you want to use
RUN set -ex \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && sed -i 's/^# pt_BR.UTF-8 UTF-8$/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen en_US.UTF-8 pt_BR.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && ln -s "/home/${NB_USER}/notebooks" /notebooks \
    && fix-permissions "/home/${NB_USER}"

# System deps for R package compilation
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libgit2-dev \
    libsecret-1-dev \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

COPY --chown=$NB_UID ./jupyter_notebook_config.py /home/${NB_USER}/.jupyter
COPY --chown=$NB_UID ./jupyter_notebook_config.json /home/${NB_USER}/.jupyter

# Install R + IRkernel via conda, then CRAN packages via conda-forge
RUN set -ex \
    && mamba update mamba --quiet --yes \
    && mamba install --quiet --yes --channel conda-forge \
    'ipympl' \
    'ipywidgets' \
    # Install new R environment
    && mamba create --quiet --yes --channel conda-forge --name R \
    'r-base=4.4.*' \
    'r-irkernel' \
    'r-rmarkdown' \
    'r-knitr' \
    'r-tinytex' \
    'r-desolve' \
    'r-tseries' \
    'r-urca' \
    'r-igraph' \
    'r-glmnet' \
    'r-vars' \
    'r-zoo' \
    'r-missforest' \
    'r-ggplot2' \
    'r-tidyr' \
    'r-dplyr' \
    'r-matrix' \
    'r-devtools' \
    'r-units' \
    'r-s2' \
    'r-terra' \
    'r-sf' \
    'r-Rcpp' \
    'r-raster' \
    'r-fs' \
    'r-svglite' \
    'r-png' \
    'r-leaflet' \
    'r-S7' \
    'r-leafem' \
    'r-data.table' \
    'r-plotly' \
    # Install TensorFlow
    && mamba create --quiet --yes --name Python \
    'python=3.12' \
    'ipykernel' \
    'ipympl' \
    'ipywidgets' \
    'matplotlib' \
    'numpy' \
    'pandas' \
    'statsmodels' \
    'scikit-learn' \
    && mamba clean -afy \
    && jupyter lab clean -y \
    && rm -rf "/home/${NB_USER}/.cache/yarn" \
    && rm -rf "/home/${NB_USER}/.node-gyp" \
    && fix-permissions "${CONDA_DIR}" \
    && mkdir "/home/${NB_USER}/notebooks" \
    && fix-permissions "/home/${NB_USER}"


RUN mamba shell init --shell bash
SHELL ["mamba","run","-n","R","/bin/bash","-c"]
RUN R -e "install.packages('bigtime', repos='https://cloud.r-project.org')"
RUN R -e "install.packages(c('satellite', 'mapview', 'otelsdk'), repos='https://ftp.osuosl.org/pub/cran/')"
RUN R -e "pkgbuild::with_build_tools(remotes::install_github('simonscmap/cmap4r/cmap4r',upgrade = 'never'),required = FALSE)"
RUN R -e "IRkernel::installspec(name='ir44', displayname='R')"
SHELL ["mamba","run","-n","Python","/bin/bash","-c"]
RUN pip install tensorflow
RUN pip install git+https://github.com/dynamicslab/pysindy.git
RUN pip install pycmap
RUN python -m ipykernel install --user --name=Python

# Setup Jupyter notifications to not nag people
COPY --chown=$NB_UID ./notification.jupyterlab-settings /home/${NB_USER}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/notification.jupyterlab-settings

# WORKDIR /home/${NB_USER}/work
