FROM tiangolo/uwsgi-nginx:python3.12

ARG APP_NAME
ENV PATH=/root/.node/bin:${PATH}

# Install jbrowse CLI and required packages
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs samtools tabix
RUN npm install -g @jbrowse/cli
RUN (. ~/.bashrc; jbrowse --version)

# Install the actual jbrowse2 web app under well known nginx default location
RUN (. ~/.bashrc; mkdir -p /usr/share/nginx/html; cd /usr/share/nginx/html; jbrowse create ${APP_NAME})

# Install custom nginx.conf
COPY nginx.conf /etc/nginx/conf.d/${APP_NAME}.conf

# Copy and configure uwsgi app
COPY ./app /app
RUN if [ -f /app/requirements.txt ]; then pip install --no-cache-dir --upgrade -r /app/requirements.txt; fi

RUN useradd jb2
