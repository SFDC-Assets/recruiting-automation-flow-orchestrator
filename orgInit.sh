# Create the demo org
sf demoutil org create scratch -f config/project-scratch-def.json -d 30 -s -p flow -e orchestrator.demo

# Push the metadata into the new scratch org.
sf project deploy start -d force-app
sf project deploy start -d orchestrator

# Assign user the permset
sf org assign permset -n Recruiting_Manager

# Set the default password.
sf demoutil user password set -p salesforce1 -g User -l User

sf apex run -f scripts/apex/createData.apex
sf apex run -f scripts/apex/assignPermSet.apex

# Open the org.
sf org open
