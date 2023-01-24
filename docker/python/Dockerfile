FROM python:3.10.5-slim

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends libgomp1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["bash"]
