public class OpportunityHandler {
    public static void createTask(List<Opportunity> listOpp, Map<Id, Opportunity> mapOpp){
        
        List<Task> tasks = new List<Task>();        
        for(Opportunity opp:listOpp){
            if(opp.StageName.equals('Closed Won') && !mapOpp.get(opp.Id).StageName.equals('Closed Won')){
                Task task = new Task(Subject = 'Follow up Task',
                                     ActivityDate = opp.CloseDate.addMonths(1),
                                     WhatId = opp.id,
                                     OwnerId = opp.OwnerId);
                tasks.add(task);
            }
        }
        insert tasks;
    }
}