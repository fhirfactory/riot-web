
About this app
=================

This app is in React, JavaScript, Nodejs based which can be run without a docker but best to run on docker as Pegacorn apps are containerised with Kubenetes orchestration with docker. This app was originally inspired and forked from matrix client (element-web) which is available at element.io.

How to setup communicate webapp locally and run
==================================================

More extensive guidelines are available at: element-README. For the steps below to get your app running in docker.
First build pegacorn-communicate-matrix-js-sdk:
git clone https://github.com/fhirfactory/pegacorn-communicate-matrix-js-sdk pushd pegacorn-communicate-matrix-js-sdk yarn link yarn install popd
Then similarly with pegacorn-communicate-matrix-react-sdk:
git clone https://github.com/fhirfactory/pegacorn-communicate-matrix-react-sdk.git pushd pegacorn-communicate-matrix-react-sdk yarn link yarn link matrix-js-sdk yarn install popd
Finally, build and start pegacorn-communicate-app-web itself:
git clone https://github.com/fhirfactory/pegacorn-communicate-app-web pushd pegacorn-communicate-app-web yarn link matrix-js-sdk yarn link matrix-react-sdk yarn install yarn start

Run e2e test
=====================

Make sure you've got your pegacorn communicate development server running (by doing yarn start in pegacorn-communicate-app-web), and then in this project, run yarn run e2etests. See test/end-to-end-tests/README.md for more information.

Troubleshooting issues
==============================

If you encounter issue with error code 40xx, when you run yarn start or npm start, kindly check your environment variable and make sure C:\Windows\System32 is listed.
If it still does not run, remove node_modules from react-sdk, js-sdk, and app-web projects and re-install them and run app-web project.
Make sure you link these projects as specified in incremental order to make them work otherwise it may not work properly if linking is a bit of issue, you can try unlinking projects by running: yarn unlink app-name in their relevant directory just as you linked them before then follow the guideline above to relink them back, re-install npm and run project.
Make sure config.sample.json is copied to config.json file.
