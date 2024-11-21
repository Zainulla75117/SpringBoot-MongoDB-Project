#!/bin/bash

# Set Slack Webhook URL (from your Slack incoming webhook setup)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"
SLACK_CHANNEL="#training"  # Slack channel to send notifications to

# Set file paths for the reports
OWASP_REPORT="/home/ubuntu/owasp-reports/$BUILD_NUMBER.xml"  # Adjust with actual path
TRIVY_REPORT="/home/ubuntu/trivy-reports/$BUILD_NUMBER.html"  # Adjust with actual path

# Function to send Slack notification
send_slack_message() {
    local message=$1
    curl -X POST -H 'Content-type: application/json' \
    --data "{\"channel\": \"$SLACK_CHANNEL\", \"text\": \"$message\"}" \
    $SLACK_WEBHOOK_URL
}

# Function to upload a file to Slack
upload_file_to_slack() {
    local file_path=$1
    local file_name=$2
    local title=$3

    curl -X POST -F file=@$file_path \
        -F "initial_comment=$title" \
        -F "channels=$SLACK_CHANNEL" \
        -H "Authorization: Bearer YOUR_SLACK_OAUTH_ACCESS_TOKEN" \
        https://slack.com/api/files.upload
}

# Send notification for OWASP Dependency-Check
send_slack_message "OWASP Dependency-Check completed successfully! :white_check_mark:"

# Upload OWASP report to Slack
upload_file_to_slack "$OWASP_REPORT" "dependency-check-report.xml" "OWASP Dependency-Check Report"

# Send notification for Trivy Scan
send_slack_message "Trivy Scan completed successfully! :white_check_mark:"

# Upload Trivy report to Slack
upload_file_to_slack "$TRIVY_REPORT" "trivy-report.html" "Trivy Scan Report"

echo "Reports have been sent to Slack successfully."
