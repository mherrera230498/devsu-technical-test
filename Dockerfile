FROM node:18-alpine

# Disabling env variables, these are defined inline with run command
# ENV DATABASE_NAME="./devDocker.sqlite"
# ENV DATABASE_USER="dbUser"
# ENV DATABASE_PASSWORD="dbPass"

# Disabling installation curl, health checks are performed by kubernetes
# RUN apk --no-cache add curl

USER node

WORKDIR /home/node/app

COPY ./package*.json ./

RUN npm ci

COPY . .

# Disabling healthcheck, health checks are performed by kubernetes
# HEALTHCHECK --interval=10s --timeout=3s \
#   CMD curl -f http://localhost:8000/api/users || exit 1

EXPOSE 8000

ENTRYPOINT ["node"]
CMD ["index.js"]