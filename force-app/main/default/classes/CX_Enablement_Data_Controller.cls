public class CX_Enablement_Data_Controller {
    
    public Boolean dataExists{
        get{
            Integer positionsCount = [SELECT COUNT() FROM Position__c LIMIT 10];
            if(positionsCount > 1){
                dataExists = true;
            } else{
                dataExists = false;
            }
            return dataExists;
        } 
        private set;
    }
    
    public Id systemAdminProfileId{
        get{
            if(systemAdminProfileId == null){
                Profile p = [SELECT Id
                             FROM Profile
                             WHERE Name = 'System Administrator'
                             LIMIT 1];
                systemAdminProfileId = p.Id;
            }
            return systemAdminProfileId;
        }
        private set;
    }
    
      public String systemAdminEmail{
        get{
            if(systemAdminEmail == null){
                Profile p = [SELECT Id
                             FROM Profile
                             WHERE Name = 'System Administrator'
                             LIMIT 1];
                systemAdminEmail = p.Id;
            }
            return systemAdminEmail;
        }
        private set;
    }
    
     public Id hrUserProfileId{
        get{
            if(hrUserProfileId == null){
                Profile p = [SELECT Id
                             FROM Profile
                             WHERE Name = 'HR User'
                             LIMIT 1];
                hrUserProfileId = p.Id;
            }
            return hrUserProfileId;
        }
        private set;
    }
    
    Id technicalPositionId = Schema.SObjectType.Position__c.getRecordTypeInfosByName().get('Technical Position').getRecordTypeId();
    
    Id nonTechnicalPositionId = Schema.SObjectType.Position__c.getRecordTypeInfosByName().get('Non-Technical Position').getRecordTypeId();
    
    public void createData(){
        // Users
        
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        
        List<User> users = new List<User>();        
        User user1 = new User(
            Username = 'nsanchez' + UserInfo.getOrganizationId() + '@example.com',
            FirstName = 'Nicki', LastName = ' Sanchez',
            Email = userEmail,
            Alias = 'nsanchez',
            CommunityNickname = 'n' + String.valueOf(DateTime.now()),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US', 
            EmailEncodingKey = 'UTF-8',
            ProfileId = hrUserProfileId, 
            LanguageLocaleKey = 'en_US',
            IsActive = True
        );
        users.add(user1);       
        User user2 = new User(
            Username = 'mholmes' + UserInfo.getOrganizationId() + '@example.com',
            FirstName = 'Minnie', LastName = 'Holmes',
            Email = userEmail,
            Alias = 'mholmes',
            CommunityNickname = 'm' + String.valueOf(DateTime.now()),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US', 
            EmailEncodingKey = 'UTF-8',
            ProfileId = hrUserProfileId, 
            LanguageLocaleKey = 'en_US',
            IsActive = True
        );
        users.add(user2);        
        insert users;
        
        //Positions
        List<Position__c> positions = new List<Position__c>();
        Position__c position1 = new Position__c(
            Name  = 'Global Expense Specialist',
            Status__c  = 'Open',
            RecordTypeId = nonTechnicalPositionId, 
            Job_Description__c = 'The Travel and Expenses Team Lead will be responsible for day-to-day operations and performance of expense platforms, as well as support the various travel needs of different departments.',
            Department__c = 'Finance',
            Hiring_Manager__c = user1.Id,
            Pay_Grade__c = 'ACT-200'
        );
        positions.add(position1);
        Position__c position2 = new Position__c(
            Name  = 'Customer Support Rep',
            Status__c  = 'New',
            RecordTypeId = nonTechnicalPositionId, 
            Job_Description__c = 'The Customer Service Representative attracts potential customers by answering product and service questions; suggesting information about other products and services. Process orders and fulfill customer needs to ensure customer satisfaction.',
            Department__c = 'Support',
            Hiring_Manager__c = user2.Id,
            Pay_Grade__c = 'S-100'
        );
        positions.add(position2);
        Position__c position3 = new Position__c(
            Name  = 'Senior Account Executive',
            Status__c  = 'Open',
            RecordTypeId = nonTechnicalPositionId, 
            Job_Description__c = 'Do you have what it takes to be with the best-of-the best? Do you thrive on doing deals? Working in Sales at UCI provides a great opportunity for Sales Professionals with a proven track record exceeding quota in technology sales.',
            Department__c = 'Sales',
            Hiring_Manager__c = user1.Id,
            Pay_Grade__c = 'C-300'
        );
        positions.add(position3);
        Position__c position4 = new Position__c(
            Name  = 'Senior Integration Specialist',
            Status__c  = 'New',
            RecordTypeId = technicalPositionId, 
            Job_Description__c = 'The primary responsibility of the senior integration specialist is to facilitate via translation tools the conversion of data files, including implementation of end-to-end data flow.',
            Department__c = 'Engineering',
            Hiring_Manager__c = user2.Id,
            Pay_Grade__c = 'ENG-400',
            Programming_Languages__c = 'Java; Python',
            Operating_Systems__c = 'Windows; Mac'
        );
        positions.add(position4);
        Position__c position5 = new Position__c(
            Name  = 'UI Developer',
            Status__c  = 'Open',
            RecordTypeId = technicalPositionId, 
            Job_Description__c = 'The UI Developer is a Graphic Designer and a people pleaser. Their designs are practical and focused on engaging the user of an app or website or program.',
            Department__c = 'IT',
            Hiring_Manager__c = user1.Id,
            Pay_Grade__c = 'IT-300',
            Programming_Languages__c = 'HTML5; JavaScript',
            Operating_Systems__c = 'Windows; Mac'
        );
        positions.add(position5);
        Position__c position6 = new Position__c(
            Name  = 'Black Box Tester',
            Status__c  = 'Open',
            RecordTypeId = technicalPositionId, 
            Job_Description__c = 'Black box tester responsibilities include designing and implementing tests, and fixing any bugs or issues within your coding skill set.',
            Department__c = 'IT',
            Hiring_Manager__c = user2.Id,
            Pay_Grade__c = 'IT-200',
            Programming_Languages__c = 'Java; Python; PHP',
            Operating_Systems__c = 'Windows; Mac'
        );
        positions.add(position6);
        
        
        insert positions;
        
        // Candidates
        List<Candidate__c> candidates = new List<Candidate__c>();
        Candidate__c candidate1 = new Candidate__c(
            First_Name__c = 'Paul',
            Last_Name__c = 'Allan',
            Email__c = 'PaulAllen@email.com',
            Street_Address_1__c = '111 Montclair Street',
            City__c = 'Boston',
            State_Province__c = 'MA',
            Zip_Postal_Code__c = '21111',
            Currently_Employed__c = true,
            Current_Employer__c  = 'Pierce & Pierce',
            Years_of_Experience__c = 5,
            Country__c = 'United States',
            Mobile__c = '(510) 555-3987'
        );
        candidates.add(candidate1);
        Candidate__c candidate2 = new Candidate__c(
            First_Name__c = 'Jamal',
            Last_Name__c = 'Cooks',
            Email__c = 'jcooks@email.com',
            Street_Address_1__c = '4450 Main Street',
            City__c = 'New York',
            State_Province__c = 'NY',
            Zip_Postal_Code__c = '10010',
            Currently_Employed__c = true,
            Current_Employer__c  = 'Wayne Enterprises',
            Years_of_Experience__c = 10,
            Country__c = 'United States',
            Mobile__c = '(619) 555-1083'
        );
        candidates.add(candidate2);
        Candidate__c candidate3 = new Candidate__c(
            First_Name__c = 'Patrick',
            Last_Name__c = 'Bateman',
            Email__c = 'bateman@email.com',
            Street_Address_1__c = '50 Windy Court',
            City__c = 'Chicago',
            State_Province__c = 'IL',
            Zip_Postal_Code__c = '60102',
            Currently_Employed__c = true,
            Current_Employer__c  = 'Dunder Mifflin',
            Years_of_Experience__c = 15,
            Country__c = 'United States',
            Mobile__c = '(360) 555-2345'
        );
        candidates.add(candidate3);
        Candidate__c candidate4 = new Candidate__c(
            First_Name__c = 'Cynthia',
            Last_Name__c = 'Capobianco',
            Email__c = 'cynthiaCap@email.com',
            Street_Address_1__c = '22 14th Avenue',
            City__c = 'San Diego',
            State_Province__c = 'CA',
            Zip_Postal_Code__c = '92019',
            Currently_Employed__c = true,
            Current_Employer__c  = 'Bluth Company',
            Years_of_Experience__c = 20,
            Country__c = 'United States',
            Mobile__c = '(718) 555-3237'
        );
        candidates.add(candidate4);
        Candidate__c candidate5 = new Candidate__c(
            First_Name__c = 'Stan',
            Last_Name__c = 'Sitwell',
            Email__c = 'sitwell@email.com',
            Street_Address_1__c = '150 Market Street',
            City__c = 'San Francisco',
            State_Province__c = 'CA',
            Zip_Postal_Code__c = '90041',
            Currently_Employed__c = true,
            Current_Employer__c  = 'Initech',
            Years_of_Experience__c = 25,
            Country__c = 'United States',
            Mobile__c = '(290) 555-1703'
        );
        candidates.add(candidate5);
        insert candidates;
        
        //Job Applications
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        Job_Application__c jobApplication1 = new Job_Application__c(
            Candidate__c = candidate1.Id,
            Position__c = position1.Id,
            Stage__c = 'Schedule Interviews',
            Status__c = 'Open'
        );
        jobApplications.add(jobApplication1);
        Job_Application__c jobApplication2 = new Job_Application__c(
            Candidate__c = candidate2.Id,
            Position__c = position2.Id,
            Stage__c = 'Schedule Interviews',
            Status__c = 'Open'
        );
        jobApplications.add(jobApplication2);
        Job_Application__c jobApplication3 = new Job_Application__c(
            Candidate__c = candidate3.Id,
            Position__c = position3.Id,
            Stage__c = 'Schedule Interviews',
            Status__c = 'Open'
        );
        jobApplications.add(jobApplication3);
        Job_Application__c jobApplication4 = new Job_Application__c(
            Candidate__c = candidate4.Id,
            Position__c = position4.Id,
            Stage__c = 'Schedule Interviews',
            Status__c = 'Open'
        );
        jobApplications.add(jobApplication4);
        Job_Application__c jobApplication5 = new Job_Application__c(
            Candidate__c = candidate5.Id,
            Position__c = position5.Id,
            Stage__c = 'Schedule Interviews',
            Status__c = 'Open'
        );
        jobApplications.add(jobApplication5);
        insert jobApplications;
        
        // Reviews
        List<Review__c> reviews = new List<Review__c>();
        for(Integer i = 1; i < 6; i++){
            Review__c review = new Review__c();
            Integer index = i - 1;
            review.Job_Application__c = jobApplications.get(index).Id;
            review.Experience__c = 5;
            review.Leadership_Skills__c = 5;
            review.Cultural_Fit__c = 4;
            review.Recommend_for_Hire__c = true;
            reviews.add(review);  
        }
        for(Integer i = 1; i < 6; i++){
            Review__c review = new Review__c();
            Integer index = i - 1;
            review.Job_Application__c = jobApplications.get(index).Id;
            review.Experience__c = 4;
            review.Leadership_Skills__c = 4;
            review.Cultural_Fit__c = 3;
            review.Recommend_for_Hire__c = true;
            reviews.add(review);  
        }
        for(Integer i = 1; i < 6; i++){
            Review__c review = new Review__c();
            Integer index = i - 1;
            review.Job_Application__c = jobApplications.get(index).Id;
            review.Experience__c = 5;
            review.Leadership_Skills__c = 4;
            review.Cultural_Fit__c = 5;
            review.Recommend_for_Hire__c = true;
            reviews.add(review);  
        }
        for(Integer i = 1; i < 4; i++){
            Review__c review = new Review__c();
            Integer index = i - 1;
            review.Job_Application__c = jobApplications.get(index).Id;
            review.Experience__c = 3;
            review.Leadership_Skills__c = 2;
            review.Cultural_Fit__c = 1;
            review.Recommend_for_Hire__c = false;
            reviews.add(review);  
        }
        for(Integer i = 1; i < 4; i++){
            Review__c review = new Review__c();
            Integer index = i - 1;
            review.Job_Application__c = jobApplications.get(index).Id;
            review.Experience__c = 1;
            review.Leadership_Skills__c = 1;
            review.Cultural_Fit__c = 1;
            review.Recommend_for_Hire__c = false;
            reviews.add(review);  
        }
        insert reviews;
    } 
}