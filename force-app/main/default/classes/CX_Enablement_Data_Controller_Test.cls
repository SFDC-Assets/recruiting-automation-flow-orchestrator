@isTest
private class CX_Enablement_Data_Controller_Test {

    static testMethod void testDataExists() {      
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard Platform User']; 
        
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        
        User newUser = new User();
        newUser.ProfileId = p.Id;
        newUser.Username = uniqueName + '@email.org';
        newUser.Alias = 'tinst';
        newUser.TimeZoneSidKey = 'America/Los_Angeles';
        newUser.LocaleSidKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.FirstName = 'Test';
        newUser.LastName = 'Instructor';
        newUser.Email = 'testInstructor@tandc.org';
        newUser.Phone = '415-555-4567';
        newUser.MobilePhone = '415-555-4647';
        newUser.Street = '123 Mission Street';
        newUser.City = 'San Francisco';
        newUser.State = 'CA';
        newUser.PostalCode = '94117';
        newUser.Country = 'USA';
        insert newUser;
       
        CX_Enablement_Data_Controller extTest = new CX_Enablement_Data_Controller();        
        PageReference testPage = Page.CX_Enablement_Data;
        Test.setCurrentPage(testPage);      
        System.assert(extTest.dataExists == false);
        System.assert(extTest.platformProfileId == p.Id);
        extTest.createData();
        System.assert(extTest.dataExists == true);
    }   
}