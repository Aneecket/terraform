Lambda function's code is zipped and stored in S3 bucket here: `noon-lambda-zip-storage-bucket` in `eu-central-1`

Lambda functions can be uploaded either as direct zip file or s3 bucket URI to the zipped location.

To update the lambda function, download the zip's to this folder, unzip, update, zip  and do a terraform plan and apply.

Why not changing the location to S3 URI ?

- It will cause all Lambda functions to change during apply. 

- Need to check if the location is updated it will create an invocation.