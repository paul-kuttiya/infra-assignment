.PHONY: create-cluster install-helm get-deployment get-services destroy docker-login docker-build docker-push

# public docker repo
DOCKER_IMAGE_NAME = pkuttiya/epoch-time-api
DOCKER_IMAGE_TAG = latest

create-cluster:
	eksctl create cluster \
	  --name infra-api \
	  --region us-east-1 \
	  --nodegroup-name infra-api-nodegroup \
	  --node-type t3.medium \
	  --nodes 1 \
	  --nodes-min 1 \
	  --nodes-max 3

install-helm:
	cd helm && helm install epoch-api .

get-deployment:
	kubectl get deployment epoch-api

get-services:
	kubectl get services epoch-api

destroy:
	eksctl delete cluster --name infra-api --region us-east-1

docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

docker-push:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

make-request:
    @ELB=$$(kubectl get service epoch-api -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\n"}'); \
    echo "ELB Hostname: $$ELB"; \
    curl $$ELB:8080
