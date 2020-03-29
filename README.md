# Overview

The purpose of this project is simply to track changes in the AWS Landing Zone template.

[latest Release Notes](https://solutions-reference.s3.amazonaws.com/aws-landing-zone/latest/release_notes.html)

### Scheduled Check
This [runs daily on Travis CI](https://travis-ci.org/ozbillwang/aws-landing-zone-initiation).

### Usage

```
# edit templates/assume-role.json with trusted account (master aws account id)
aws iam create-role --role-name AWSCloudFormationStackSetExecutionRole --assume-role-policy-document file://templates/assume-role.json
aws iam attach-role-policy --role-name AWSCloudFormationStackSetExecutionRole --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```
