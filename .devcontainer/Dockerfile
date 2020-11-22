# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=2.7
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

# Install Rails
RUN gem install rails webdrivers solargraph

ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

RUN mkdir -p /workspace/node_modules
RUN chown vscode:vscode /workspace/node_modules

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends \
     vim \
     htop \
     ffmpeg

EXPOSE 35729

# [Optional] Uncomment this line to install additional gems.
# RUN gem install <your-gem-names-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
