## Overview
This is a set of written instructions to set up and configure the prerequisites required to provision AWS CodePipeline in various AWS Environments

## Prerequisites
### Section 1 : Update the deploy.sh : <br/>
***

The``` deploy.sh``` script is used to Deploy the specified AWS CloudFormation template by creating and then executing a change set </br>
**Step 1**. Open ```deploy.sh``` and update the following</br>
```
CF_STACK_NAME=pge-crm-dev-s3-central-logging-stack
CF_TEMPLATE_FILE_PATH=./s3-logging-bucket-cft.yml
CF_PARAMETERS_FILE_PATH=./s3-logging-bucket-cft-values.json
CF_TAGS_FILE_PATH=../../tags.json
AWS_PROFILE_NAME=ECM_Ops
```
**Step 2**. Update ```CF_STACK_NAME=<Name of the stack which creates the AWS Resource>``` </br>
**Step 3**. Update ```CF_TEMPLATE_FILE_PATH=<Location which the AWS Cloudformation template is stored>```</br>
**Step 4**. Update ```CF_PARAMETERS_FILE_PATH=<Location which the AWS parameter file is stored>```</br>
**Step 5**. Update ```CF_TAGS_FILE_PATH=<Location which the AWS Resource tag detail is stored>```</br>
**Step 6**. Update ```AWS_PROFILE_NAME=<Profile used to execute the CLI Commands>```</br>

### Section 2 :  Provision the prerequisites for CodePipeline by executing the stacks inside the prerequisites folder.
***
 #### 1) kms
  * Open folder ```kms```. Update the ```kms-cft-values.json```
    * Update ```pEnv=<Environment Name for Deployment>```
    * Update ```pComponent=<Component for KMS Key usage>```    
```
   [
        "pEnv=dev",
        "pComponent=all"    
   ]
```     
   * Run the ```deploy.sh``` script using below command to Deploy the specified AWS CloudFormation template by creating and then executing a change set,<br />
    ```sh deploy.sh```
    
#### 2) s3-central-logging-bucket      
  * Open folder ```s3-central-logging```. Update the ```s3-logging-bucket-cft-values.json```
       * Update ```pS3BucketName=<Name of S3 Bucket>```
       * Update ```pVersioning=<Does versioning needs to be enabled? True | false>```
```
   [
    "pS3BucketName=pge-crm-dev-s3-central-logging",
    "pVersioning=false"    
   ]
```
   * Run the ```deploy.sh``` script using below command to Deploy the specified AWS CloudFormation template by creating and then executing a change set,<br />
      ```sh deploy.sh```
#### 3) s3-codepipeline-artifact-bucket 
  * Open folder ```s3-codepipeline```. Update the ```s3-cft-values.json```
       * Update ```pS3BucketName=<Name of S3 Bucket>```
       * Update ```pVersioning=<Does versioning needs to be enabled? True | false>```
       * Update ```pKMSMasterKeyID=<KMS details Created in Step 1>```
 ```
   [
    "pS3BucketName=pge-crm-dev-s3-codepipeline-artifacts",
    "pVersioning=false",
    "pKMSMasterKeyID=/KMS/Key/Crmdev/all/Alias/ARN"    
   ]
 ```
   * Run the ```deploy.sh``` script using below command to Deploy the specified AWS CloudFormation template by creating and then executing a change set,<br />
    ```sh deploy.sh```
    
#### 4) sns-codepipeline
#### Note: We need to the run the SNS-Codepipeline CFT twice 1. Status 2. Approval

  * Open folder ```sns-codepipeline```. Update the ```sns-cft-values.json```
       * Update ```pEmail=<Email id of the User to be notified>```
       * Update ```pTopicName=<Name used to identify the SNS Topic```

Status:
```   
   [  
    "pEmail=abcd@pge.com", 
    "pTopicName=status"    
   ]
```
   Approval:
```
[  
    "pEmail=a2az@pge.com", 
    "pTopicName=approval"    
  ]
```
   * Run the ```deploy.sh``` script using below command to Deploy the specified AWS CloudFormation template by creating and then executing a change set,<br />
      ```sh deploy.sh```
   * Open ```sns-cft-values.json``` and update the ```"pTopicName=approval"```. Run  ```deploy.sh``` script inorder to create another SNS Topic which will be used for CodePipeline approval notification.
