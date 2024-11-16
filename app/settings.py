import os

# NOTE: This path is based on install location in docker
APP_NAME = os.getenv("APP_NAME", "jbrowse")
NGINX_ROOT = os.getenv("NGINX_ROOT", "/usr/share/nginx/html")

APP_ROOT = os.getenv("APP_ROOT", os.path.join(NGINX_ROOT, APP_NAME))
TEST_DATA = os.getenv("TEST_DATA", "test_data")
USER_DATA = os.getenv("USER_DATA", "user_data")
