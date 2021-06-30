# pge-crm-ecm-cloud-infra-ci

This git repository contains the Cloudformation templates which creates AWS CodePipeline and provision S3, EFS, RDS and it's components for all the 4 environments (dev, tst, qa and prod)

For S3 there is one Pipeline which provisions three buckets.
For RDS there is one Pipeline which provisions one RDS aurora serverless server.
For EFS there is one Pipeline which provisions one  EFS Filesystem.

Pipeline configured with Webhook filters (specific files) for each resource CFN and values file.

Note: All the CFT's are following SAF 2.0.

### Built With

* [AWS CloudFormation](https://aws.amazon.com/cloudformation/)
* Shell Script

### AWS Developer Tools Used

* [AWS CodePipeline](https://aws.amazon.com/codepipeline/)
* [AWS CodeBuild](https://aws.amazon.com/codebuild/)

### Directory Layout

```
    /
    ├── efs                      # Contains cft.yml and values.json and deploy.sh files for Elastic File System
    |                  
    ├── prerequisites            # Contains CloudFormation Templates for CodePipeline prerequisites
    |                   
    ├── rds                      # Contains cft.yml and values.json and deploy.sh files for RDS Aurora PostgreSQL 
    |                                         
    ├── s3                       # Contains cft.yml and values.json and deploy.sh files for S3
    |                   
    ├── .gitignore               # Contains untracked files
    |                
    ├── README.md                # README file
    |
    └── tags.json                # Tags used to attach while creating the stack
```


