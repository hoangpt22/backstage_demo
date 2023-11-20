# [Backstage](https://backstage.io) Terraform demo

This is your newly scaffolded Backstage App, Good Luck!

## Local environment
To start the app, set these environment variables:

-your AWS credentials
-github_token
-github_client_id
-github_client_secret
-access_key_id
-secret_access_key
-bucket_name

Then run:

docker-compose build
docker build -t backstage/terraform-cli ./terraform
docker-compose up -d
docker-compose run --rm app bash
docker run --rm -it --workdir /app \
	--entrypoint bash -v $${PWD}/terraform:/app \
	--env-file .env \
	backstage/terraform-cli
This will build the docker image and start the containers for the application and the database, after the build finishes you can visit the application at:
localhost:3000


## AWS deploy
To deploy your Backstage application on AWS with Terraform you must first set these env variables in your local machine:
-github_token
-github_client_id
-github_client_secret
-access_key_id
-secret_access_key
-bucket_name

To let Terraform work, you need to manually create an S3 bucket in which Terraform will save the state of your infrastructure.  
Once created, save the bucket name by replacing the `{{BUCKET-NAME}}` placeholder in the `terraform / terraform.tf` file.

The setup is now complete. To deploy, enter the terraform container by typing `make terraform-cli` and then:
```sh
terraform init
terraform apply
```

As soon as Terraform is done, build your Backstage Docker image and push it on the Elastic Container Registry.  
To build and tag the image run:
```sh
docker build . -f packages/backend/Dockerfile --tag backstage
docker tag backstage {{AWS-ACCOUNT-ID}}.dkr.ecr.ap-southeast-2.amazonaws.com/backstage-image:1.0.0
```

Then login on ECR with:
```sh
  aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin {{AWS-ACCOUNT-ID}}.dkr.ecr.ap-southeast-2.amazonaws.com
```

To push the image run:
```sh
docker push {{AWS-ACCOUNT-ID}}.dkr.ecr.ap-southeast-2.amazonaws.com/backstage-image:1.0.0
```
> remember to replace `{{AWS-ACCOUNT-ID}}` with your AWS account id!

After that, you should wait a few minutes for ECS to be up and running, then you can visit the application by typing the URL of your Load Balancer.

Enjoy!