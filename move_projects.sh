#!/bin/bash

# Function to move projects
move_projects() {
  local billing_account="$1"
  local project_file="$2"

  while IFS= read -r project_id; do
    project_id=$(echo "$project_id" | tr -d ' ')  # Remove leading/trailing whitespace
    gcloud billing projects link "$project_id" --billing-account="$billing_account"
    if [[ $? -ne 0 ]]; then
      echo "Error moving project $project_id"
      return 1  # Exit with error code
    fi
  done < "$project_file"

  echo "Merge Successful!"
}

# Get user input
read -p "Enter the Billing Account ID you'd like to move your projects to! (e.g., 0X0X0X-0X0X0X-0X0X0X): " billing_account
read -p "Enter the path to the project list file (e.g., projects.txt): " project_file

# Call the function to move projects
move_projects "$billing_account" "$project_file"