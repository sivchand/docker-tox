FROM sivchand/pyenv

LABEL maintainer="Siv Chand Koripella <sivchand@gmail.com>"

RUN groupadd -r tox --gid=999 && \
    useradd -m -r -g tox --uid=999 tox

RUN apt-get update -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends ca-certificates wget gosu && \
    rm -rf /var/lib/apt/lists /tmp/* /var/tmp/* 

RUN pyenv local 3.8.13 && \
    python -m pip install -U pip && \
    python -m pip install tox && \
    pyenv local --unset && \
    pyenv rehash

WORKDIR /app
VOLUME /src

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tox"]
