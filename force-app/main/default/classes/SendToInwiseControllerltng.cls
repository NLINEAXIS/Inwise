/******************************************************************************************
*Created By:  Kapil Goutam
*Created On: 
/******************************************************************************************/
public with sharing class SendToInwiseControllerltng {
    @AuraEnabled  
    public Static String getMsg(Id recId, String actionType) {
        System.debug('===> getMsg method called with recId: ' + recId + ', actionType: ' + actionType);

        Campaign objCampaign = new Campaign();
        
        if(Schema.sObjectType.Campaign.isAccessible() && 
           Schema.sObjectType.Campaign.fields.Account__c.isAccessible() && 
           Schema.sObjectType.Campaign.fields.Sendid__c.isAccessible() && 
           Schema.sObjectType.Campaign.fields.name.isAccessible()) {
            
            System.debug('===> Field-level and object-level access granted for Campaign');
            
            List<Campaign> listOfCampaign = [SELECT Id, Name, Account__c, Sendid__c FROM Campaign WHERE Id = :recId];
            System.debug('===> Campaign query result size: ' + listOfCampaign.size());

            if(listOfCampaign != NULL && !listOfCampaign.isEmpty()) {
                objCampaign = listOfCampaign.get(0);
                System.debug('===> Campaign record fetched: ' + objCampaign);
            }
        } else {
            System.debug('===> Field-level or object-level access denied for Campaign');
        }

       try {
    ApexPages.StandardController sc = new ApexPages.StandardController(objCampaign);
    //System.debug('===> StandardController created with Campaign: ' + objCampaign);
    SendToInwiseController objSendToInwiseController = new SendToInwiseController(sc);
   
   //SendToInwiseController objSendToInwiseController = new SendToInwiseController();
//objSendToInwiseController.objCampaign = objCampaign;
    System.debug('===> SendToInwiseController instance created');

    if(actionType == 'InwiseMembersActions') {
        System.debug('===> Calling OnLoad with InwiseStatistics for Campaign Id: ' + objCampaign.Id);
        objSendToInwiseController.OnLoad(objCampaign.Id, 'InwiseStatistics');
    }

    System.debug('===> Calling OnLoad with actionType: ' + actionType + ' for Campaign Id: ' + objCampaign.Id);
    objSendToInwiseController.OnLoad(objCampaign.Id, actionType);

    System.debug('===> Calling OnLoad again with recId: ' + recId + ' and actionType: ' + actionType);
    objSendToInwiseController.OnLoad(recId, actionType);

    System.debug('===> Returning ErrorMsg: ' + objSendToInwiseController.ErrorMsg);
    return objSendToInwiseController.ErrorMsg;
} catch (Exception e) {
    System.debug('Exception occurred: ' + e.getMessage());
    return 'Exception Occurred: ' + e.getMessage();
}}}