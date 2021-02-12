Setup a riot-web running in Docker using Kubernete and Helm
===========================================================
Git
===========
https://github.com/fhirbox/pegacorn-communicate-web

=======
Image
=======
Docker Hub image fhirfactory/pegacorn-base-communicate-app-web:1.0.0 has been used for now until we build node.15.x image or alpine image or node image.

======
Setup
======
1) Create a file called config.json from the sample file at: https://github.com/vector-im/riot-web/blob/develop/config.sample.json

Update the bae_url and server_name elements as following:

	"default_server_config": {
        "m.homeserver": {
            "base_url": "https://pegacorn-communicate-roomserver.site-a:30880",
            "server_name": "<the server_name from your custom homeserver.yaml file in pegacorn-communicate-roomserver"
        },
        "m.identity_server": {
            "base_url": "https://vector.im"
        }
    },

2) Copy this file to a host path location.  Remember this location as it is required for the helm command. e.q: riot\web

3) Add the following to the hosts file
	pegacorn-communicate-web.site-a
================
Build and deploy
================
cd E:\dev\pegacorn-communicate-web

docker build --rm -t pegacorn/pegacorn-communicate-web:1.0 .
\helm\helm upgrade pegacorn-communicate-web-site-a --install --namespace site-a --set serviceName="pegacorn-communicate-app-web",basePort=30890,hostPath="<location of your config.json file> e.q /data/riot-web",imageTag=1.0 helm

## Set environment variables
Referred to : https://medium.com/bb-tutorials-and-thoughts/dockerizing-react-app-with-nodejs-backend-26352561b0b7 

## How to build docker image and run 

1) Copy paste docker-ssl-certificate from E:\docker-ssl-cert to your pegacorn-communicate-app-web directory
2) Copy pegacorn-communicate-matrix-react-sdk and pegacorn-communicate-matrix-js-sdk into src/ directory
3) Run docker build command
docker build --rm --no-cache -t pegacorn-communicate-app-web:1.0 --file Dockerfile .
4) Run helm command to deploy to kubernetes cluster

<!-- docker build . --rm --no-cache --build-arg HTTP_PROXY=http://proxy.test.act.gov.au:9090 --build-arg IMAGE_BUILD_TIMESTAMP="%date% %time%" -t pegacorn-communicate-app-web:1.1.0 -->

Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), you can provide input using your keyboard while the output is logged to your terminal.

## Useful links
1. https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
2. https://hub.docker.com/r/vectorim/element-web
3. Docker overview: https://docs.docker.com/get-started/overview/

