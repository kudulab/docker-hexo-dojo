FROM node:10.16

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

# Install common Dojo scripts
RUN userdel node &&\
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  sudo git ca-certificates wget && \
  git clone --depth 1 -b 0.5.0 https://github.com/ai-traders/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

# Install common usage apt packages.
# * ssh-client - to run git clone over ssh
# * locale-gen
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
  apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  apt-utils locales git unzip wget nano ssh-client &&\
  locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8 && update-locale &&\
  apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean &&\
  rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*

# Always update package managers to latest
RUN npm -g install yarn npm

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends\
  rsync

COPY hexo-dojo-yarn /home/dojo/hexo-dojo-yarn
RUN cd /home/dojo/hexo-dojo-yarn && yarn && chown dojo:dojo -R /home/dojo/hexo-dojo-yarn

# For Bash
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo -R /home/dojo

COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/

RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
