#!/bin/bash
set -ex


authentication_response="$(curl -u "$pcloudy_username:$pcloudy_access_key" https://$PCLOUDY_CLOUDURL/api/access)"
authToken=$(echo "$authentication_response" | jq -r .result.token)
curl -X POST -F "file=@$upload_path" -F "source_type=raw" -F "token=$token" -F "filter=all" https://$PCLOUDY_CLOUDURL/api/upload_file | jq -j '.result.file' | envman add --key PCLOUDY_APP_NAME
