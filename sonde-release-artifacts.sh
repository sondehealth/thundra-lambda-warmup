#!/bin/bash
ARTIFACTS_BUCKET=$(cat sonde-thundra-lambda-warmup-cloudformation-template.yaml | yq '.Resources.ThundraLambdaWarmupFunction.Properties.Code.S3Bucket' -r)
RELEASE_PATH=$(cat sonde-thundra-lambda-warmup-cloudformation-template.yaml | yq '.Resources.ThundraLambdaWarmupFunction.Properties.Code.S3Key' -r)

mvn clean install

if [ $? -eq 0 ]; then 
    echo "Release Bucket: ${ARTIFACTS_BUCKET}"
    echo "Release Path: ${RELEASE_PATH}"
    aws s3 cp target/thundra-lambda-warmup-* s3://${ARTIFACTS_BUCKET}/${RELEASE_PATH}/
    aws s3 cp sonde-thundra-lambda-warmup-cloudformation-template.yaml s3://${ARTIFACTS_BUCKET}/${RELEASE_PATH}/
    if [ $? -eq 0 ]; then
         echo "thundra lambda is uploaded to sonde-release-artifacts"
    fi
fi
