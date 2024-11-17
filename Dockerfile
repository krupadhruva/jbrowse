FROM nginx
ARG APP_NAME

ENV PATH=/root/.bun/bin:${PATH}

RUN apt-get update

# Install node compatible bun
RUN apt-get install -y curl unzip
RUN (curl -fsSL https://bun.sh/install | BUN_INSTALL=/usr/local bash)
RUN ln -s /usr/local/bin/bun /usr/local/bin/node

# Install jbrowse CLI and required packages
RUN apt-get install -y samtools tabix
RUN (. ~/.bashrc; bun install -g @jbrowse/cli)
RUN (. ~/.bashrc; jbrowse --version)

# Install the actual jbrowse2 web app under well known nginx default location
RUN (. ~/.bashrc; mkdir -p /usr/share/nginx/html; cd /usr/share/nginx/html; jbrowse create ${APP_NAME})

# Install custom nginx.conf
COPY nginx.conf /etc/nginx/conf.d/${APP_NAME}.conf
