* * * Dockerized Duo Authentication Proxy by Michael Snapp * * * 


- Into - 
The purpose of this project was to create a dockerized appliation for the Duo Authentication Proxy server. The purpose of the Duo Auth server is to provide Duo MFA to services that don't directly integrate with Duo. In order to benefit from Duo Auth Proxy, your service must be able to authenticate to a RADIUS server. In addition, you must be able to adjust the authenticationn timeout on your service to >= 60 seconds. This is because Duo needs time to intercept the authentication request, route it to their servers, push MFA, send response to RADIUS server and then to your your service. 

- Dependenices - 
Docker and Docker-Compose installed 
    There are scripts in the docker_install directory to assist with installation if needed 

- Basic Setup - 

run 
    cd duo-auth-proxy
    docker-compose build 
    docker-compose up 
