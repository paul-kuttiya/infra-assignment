.PHONY: deploy destroy deploy-serverless make-request-serverless destroy-serverless deploy-eks make-request-eks destroy-eks

### serverless ###
deploy-serverless:
	$(MAKE) -C serverless deploy --no-print-directory

make-request-serverless:
	@$(MAKE) -C serverless make-request --no-print-directory

destroy-serverless:
	$(MAKE) -C serverless destroy --no-print-directory

### EKS ###
deploy-eks:
	$(MAKE) -C eks deploy --no-print-directory

make-request-eks:
	@$(MAKE) -C eks make-request --no-print-directory

destroy-eks:
	$(MAKE) -C eks destroy --no-print-directory
