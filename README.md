###### For the administrators out there dealing with those pesky billing account consolidations (200+ projects associated with a billing account nightmares)

## This is a simple script that automates moving projects to a billing account. In order to successfully execute this script, you are required to be a billing administrator and the project owner.

### Instructions :

1. Create a text file containing the list of projects (PROJECT_ID's) that you want to move.
2. Make the shell script an executable: `chmod +x move_projects.sh`
3. Run the script: `./move_projects.sh`
4. The script will prompt you for the `Billing Account ID` and path to the project list file. It'll then execute the gcloud commands to move the projects, and display the appropriate success or error messages.

The intent is to run this from the GCP cloud shell to make this as simple as possible.

### Issues :

Depending on your current quota, you may run into a `type.googleapis.com/google.rpc.QuotaFailure` error in which you'll have to request a [billing quota increase](https://support.google.com/code/contact/billing_quota_increase). Thankfully this script will point out this error however, it's important to note.

### Notes :

You can run `gcloud projects list --sort-by=projectId | grep -i "project_id" | awk -F': ' '{print $2}' > projects.txt` to convert your list of projects into a txt file that follows the format the script likes. In addition, if you have a ton of projects you're moving and you don't want to use vi to check each line, use `wc -l <filename>` to count the number of lines (which will represent projects).
