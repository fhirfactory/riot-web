## Set environment variables
$env:REACT_APP_AZURE_TENANT="<Get from lastpass.com>"
$env:REACT_APP_AZURE_APPLICATION_ID="<Get from lastpass.com>"
$env:REACT_APP_AZURE_SIGN_IN_POLICY="<Get from lastpass.com>"
$env:REACT_APP_API_BASE_PATH="<Insert API path, e.q. <http://localhost:9000/api/v1>"
$env:REACT_APP_QR_BASE_PATH="<insert url: eq. https://health.act.gov.au/ACTCOVIDSAFE>"
$env:REACT_APP_GLN_PREFIX="<insert-value>"
$env:REACT_APP_APP_TITLE="Lingo Web App"
$env:REACT_APP_DEFAULT_LOCATION_STATE="ACT"
$env:REACT_APP_API_KEY="<Get from lastpass.com>"
$env:REACT_APP_IMAGE_BUILD_TIMESTAMP='20210114-173000'
$env:HTTPS="true"
## How to build docker image and run 
To Be Continued(work in progress) 
Refer to : https://medium.com/bb-tutorials-and-thoughts/dockerizing-react-app-with-nodejs-backend-26352561b0b7 

In a Windows Command Prompt (due to the %date% %time% variable substitution - change this for other environments)

docker build . --rm --no-cache --build-arg HTTP_PROXY=http://proxy.test.act.gov.au:9090 --build-arg IMAGE_BUILD_TIMESTAMP="%date% %time%" -t lingo-web:1.1.0

docker run -e REACT_APP_AZURE_TENANT="<Get from lastpass.com>" -e REACT_APP_AZURE_APPLICATION_ID="<Get from lastpass.com>" -e

REACT_APP_AZURE_SIGN_IN_POLICY="<Get from lastpass.com>" -e REACT_APP_API_BASE_PATH="http://localhost:9000/api/v1" -e

REACT_APP_QR_BASE_PATH="https://health.act.gov.au/ACTCOVIDSAFE" -e REACT_APP_GLN_PREFIX="<insert-value>" -e REACT_APP_APP_TITLE="Lingo Web App" -e REACT_APP_DEFAULT_LOCATION_STATE="ACT" -e REACT_APP_API_KEY="<The same random string as used by the API>" -e HTTPS="true" -p 3000:3000 lingo-web:1.1.0

# Pushing to Azure Container Registry ( please ensure the tag is unique to avoid deployment issues)
docker tag lingo-web-1.0.0 lingowebprd.azurecr.io/lingo-web:1.1.0
docker login lingo-webprd.azurecr.io -u lingowebprd -p <Get from lastpass.com>
dicker push lingo-web.azurecr.io/lingo-web:1.1.0

## To view Azure Container Registry contents
az acr repository list --name lingo-webprd --output table -u lingowebprd -p '<Get from lastpass.com>'
az acr repository show-tags --name lingo-webprd --repository pegacorn-communicate-app-web --orderby time_desc --output tsv -u lingowebprd -p '<Get from lastpass.com>'
