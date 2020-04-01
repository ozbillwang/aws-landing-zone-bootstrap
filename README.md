# Overview

1) simply to track changes in the AWS Landing Zone template.
2) init steps to set up aws landing zone.

[latest Release Notes](https://solutions-reference.s3.amazonaws.com/aws-landing-zone/latest/release_notes.html)

### Scheduled Check
[Runs daily on Travis CI to check if there are new templates](https://travis-ci.org/ozbillwang/aws-landing-zone-initiation).

If there is, update cfn template in repo with new release tag.

### Usage

1) Create a new aws account via aws orginaztion (you can add exist account to originaztion as well)

2) On the newly created AWS account, create a role that will be use by Landing Zone
```

export AWS_REGION=us-east-1
# edit templates/assume-role.json with trusted account (master aws account id)
aws iam create-role --role-name AWSCloudFormationStackSetExecutionRole --assume-role-policy-document file://templates/assume-role.json
aws iam attach-role-policy --role-name AWSCloudFormationStackSetExecutionRole --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Below task is optional.
# Remove aws config already provisioned
# (future work is to add exception if aws config already exist)
aws configservice describe-delivery-channels
aws configservice describe-configuration-recorders
aws configservice delete-configuration-recorder --configuration-recorder-name default
aws configservice delete-delivery-channel --delivery-channel-name default
```

3) repeat task 1 and 2 three times for these accounts: 

```
Shared Services Account
Log Archive Account
Security Account
```

4) apply the cfn template:

https://s3.amazonaws.com/solutions-reference/aws-landing-zone/latest/aws-landing-zone-initiation.template

It will fail.

5) remove uselss regions

In my case, I got error

```
Region ap-east-1 is not supported: ClientError
```
So I remove above region from the file [manifest.yaml](_aws-landing-zone-configuration.zip/manifest.yaml)

6) change source of codepipeline `AWS-Landing-Zone-CodePipeline` from s3 to git (github or bitbucket cloud)

7) trigger the codepipeline again.

### reference

[aws landing zone user guide](http://www.awslandingzone.com/guides/aws-landing-zone-user-guide.pdf)

[aws landing zone developer guide]( http://www.awslandingzone.com/guides/aws-landing-zone-developer-guide.pdf)

[aws landing zone implementation guide](http://www.awslandingzone.com/guides/aws-landing-zone-implementation-guide.pdf)
