trigger AccountStatusTrigger on Account (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        AccountStatusTriggerHandler.updateChildContacts(Trigger.new, Trigger.oldMap);
    }
}
