CF_STACK_NAME=pge-crm-dev-kms-all
CF_TEMPLATE_FILE_PATH=./kms-cft.yml
CF_PARAMETERS_FILE_PATH=./kms-cft-values.json
CF_TAGS_FILE_PATH=../../tags.json
AWS_PROFILE_NAME=ECM_Ops

echo "Checking for Cloudformation stack changes......"
aws cloudformation deploy \
	--stack-name $CF_STACK_NAME \
	--template-file $CF_TEMPLATE_FILE_PATH \
	--parameter-overrides file://$CF_PARAMETERS_FILE_PATH \
	--tags file://$CF_TAGS_FILE_PATH \
	--capabilities CAPABILITY_NAMED_IAM \
	--no-execute-changeset

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

if [[ "no" == $(ask_yes_or_no "Do you want to deploy the above changes?") || \
      "no" == $(ask_yes_or_no "Are you *really* sure?") ]]
then
    echo "Skipping Cloudformation Deployment"
    exit 0
fi

echo "Updating/Creating Cloudformation stack....."
aws cloudformation deploy \
	--stack-name $CF_STACK_NAME \
	--template-file $CF_TEMPLATE_FILE_PATH \
	--parameter-overrides file://$CF_PARAMETERS_FILE_PATH \
	--tags file://$CF_TAGS_FILE_PATH \
	--capabilities CAPABILITY_NAMED_IAM 

	
echo -e "\033[32mUpdated/Created Cloudformation stack!\033[m"