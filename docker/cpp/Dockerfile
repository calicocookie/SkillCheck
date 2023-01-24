FROM python:3.10.5-slim

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends g++-9 && \
  ln -s /usr/bin/gcc-9 /usr/bin/gcc && \
  ln -s /usr/bin/g++-9 /usr/bin/g++ && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

CMD ["bash"]
