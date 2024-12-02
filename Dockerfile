# Details: https://github.com/tiangolo/uwsgi-nginx-flask-docker
FROM tiangolo/uwsgi-nginx-flask:python3.12

# Configured via Makefile when building docker image
ARG APP_NAME

ENV NGINX_ROOT=/usr/share/nginx/html
ENV APP_NAME=${APP_NAME}
ENV APP_ROOT=${NGINX_ROOT}/${APP_NAME}

# Run WSGI app in unprivileged mode (not root)
RUN useradd jb2

# Base docker image is based on Debian with older node repository
# Add newer node debian repository to pull from it instead of base
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update

# Install node, jbrowse CLI and required packages
RUN apt-get install -y nodejs samtools tabix
RUN npm install -g @jbrowse/cli
RUN jbrowse --version

# Create local directory to support ephemeral bootstrapping
RUN mkdir -p /user_data

# Install the actual jbrowse2 web app under well known nginx default location
RUN (mkdir -p ${NGINX_ROOT}; cd ${NGINX_ROOT}; jbrowse create ${APP_NAME} && ln -s /user_data ${APP_NAME}/user_data)

# Install custom nginx.conf from template
COPY nginx.conf.tmpl /tmp/nginx.conf.tmpl
RUN envsubst < /tmp/nginx.conf.tmpl > /etc/nginx/conf.d/${APP_NAME}.conf

# Copy and configure uwsgi app
COPY ./app /app
RUN if [ -f /app/requirements.txt ]; then pip install --no-cache-dir --upgrade -r /app/requirements.txt; fi

# Bootstrap custom Banna samples instead of random test samples
COPY data /tmp/genome_data
COPY scripts/bootstrap_samples.sh /app/bootstrap_samples.sh
RUN rm -fr ${NGINX_ROOT}/${APP_NAME}/test_data/*
RUN /app/bootstrap_samples.sh /tmp/genome_data ${NGINX_ROOT}/${APP_NAME}/test_data
RUN rm -fr /tmp/genome_data
