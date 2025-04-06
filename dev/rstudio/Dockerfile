FROM rocker/rstudio

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libglpk40 \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev

RUN apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    lmodern

