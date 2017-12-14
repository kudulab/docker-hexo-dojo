FROM docker-registry.ai-traders.com/node-ide:0.1.5

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends\
  rsync

COPY hexoide-yarn /home/ide/hexoide-yarn
RUN cd /home/ide/hexoide-yarn && yarn && chown ide:ide -R /home/ide/hexoide-yarn

# For Bash
COPY bashrc /home/ide/.bashrc
RUN chown ide:ide -R /home/ide

# Those are light to install and may change often, so they go at the bottom
# of this Dockerfile.
COPY etc_ide.d/scripts/* /etc/ide.d/scripts/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

ARG this_image_tag_arg
ARG this_image_name_arg
ENV this_image_tag=${this_image_tag_arg} this_image_name=${this_image_name_arg}
