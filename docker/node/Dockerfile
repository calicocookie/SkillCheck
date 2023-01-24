FROM python:3.10.5-slim

ARG node_ver="v18.8.0"
ARG node_ver_arch="node-${node_ver}-linux-x64"
ARG build_pkgs="curl xz-utils"
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends ${build_pkgs} && \
  curl -o ${node_ver_arch}.tar.xz https://nodejs.org/dist/${node_ver}/${node_ver_arch}.tar.xz && \
  mkdir -p /usr/local/lib/nodejs && \
  tar -C /usr/local/lib/nodejs -xJf ${node_ver_arch}.tar.xz && \
  rm ${node_ver_arch}.tar.xz && \
  apt-get -y remove --purge ${build_pkgs} && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/lib/nodejs/${node_ver_arch}/bin:$PATH

CMD ["bash"]
