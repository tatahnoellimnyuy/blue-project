# Cloudflare Terraform Resources Generator

This Bash script uses the `cf-terraforming` tool to generate Cloudflare Terraform resources for a given Cloudflare account. The resources are organized into folders and files based on the zones.

## Requirements

- Bash
- `cf-terraforming` (version 1.6.0 or later)
- `jq`
- Cloudflare API Key (provided via environment variable `CF_API_KEY`)

## Usage

1. Ensure `cf-terraforming` and `jq` are installed.
2. Set your Cloudflare API Key as an environment variable:
   ```bash
   export CF_API_KEY=your_api_key
```
## run the script
```bash
./cf-terraforming-gen.sh
```

## DESCRIPTION
- Checks if cf-terraforming is installed. If not, it provides an error message and exits.
- Checks if the Cloudflare API Key is set as an environment variable. If not, it provides an error message and exits.
- Creates a directory (terraform_resources) to store Terraform resources.
- Fetches Cloudflare zones using cf-terraforming.
- Loops through each zone:
- Extracts the zone name and top-level domain.
- Creates a directory for the top-level domain if it doesn't exist.
- Generates Terraform resources for the zone and saves them to a file.
- Outputs a success message.