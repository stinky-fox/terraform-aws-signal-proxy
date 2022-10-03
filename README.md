# terraform-aws-signal-proxy
Deploy a Signal TLS Proxy with Terraform running AWS

# Usage

## Define variables in any file. 
### In the example we will be using a file with name *varfile*. Following vars must be defined:
```
awsAccessKey="<YOUR AWS ACCESS KEY>"
awsSecretKey=<"YOUR AWS SECRET KEY">
awsRegion="<REGIOn YOU WANT TO HOST A PROXY>"
myIP="<YOUR IP TO EXPLICITLY ALLOW SSH CONNECTION>"
publicZoneId="<AN ID OF YOUR PUBLIC HOSTED ZONE IN ROUTE 53>"
instanceName="<DEFINE THE SUBDOMAIN NAME FOR THIS SIGNAL PROXY. BY DEFAULT A TRIBUTE TO MONICA BELUCCI's ROLE (PERSEPHONE) IN THE MATRIX WILL BE USED>"
```
### Open user-data.sh script and map a variable. Before mapping the variable, make sure to check vars.tf file
```
export FQDN="<FULL FQDN OF THIS SIGNAL PROXY>"
```
### Add RSA SSH key

By default, terraform will look in the project's folder for key-file with a name **id_rsa.pub**. Can point to any other if needed via the variable **publicKeyPath**

## Run 
```
terraform init
terraform apply -var-file varfile
```
## Let peeps know that you are running the proxy

Share your URL with others:
```
https://signal.tube/#<your_domain_name>
```
Sharing is caring!

## Original blogpost
https://signal.org/blog/run-a-proxy/
