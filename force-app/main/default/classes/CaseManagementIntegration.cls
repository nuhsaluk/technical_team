@RestResource(urlMapping='/Cases_tr1/*')
global with sharing class CaseManagementIntegration {
    @HttpGet
    global static Case getCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT CaseNumber,Subject,Status,Origin,Priority FROM Case WHERE Id = :caseId];
        return result;
    }
    
    @HttpPost
    global static Id createCase(String subject, String status, String origin, String priority) {
        Case newCase = new Case(Subject=subject, Status=status, Origin=origin, Priority=priority);
        insert newCase;
        return newCase.Id;
    }
    
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }
    
    @HttpPut
    global static Id upsertCase(String subject, String status, String origin, String priority, String id) {
        Case thisCase = new Case(Id=id, Subject=subject, Status=status, Origin=origin, Priority=priority);
        upsert thisCase;
        return thisCase.Id;
    }    
}