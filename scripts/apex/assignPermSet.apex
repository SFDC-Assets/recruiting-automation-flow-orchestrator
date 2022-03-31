PermissionSet recruitingPerm = [SELECT Id FROM PermissionSet WHERE Name = 'Recruiting_Manager' LIMIT 1];
User user1 = [SELECT Id FROM User WHERE alias = 'mholmes' LIMIT 1];
User user2 = [SELECT Id FROM User WHERE alias = 'nsanchez' LIMIT 1];

PermissionSetAssignment psa1 = new PermissionSetAssignment (PermissionSetId = recruitingPerm.Id, AssigneeId = user1.Id);
insert psa1;
PermissionSetAssignment psa2 = new PermissionSetAssignment (PermissionSetId = recruitingPerm.Id, AssigneeId = user2.Id);
insert psa2;