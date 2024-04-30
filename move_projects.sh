#!/bin/bash

# Function to move projects
move_projects() {
  local billing_account="$1"
  local project_file="$2"

  while IFS= read -r project_id; do
    project_id=$(echo "$project_id" | tr -d ' ')  # Removes leading/trailing whitespace

    # Checks if the project is already linked to the billing account
    current_billing_account=$(gcloud beta billing projects describe "$project_id" --format="value(billingAccountName)")
    if [[ "$current_billing_account" == "$billing_account" ]]; then
      echo "Project $project_id is already linked to billing account $billing_account. Skipping..."
      continue
    fi

    # Moves the project if it's not already linked
    gcloud billing projects link "$project_id" --billing-account="$billing_account"
    if [[ $? -ne 0 ]]; then
      echo "Error moving project $project_id"
      return 1  # Exits with error code
    fi
  done < "$project_file"

  echo "Merge Successful!"
}

# Gets user input
read -p "Enter the Billing Account ID you'd like to move your projects to! (e.g., 0X0X0X-0X0X0X-0X0X0X): " billing_account

# Checks the if Billing Account ID has the correct format
if [[ ! "$billing_account" =~ ^[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}$ ]]; then
  echo "Error: Invalid Billing Account ID format."
  exit 1
fi

read -p "Enter the path to the project list file (e.g., projects.txt): " project_file

# Checks if the project file exists and is readable
if [[ ! -f "$project_file" || ! -r "$project_file" ]]; then
  echo "Error: Project file '$project_file' does not exist or is not readable."
  exit 1
fi

# Call the function to move projects
move_projects "$billing_account" "$project_file"
