# Overview

The purpose of this project is simply to track changes in the AWS Landing Zone template.

[latest Release Notes](https://solutions-reference.s3.amazonaws.com/aws-landing-zone/latest/release_notes.html)

### Scheduled Check
This [runs daily on Travis CI](https://travis-ci.org/ozbillwang/aws-landing-zone-initiation).

### Usage

1) Create a new aws account via aws orginaztion (you can add exist account to originaztion as well)

2) On the newly created AWS account, create a role that will be use by Landing Zone
```

export AWS_REGION=us-east-1
# edit templates/assume-role.json with trusted account (master aws account id)
aws iam create-role --role-name AWSCloudFormationStackSetExecutionRole --assume-role-policy-document file://templates/assume-role.json
aws iam attach-role-policy --role-name AWSCloudFormationStackSetExecutionRole --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Remove aws config already provisioned
# (future work is to add exception if aws config already exist)
aws configservice describe-delivery-channels
aws configservice describe-configuration-recorders
aws configservice delete-configuration-recorder --configuration-recorder-name default
aws configservice delete-delivery-channel --delivery-channel-name default
```
