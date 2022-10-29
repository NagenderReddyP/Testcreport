#!/usr/bin/bash

#URL to GIT Repository
GIT_REPO="https://github.com/esteban-santiago/ansible-pull.git"
#Get token to connect to AWS Meta-Data API
AWS_METADATA_API="http://instance-data/latest"
TOKEN=$(curl -s -X PUT "$AWS_METADATA_API/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTACE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" $AWS_METADATA_API/meta-data/instance-id)
PLAYBOOK=$(aws ec2 describe-tags --region eu-west-1 --filters "Name=resource-id,Values=$INSTACE_ID" "Name=key,Values=Name" --output text | cut -f5).yml

sudo ansible-pull -U $GIT_REPO $PLAYBOOK
