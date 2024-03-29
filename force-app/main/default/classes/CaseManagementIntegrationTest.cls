@IsTest
private class CaseManagementIntegrationTest {
    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases_tr1/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
       
        Case thisCase = CaseManagementIntegration.getCase();
        System.assert(thisCase != null);
        System.assertEquals('Test record', thisCase.Subject);
    }
    @isTest static void testCreateCase() {
        ID thisCaseId = CaseManagementIntegration.createCase(
            'Version Update issue', 'New', 'Phone', 'Low');
       
        Case thisCase = [SELECT Id,Subject FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Subject, 'Version Update issue');
    }
    @isTest static void testDeleteCase() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases_tr1/'
            + recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        CaseManagementIntegration.deleteCase();
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size() == 0);
    }
    @isTest static void testUpsertCase() {
        ID case1Id = CaseManagementIntegration.upsertCase('Version Update issue', 'New', 'Phone', 'Low', null);
        System.assert(Case1Id != null);
        Case case1 = [SELECT Id,Subject FROM Case WHERE Id=:case1Id];
        System.assert(case1 != null);
        System.assertEquals(case1.Subject, 'Version Update issue');
        ID case2Id = CaseManagementIntegration.upsertCase(
                'Version Update issue', 'Working', 'Phone', 'Low', case1Id);
        System.assertEquals(case1Id, case2Id);
        Case case2 = [SELECT Id,Status FROM Case WHERE Id=:case2Id];
        System.assert(case2 != null);
        System.assertEquals(case2.Status, 'Working');
    }    

    static Id createTestRecord() {
        Case caseTest = new Case(
            Subject='Test record',
            Status='New',
            Origin='Phone',
            Priority='Medium');
        insert caseTest;
        return caseTest.Id;
    }          
}
