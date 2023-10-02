E#!/bin/bash

# Check if cf-terraforming is installed
if ! command -v cf-terraforming &> /dev/null; then
    echo "cf-terraforming is not installed. Please install it."
    exit 1
fi

# Check if the API key is provided as an environment variable
if [ -z "$CF_API_KEY" ]; then
    echo "CF_API_KEY environment variable is not set. Please set it."
    exit 1
fi

# Create a directory to store Terraform resources
mkdir -p terraform_resources

# Fetch Cloudflare zones
zones=$(cf-terraforming --api-key "$CF_API_KEY" zones)

# Loop through each zone
for zone in $zones; do
    # Extract zone name and TLD
    zone_name=$(echo "$zone" | jq -r '.name')
    tld=$(echo "$zone_name" | awk -F'.' '{print $NF}')

    # Create a directory for the TLD if it doesn't exist
    mkdir -p "terraform_resources/$tld"

    # Generate Terraform resources for the zone and save them to a file
    cf-terraforming --api-key "$CF_API_KEY" --zone "$zone_name" cloudflare_record |
        jq -c '.[]' |
        jq -s '. | sort_by(.name)' |
        jq -r -c '.[]' > "terraform_resources/$tld/$zone_name.tf"
done

echo "Terraform resources generated in the terraform_resources directory."
