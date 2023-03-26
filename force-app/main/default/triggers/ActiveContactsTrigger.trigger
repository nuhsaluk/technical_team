trigger ActiveContactsTrigger on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){    
        ActiveContactsHandler.countContacts(Trigger.new);
    }
    if(Trigger.isDelete){         
        ActiveContactsHandler.countContacts(Trigger.old);        
    }
}