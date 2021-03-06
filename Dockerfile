FROM rocker/shiny

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -yqq update \
    && apt-get -yqq install --no-install-recommends libhdf5-dev libssl-dev libssh2-1-dev python3-dev \
    && R -e 'install.packages("h5"); install.packages("devtools", repos = "http://cran.us.r-project.org"); require(devtools); install_github("pcarbo/varbvs",subdir = "varbvs-R")' \
    && wget -qO- https://bootstrap.pypa.io/get-pip.py | python3 - --no-cache-dir \
    && pip3 --no-cache-dir install numpy scipy pandas ipython nipype jupyter scikit-learn tensorflow==1.6 edward \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/bin/bash"]
