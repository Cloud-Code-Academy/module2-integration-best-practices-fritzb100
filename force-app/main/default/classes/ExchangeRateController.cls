public with sharing class ExchangeRateController {
    @AuraEnabled
    public static List<Exchange_Rate__c> getExchangeRates(){
        try {
            return [SELECT Id, Name, Base_Currency__c, Target_Currency__c, Rate__c, Last_Updated__c FROM Exchange_Rate__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}