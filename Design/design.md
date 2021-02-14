Setup a riot-web running in Docker using Kubernete and Helm
===========================================================
Git
===========
https://github.com/fhirfactory/pegacorn-communicate-app-web

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
cd E:\dev\pegacorn-communicate-app-web or where you have downloaded the project

## Set environment variables
Referred to : https://medium.com/bb-tutorials-and-thoughts/dockerizing-react-app-with-nodejs-backend-26352561b0b7 

## How to build docker image and run 

1) Copy paste docker-ssl-certificate from E:\docker-ssl-cert to your pegacorn-communicate-app-web directory
2) Copy pegacorn-communicate-matrix-react-sdk and pegacorn-communicate-matrix-js-sdk into src/ directory
3) Run docker build command
docker build --rm --no-cache -t pegacorn-communicate-app-web:1.0 --file Dockerfile .
4) Run helm command to deploy to kubernetes cluster
5) Check that if applicaiton is running on your browser: http://pegacorn-communicate-web.site-a:30990/

## Certificate Setup for SSL
==================Certificates for https========================
Clone the certificates for the app-web on Azure repo to E:\dev\aether-host-files\LocalWorkstations
When the alpine command is executed (cp -r /host_mnt/e/dev/aether-host-files/LocalWorkstations/* /data/) it will pick up the elements app web certificates.

## Docker Build
docker build --rm --build-arg IMAGE_BUILD_TIMESTAMP="%date% %time%" -t fhirfactory/pegacorn-communicate-app-web:1.0.0-snapshot --file Dockerfile .

## Run Helm Command(Install)
\helm\helm upgrade pegacorn-communicate-web-site-a --install --namespace site-a --set serviceName="pegacorn-communicate-web",basePort=30890,hostPathKey="/data/elementcerts",hostPathCert="/data/elementcerts",imageTag=1.0.0-snapshot,numOfPods=1 helm

## Check if it runs on your browser
Browse to website - confirm padlock key shows it is secure.
https://pegacorn-communicate-web.site-a:30890
*** CONFIGURE SYNAPSE SERVER IN KUBERNETES TO CONNECT TO THE PEGACORN ROOMSERVER

## Trivy
Run Trivy Scanner to find potential vulnerability in image
fhirfactory/pegacorn-communicate-app-web:1.0.0-snapshot (alpine 3.12.3)
===========================================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

dockle:
WARN    - CIS-DI-0001: Create a user for the container
        * Last user should not be root
INFO    - CIS-DI-0005: Enable Content trust for Docker
        * export DOCKER_CONTENT_TRUST=1 before docker pull/build
INFO    - CIS-DI-0006: Add HEALTHCHECK instruction to the container image
        * not found HEALTHCHECK statement

NO ISSUES DETECTED - IMAGE STATUS OK.
