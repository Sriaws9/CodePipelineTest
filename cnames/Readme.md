
# CNames

## Directory structure
```
    /
    ├── pipeline                          # Contains AWS Code Pipeline specific  files        
    |                   
    ├── README.md                         # README file
    |                
    ├──  aws-cfn-private-cname.yml         # Contains list of the images           
    |    
    └── cnames-values.json                 # Contains the environemnt variables   
```

## Follow the below steps for new CName creation
## Creating Code Pipeline for the CName creation.
**Step 1**: Create a feature branch and clone this repository to your local machine and navigate to the git folder<br />
```
git clone -b feature\CName git@github.com:pgetech/pge-crm-ecm-cloud-infra-ci.git
cd pge-crm-ecm-cloud-infra-ci/
```

**Step 2**: Update the deploy.sh : <br/>
The``` deploy.sh``` script is used to Deploy the specified AWS CloudFormation template by creating and then executing a change set </br>

**Step 3**. Open ```deploy.sh``` under the folder pipeline and update the following</br>
```
CF_STACK_NAME=dctm-d2dev-cname-pipeline-stack
CF_TEMPLATE_FILE_PATH=./cname-pipeline-cft.yml
CF_PARAMETERS_FILE_PATH=./cname-pipeline-cft-values.json
CF_TAGS_FILE_PATH=../../tags.json
AWS_PROFILE_NAME=ECM_Ops
```
**Step 4**. Update ```CF_STACK_NAME=<Name of the stack which creates CodePipeline>``` </br>
**Step 5**. Update ```CF_TEMPLATE_FILE_PATH=<Location which the CodePipeline Cloudformation template is stored>```</br>
**Step 6**. Update ```CF_PARAMETERS_FILE_PATH=<Location which the CodePipeline parameter file is stored>```</br>
**Step 7**. Update ```CF_TAGS_FILE_PATH=<Location which the CodePipeline tag detail is stored>```</br>
**Step 8**. Update ```AWS_PROFILE_NAME=<Profile used to execute the CLI Commands>```</br>
**Step 9**. Save the shell script and Run the deploy.sh script using below command <br> ```sh deploy.sh```</br>


## How to create cnameficate using AWS CodePipeline?

There would be one single pipeline created above which creates multiple CNames across multiple environments. Create a git feature branch for which we need to create the CName

Skip the below first two steps (step 1 and step 2) if you have already created and clone the feature branch as part of the creating new pipeline

**Step 1**: Make sure that you have all the prerequisites in place. For details, please refer the pre-requisites section above <br />
**Step 2**: Create a feature branch (ex: feature\CName) from main and clone the repository to your local machine and navigate to the git folder<br />
```
git clone -b feature\CName git@github.com:pgetech/pge-crm-ecm-cloud-infra-ci.git
cd pge-crm-ecm-cloud-infra-ci/
```

**Step 3**: Open the configuration file ``` cname-values.json ``` update the name of the desired FQDN Name <br />

     Update ```cnames-values.json``` with the details required.
<pre>
[
    "pStackName=Stack Name",
    "pAppName=Application-Name",    
    "pAlias=FQDN-Name",
    "pTargetResource=ALB-Name"
]
</pre>
Sample Json details:
<pre>
[
    "pStackName=pge-ecm-crm-dctmdev-cname-cfn",
    "pAppName=dctmdev-cname",    
    "pAlias=dctmdev.nonprod.pge.com",
    "pTargetResource=internal-k8s-ecmdctm-1e4691fe4c-1152987210.us-west-2.elb.amazonaws.com"
]
</pre>
**Step 4**: Save the file and commit and push the changes to the feature branch ```feature\CName```.

```
git add .
git commit -m "Creating new CName <name> on <ENV>"
git push
```
**Step 5**: Create a pull request from the feature branch ```feature\CName``` to branch depends on the environemnt to which the CName would be created and wait for the pull request reviewer to approve and merge the pull request <br />

**Step 6**: Once the pull request is merged from feature branch to enviornment branch, create another pull request to merge the changes to ```main branch``` which triggers the CName  CodePipeline automatically <br />

**Step 7**: Go to the AWS console and review the change and approve the pipeline ``` pge-crm-CName-CodePipeline ```<br />

**Step 8**: After the CName is created successfully, you will receive an email <br />
