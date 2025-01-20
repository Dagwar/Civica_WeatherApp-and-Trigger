/**
 * @description       : Class contains the logic for updating child contacts when the account status changes to Inactive.
 * @author            : Akshay Pandurang Dagwar
 * @last modified on  : 01-18-2025
**/
public class AccountStatusTriggerHandler {
    /**
     * Updates child contacts when the account's status changes to 'Inactive'.
     * @param newAccounts List of updated Account records.
     * @param oldAccountMap Map of old Account records keyed by Id.
     */
    public static void updateChildContacts(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        // Collect Account IDs for which Status__c has changed to 'Inactive'
        Set<Id> accountIdsToUpdate = new Set<Id>();
        
        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);
            // Check if status changed from Active to Inactive
            if (acc.Status__c == 'Inactive' && oldAcc.Status__c != 'Inactive') {
                accountIdsToUpdate.add(acc.Id);
            }
        }

        // Exit if no accounts meet the criteria
        if (accountIdsToUpdate.isEmpty()) return;

        // Query child contacts with Status__c not already set to 'Inactive'
        List<Contact> contactsToUpdate = [
            SELECT Id, Status__c 
            FROM Contact 
            WHERE AccountId IN :accountIdsToUpdate AND Status__c != 'Inactive'
        ];

        // Update the status of the contacts
        for (Contact con : contactsToUpdate) {
            con.Status__c = 'Inactive';
        }

        // Perform the update if there are contacts to update
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}
