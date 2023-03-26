public class LeadSourceBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id FROM Lead WHERE LeadSource = null]);
    }
    public void execute(Database.BatchableContext bc, List<Lead> listLead){
        for(Lead le:listLead){
            le.LeadSource = 'Manual';
        }
        update listLead;
    }
    public void finish(Database.BatchableContext bc){
        
    }
    public void execute(System.SchedulableContext ctx){
        LeadSourceBatch lsb = new LeadSourceBatch();
        Database.executeBatch(lsb);
    }
}