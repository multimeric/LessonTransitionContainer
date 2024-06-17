FROM mambaorg/micromamba:1.5.8
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1 
RUN git clone https://github.com/carpentries/lesson-transition.git
WORKDIR lesson-transition
RUN git submodule update --init git-filter-repo 
RUN R -e 'renv::restore()'
# make sandpaper/carpentries-incubator/docker-introduction.json
