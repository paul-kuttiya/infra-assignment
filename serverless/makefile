# Makefile for AWS Lambda function deployment

# Lambda function details
LAMBDA_FUNCTION_NAME = epoch-time-lambda
ZIP_FILE_NAME = lambda_function.zip
HANDLER_FILE = index.py

.PHONY: clean zip aws-deploy

# Default target
deploy: clean zip aws-deploy save-api-endpoint

aws-deploy:
	cd ./infra ; \
	terraform init ; \
	terraform plan ; \
	terraform apply --auto-approve
	@echo "\nremoving zip files..."
	make clean

save-api-endpoint:
	cd ./infra ; \
	terraform output api_endpoint | tr -d '"' > api_endpoint.txt

make-request:
	@@curl $$(cat ./infra/api_endpoint.txt)

# Clean up
clean:
	@@rm -rf $(ZIP_FILE_NAME)

# Create a ZIP file for Lambda deployment
zip:
	zip -r $(ZIP_FILE_NAME) $(HANDLER_FILE)

destroy: clean zip
	cd ./infra ; \
	terraform destroy --auto-approve
	@echo "\nremoving zip files..."
	make clean
