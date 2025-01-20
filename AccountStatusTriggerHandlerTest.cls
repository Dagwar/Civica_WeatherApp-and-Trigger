@isTest
public class AccountStatusTriggerHandlerTest {
    @isTest
    static void testUpdateChildContacts() {
        // Create a test account with Status = 'Active'
        Account testAccount = new Account(
            Name = 'Test Account',
            Status__c = 'Active'
        );
        insert testAccount;

        // Create child contacts with Status = 'Active'
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'Akshay', LastName = 'Dagwar', AccountId = testAccount.Id, Status__c = 'Active'),
            new Contact(FirstName = 'Rocky', LastName = 'Dagwar', AccountId = testAccount.Id, Status__c = 'Active')
        };
        insert contacts;

        // Verify initial contact status
        List<Contact> insertedContacts = [
            SELECT Id, Status__c FROM Contact WHERE AccountId = :testAccount.Id
        ];
        System.assertEquals(2, insertedContacts.size());
        for (Contact con : insertedContacts) {
            System.assertEquals('Active', con.Status__c);
        }

        // Update the account status to 'Inactive'
        testAccount.Status__c = 'Inactive';
        update testAccount;

        // Verify that all child contacts are now 'Inactive'
        List<Contact> updatedContacts = [
            SELECT Id, Status__c FROM Contact WHERE AccountId = :testAccount.Id
        ];
        for (Contact con : updatedContacts) {
            System.assertEquals('Inactive', con.Status__c);
        }
    }

    @isTest
    static void testNoContactsToUpdate() {
        // Create a test account with Status = 'Active'
        Account testAccount = new Account(
            Name = 'Test Account',
            Status__c = 'Active'
        );
        insert testAccount;

        // Update the account status to 'Inactive'
        testAccount.Status__c = 'Inactive';
        update testAccount;

        // Verify no errors occurred even though no contacts exist
        Test.startTest();
        update testAccount;
        Test.stopTest();

        // Confirm no contacts exist
        Integer contactCount = [
            SELECT COUNT() FROM Contact WHERE AccountId = :testAccount.Id
        ];
        System.assertEquals(0, contactCount);
    }

    @isTest
    static void testStatusUnchanged() {
        // Create a test account with Status = 'Active'
        Account testAccount = new Account(
            Name = 'Test Account',
            Status__c = 'Active'
        );
        insert testAccount;

        // Create a child contact
        Contact testContact = new Contact(
            FirstName = 'Akshay', 
            LastName = 'Dagwar', 
            AccountId = testAccount.Id, 
            Status__c = 'Active'
        );
        insert testContact;

        // Update the account without changing the status
        testAccount.Name = 'Updated Test Account';
        update testAccount;

        // Verify the contact status remains unchanged
        Contact updatedContact = [
            SELECT Id, Status__c FROM Contact WHERE Id = :testContact.Id
        ];
        System.assertEquals('Active', updatedContact.Status__c);
    }
}
