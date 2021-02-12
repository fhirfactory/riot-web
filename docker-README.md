
<!-- docker build . --rm --no-cache --build-arg HTTP_PROXY=http://proxy.test.act.gov.au:9090 --build-arg IMAGE_BUILD_TIMESTAMP="%date% %time%" -t pegacorn-communicate-app-web:1.1.0 -->

Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), you can provide input using your keyboard while the output is logged to your terminal.

## Useful links
1. https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
2. https://hub.docker.com/r/vectorim/element-web
3. Docker overview: https://docs.docker.com/get-started/overview/

