mvn clean install
if [ $? -eq 0 ]; then 
    aws s3 cp target/thundra-lambda-warmup-* s3://sonde-release-artifacts/thundra-lambda-warmup/1.0.0/
    aws s3 cp sonde-thundra-lambda-warmup-cloudformation-template.yaml s3://sonde-release-artifacts/thundra-lambda-warmup/1.0.0/thundra-lambda-warmup-cloudformation-template.yaml
    if [ $? -eq 0 ]; then
         echo "thundra lambda is uploaded to sonde-release-artifacts"
    fi
fi
