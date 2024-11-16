FROM nginx
ARG APP_NAME

# Install node since jbrowse2 is in Java script or Type script
RUN apt-get update
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN (. ~/.bashrc; nvm install node)
RUN apt-get install -y samtools tabix

# Install jbrowse CLI
RUN (. ~/.bashrc; npm install -g @jbrowse/cli)
RUN (. ~/.bashrc; jbrowse --version)

# Install the actual jbrowse2 web app under well known nginx default location
RUN (. ~/.bashrc; mkdir -p /usr/share/nginx/html; cd /usr/share/nginx/html; jbrowse create ${APP_NAME})

# Install custom nginx.conf
COPY nginx.conf /etc/nginx/conf.d/${APP_NAME}.conf
