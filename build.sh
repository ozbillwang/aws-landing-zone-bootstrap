#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# API_TOKEN

# set -ex

latest=`docker run --rm alpine/xml sh -c 'curl -s https://s3.amazonaws.com/solutions-reference/aws-landing-zone/latest/aws-landing-zone-initiation.template |yq -r .Outputs.LandingZoneSolutionVersion.Value'`

echo ${latest}

sum=0

for tag in `git tag`
do
  if [ ${tag} == ${latest} ];then
    sum=$((sum+1))
  fi
done

if [[ ( $sum -ne 1 ) || ( ${REBUILD} == "true" ) ]];then
  echo "need update the template"
  if [[ "$TRAVIS_BRANCH" == "master" ]]; then

    curl -sfLo aws-landing-zone-initiation.template https://s3.amazonaws.com/solutions-reference/aws-landing-zone/latest/aws-landing-zone-initiation.template
    curl -sfLo release_notes.html https://solutions-reference.s3.amazonaws.com/aws-landing-zone/latest/release_notes.html

    # add updates
    git add aws-landing-zone-initiation.template
    git add release_notes.html
    git commit -m "Bump to ${latest}"
    # push with tag
    git config user.name "ci"
    git config user.email "ci"
    echo "Create & Push Tag"
    git tag ${latest}
    git push -u origin master --tags
  fi

fi
