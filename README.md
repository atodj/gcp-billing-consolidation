###### For the administrators out there dealing with those pesky billing account consolidations (200+ projects associated with a billing account nightmares)

# This is a simple script that automates moving projects to a billing account. In order to successfully execute this script, you are required to be a billing administrator and the project owner.

Instructions :

1. Create a text file containing the list of projects (PROJECT_ID's) that you want to move.
2. Make the shell script an executable: `chmod +x move_projects.sh`
3. Run the script: `./move_projects.sh`
4. The script will prompt you for the `Billing Account ID` and path to the project list file. It'll then execute the gcloud commands to move the projects, and display the appropriate success or error messages.

The intent is to run this from the GCP cloud shell to make this as simple as possible.

Issues :

Depending on your current quota, you may run into a `type.googleapis.com/google.rpc.QuotaFailure` error in which you'll have to request a [billing quota increase](https://support.google.com/code/contact/billing_quota_increase). Thankfully this script will point out this error however, it's important to note.