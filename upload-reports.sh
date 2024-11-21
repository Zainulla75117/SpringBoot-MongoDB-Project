#!/bin/bash

# Set variables
SLACK_TOKEN="xoxb-8057080353251-8054413755125-u9BC7LdWCu1JM2dWDMTRfh0t"
CHANNEL="#training"
FILE_PATH="/home/ubuntu/trivy-reports/$BUILD_NUMBER.html"
FILE_NAME="$BUILD_NUMBER.html"
COMMENT="Here is the file upload"

# Upload file to Slack using the Slack API
curl -F file=@${FILE_PATH} \
     -F "filename=${FILE_NAME}" \
     -F "title=File Upload" \
     -F "initial_comment=${COMMENT}" \
     -F "channels=${CHANNEL}" \
     -H "Authorization: Bearer ${SLACK_TOKEN}" \
     https://slack.com/api/files.upload
