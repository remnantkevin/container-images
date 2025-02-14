# syntax=docker/dockerfile:1

ARG DEBIAN_VERSION=bookworm
ARG RUBY_VERSION=3.3
ARG RUBY_IMAGE_TAG=${RUBY_VERSION}-slim-${DEBIAN_VERSION}

# ========== build =====================================================================================================
FROM ruby:${RUBY_IMAGE_TAG} AS build

SHELL [ "/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c" ]

RUN <<EOT
  apt-get update
  apt-get install --no-install-recommends --yes build-essential
EOT

RUN gem install puma roda

# ========== app =======================================================================================================
FROM ruby:${RUBY_IMAGE_TAG} AS app

SHELL [ "/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c" ]

ARG USERNAME=ruby
ARG USERID=1327

RUN <<EOT
  groupadd --gid ${USERID} ${USERNAME}
  useradd --uid ${USERID} --gid ${USERID} --create-home ${USERNAME}
EOT

COPY --from=build ${GEM_HOME} ${GEM_HOME}

USER ${USERNAME}

WORKDIR /home/${USERNAME}/app

COPY --chown=${USERNAME}:${USERNAME} config.ru /home/${USERNAME}/app/config.ru

ENTRYPOINT ["puma"]
CMD [ "--port", "9292" ]
