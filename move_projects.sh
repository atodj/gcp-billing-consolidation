#!/bin/bash

# Function to move projects
move_projects() {
  local billing_account="$1"
  local project_file="$2"

  while IFS= read -r project_id; do
    project_id=$(echo "$project_id" | tr -d ' ')  # Remove leading/trailing whitespace

    # Checks if the project is already linked to the billing account
current_billing_account=$(gcloud beta billing projects describe "$project_id" --format="value(billingAccountName)")

# Extract only the billing account ID (assuming it's at the end of the string)
current_billing_id=$(echo "$current_billing_account" | rev | cut -d/ -f1 | rev) 

if [[ "$current_billing_id" == "$billing_account" ]]; then
  echo "Project $project_id is already linked to billing account $billing_account. Skipping..."
  continue
fi

    # Move the project if it's not already linked
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