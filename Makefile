init:
	docker-compose run terraform init

plan:
	docker-compose run terraform plan -out terraform.plan

apply:
	docker-compose run terraform apply terraform.plan

output:
	docker-compose run terraform output

refresh:
	docker-compose run terraform apply -refresh-only

update_db:
	cd IaC && ./db_update.sh

destroy:
	docker-compose run terraform destroy -auto-approve

