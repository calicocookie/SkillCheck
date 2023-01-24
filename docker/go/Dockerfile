FROM python:3.10.5-slim

ARG go_ver="1.18.5"
ARG go_pkg="go${go_ver}.linux-amd64.tar.gz"
ARG build_pkgs="curl"
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends ${build_pkgs} && \
  curl -o ${go_pkg} https://dl.google.com/go/${go_pkg} && \
  tar -C /usr/local -xzf ${go_pkg} && \
  rm ${go_pkg} && \
  apt-get -y remove --purge ${build_pkgs} && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/go/bin:$PATH

CMD ["bash"]
