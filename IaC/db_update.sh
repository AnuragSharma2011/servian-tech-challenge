#!/bin/sh
# This script will update/migrate the database using task definition container command.
# this only needs to be run once to prepare the db after terraform apply runs server command on conatiner.
terraform init

SUBNET=$(terraform output standalone_task_subnet)
SG=$(terraform output standalone_task_sg)
CLUSTER_NAME=$(terraform output ecs_cluster_name | sed 's/"//g')
TASK_NAME=$(terraform output prefix | sed 's/"//g')
PUBLIC_IP="ENABLED"

export AWS_DEFAULT_REGION=eu-west-2

aws ecs run-task \
    --task-definition $TASK_NAME \
    --cluster $CLUSTER_NAME \
    --count 1 \
    --launch-type FARGATE \
    --network-configuration '{ "awsvpcConfiguration": {"subnets": [ '$SUBNET' ], "securityGroups": [ '$SG' ], "assignPublicIp": "'$PUBLIC_IP'"}}' \
    --overrides '{ "containerOverrides": [ { "name": "app", "command": ["updatedb", "-s"] } ] }'