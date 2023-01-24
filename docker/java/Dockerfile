FROM python:3.10.5-slim

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends curl && \
  curl -O https://download.java.net/java/GA/jdk18.0.2.1/db379da656dc47308e138f21b33976fa/1/GPL/openjdk-18.0.2.1_linux-x64_bin.tar.gz && \
  tar zxvf openjdk-18.0.2.1_linux-x64_bin.tar.gz && \
  mv jdk-18.0.2.1 /opt/ && \
  rm openjdk-18.0.2.1_linux-x64_bin.tar.gz

  ENV JAVA_HOME /opt/jdk-18.0.2.1
  ENV PATH $JAVA_HOME/bin:$PATH

CMD ["bash"]
