FROM alpine:3.5
# For ide:
# * entrypoint requires sudo and shadow
# * git is needed to install ide image configs
# * openssh is needed by `git clone git@...` and to release our gems
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache bash shadow sudo git openssh && \
  git clone --depth 1 -b 0.8.3 https://github.com/ai-traders/ide.git /tmp/ide_git && \
  /tmp/ide_git/ide_image_scripts/src/install.sh && \
  rm -r /tmp/ide_git && \
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# installing Yarn results in installing Node, so no need to start this docker
# image FROM some Node image
RUN apk add --no-cache nano rsync autoconf automake gcc yarn
# this is split from the above layer, because npm packages change faster
# than apk packages
COPY hexoide-yarn /home/ide/hexoide-yarn
RUN cd /home/ide/hexoide-yarn && yarn && chown ide:ide -R /home/ide/hexoide-yarn

# put those at the end of Dockerfile, so that earlier time-consuming layers
# are cached
COPY bashrc /home/ide/.bashrc
RUN chown ide:ide /home/ide/.bashrc
COPY etc_ide.d/scripts/* /etc/ide.d/scripts/
# COPY etc_ide.d/variables/* /etc/ide.d/variables/

ARG this_image_tag_arg
ARG this_image_name_arg
ENV this_image_tag=${this_image_tag_arg} this_image_name=${this_image_name_arg}
