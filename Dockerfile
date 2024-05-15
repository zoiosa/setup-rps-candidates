FROM python:3.10-slim-buster
USER root
WORKDIR /
COPY requirements.txt /requirements.txt


RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir -p /home/user
WORKDIR /home/user

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8887

ENTRYPOINT ["jupyter", "lab", "--port=8887", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
