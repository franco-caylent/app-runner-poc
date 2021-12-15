# For building locally
docker build --build-arg VERSION=WHATEVER -t spring .
# Building for ECR
docker build --build-arg VERSION=v2 -t your-account-id.dkr.ecr.region.amazonaws.com/yourimage:v2 .

docker push your-account-id.dkr.ecr.region.amazonaws.com/yourimage:v2

# For smoke testing the app
while [ true ]; do echo -n "$(date) "; curl "https://theUrl/"; echo "" ; done