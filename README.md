## About this app
This app is in React, JavaScript, Nodejs based which can be run without a docker but best to run on docker as Pegacorn apps are containerised with Kubenetes orchestration with docker. This app was originally inspired and forked from element application which is available at element.io.
## How to setup lingo web application locally and run
More extensive guidelines are available at: `element-README`. For the steps below to get your app running in docker.

First build `matrix-js-sdk`:

``` bash
git clone https://github.com/fhirfactory/pegacorn-communicate-matrix-js-sdk
pushd matrix-js-sdk
yarn link
yarn install
popd
```
Then similarly with `matrix-react-sdk`:

```bash
git clone https://github.com/fhirfactory/pegacorn-communicate-matrix-react-sdk.git
pushd matrix-react-sdk
yarn link
yarn link matrix-js-sdk
yarn install
popd
```

Finally, build and start Element itself:

```bash
git clone https://github.com/fhirfactory/pegacorn-communicate-app-web
cd element-web
yarn link matrix-js-sdk
yarn link matrix-react-sdk
yarn install
yarn start
```
## Run e2e test
Make sure you've got your Lingo development server running (by doing yarn start in pegacorn-communicate-app-web), and then in this project, run yarn run e2etests. 
See test/end-to-end-tests/README.md for more information.