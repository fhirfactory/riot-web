#NOTE: this docker file assumes the following exist in the same directory as this Dockerfile
# 1. PRDPKICA.crt
# 2. pegacorn-communicate-matrix-js-sdk
# 3. pegacorn-communicate-matrix-react-sdk

# Builder
FROM fhirfactory/pegacorn-base-communicate-app-web:1.0.0 as builder

# Support custom branches of the react-sdk and js-sdk. This also helps us build
# images of riot-web develop.
# ARG USE_CUSTOM_SDKS=false
# ARG REACT_SDK_REPO="https://github.com/matrix-org/matrix-react-sdk.git"
# ARG REACT_SDK_BRANCH="master"
# ARG JS_SDK_REPO="https://github.com/matrix-org/matrix-js-sdk.git"
# ARG JS_SDK_BRANCH="master"

WORKDIR /src

COPY . /src

# Conditionally copy certificate, as it won't exist outside the proxy (based on https://forums.docker.com/t/copy-only-if-file-exist/3781/3)
COPY /README.md /PRDPKICA.crt* /opt/

# gyp ERR! stack Error: connect ECONNREFUSED 104.20.23.46:443 - when we run yarn install (proxy blocking operation)
# https://github.com/nodejs/node-gyp/issues/1133
COPY /node-v12.20.1-headers.tar.gz /tmp/node-headers.tgz
RUN npm config set tarball /tmp/node-headers.tgz

# FetchError: request to https://jitsi.riot.im/libs/external_api.min.js failed, reason: connect ECONNREFUSED 94.237.52.49:443 (proxy blocking operation)
# Alternatively can 'build-jitsi.js' file be modified to support proxy authentication?
# Jitsi download is invoked in /scripts/build-jitsi.js
RUN mkdir -p /webapp
COPY /jitsi_external_api.min.js /webapp/jitsi_external_api.min.js

# Configuring certificate while SSL authentication is true
# Conditionally configure yarn to use https proxy. Based on: 
# 1. https://stackoverflow.com/questions/51508364/yarn-there-appears-to-be-trouble-with-your-network-connection-retrying
# 2. https://www.dev-diaries.com/social-posts/conditional-logic-in-dockerfile/
ARG HTTPS_PROXY
RUN if [ -n "$HTTPS_PROXY" ] ; then \
    yarn config set https-proxy ${HTTPS_PROXY} \
 && yarn config set strict-ssl true \
 && yarn config set cafile /opt/PRDPKICA.crt \
 ; fi

# Not mandatory when working with pegacorn sdk branches that were pulled locally
# This explains why the ARG variables are commented out
# RUN dos2unix /src/scripts/docker-link-repos.sh && bash /src/scripts/docker-link-repos.sh

WORKDIR /src/pegacorn-communicate-matrix-js-sdk
RUN yarn link \
 && yarn --network-timeout 100000 install
 
WORKDIR /src/pegacorn-communicate-matrix-react-sdk
RUN yarn link \
 && yarn link matrix-js-sdk \
 && yarn --network-timeout 100000 install \
 && yarn reskindex
 
WORKDIR /src
RUN yarn link matrix-js-sdk \
 && yarn link matrix-react-sdk \
 && yarn --network-timeout 100000 install \
 && yarn build

# Copy the config now so that we don't create another layer in the app image
RUN cp /src/config.json /src/webapp/config.json

# Ensure we populate the version file
RUN dos2unix /src/scripts/docker-write-version.sh && bash /src/scripts/docker-write-version.sh

# Date-time build argument
ARG IMAGE_BUILD_TIMESTAMP
ENV IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}
RUN echo IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}

# App
FROM nginx:alpine

COPY --from=builder /src/webapp /app

# Insert wasm type into Nginx mime.types file so they load correctly.
RUN sed -i '3i\ \ \ \ application/wasm wasm\;' /etc/nginx/mime.types

RUN rm -rf /usr/share/nginx/html \
 && ln -s /app /usr/share/nginx/html