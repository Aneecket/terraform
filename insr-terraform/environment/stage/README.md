## Objective

1. Modularize the existing terraform code.
2. Enhance the code reusability for multi environment setup
---

## Feature

1. Statefile is stored in S3 bucket
2. Locking is done via dynamodb
3. Statefile versioning is done by enabling bucket versioning
---

## Version

1. Terraform version: [v1.2.2]
2. Providers: AWS provider (3.31.0 or latest). For more on providers refer [here](https://www.terraform.io/docs/language/providers/index.html)
---

