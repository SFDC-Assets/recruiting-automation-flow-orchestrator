# Create the demo org
sfdx shane:org:create -f config/project-scratch-def.json -d 3 -s --wait 60 --userprefix flow -o orchestrator.demo

# Push the metadata into the new scratch org.
sfdx force:source:deploy -p force-app
sfdx force:source:deploy -p orchestrator

# Assign user the permset
sfdx force:user:permset:assign -n Recruiting_Manager

# Set the default password.
sfdx shane:user:password:set -g User -l User -p salesforce1

sfdx force:apex:execute -f scripts/apex/createData.apex
sfdx force:apex:execute -f scripts/apex/assignPermSet.apex

# Open the org.
sfdx force:org:open
