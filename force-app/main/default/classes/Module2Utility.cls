public with sharing class Module2Utility {

    public static Unresolved_Item__c createUnresolvedItem(String itemName, String Obj, String method, String Description, Id ownerId) {
        description = description.length() > 131072 ? description.substring(0, 131072) : description;
        Unresolved_Item__c item = new Unresolved_Item__c(
            Name = itemName,
            Object__c = obj,
            Method__c = method,
            Description__c = description,
            Owner__c = ownerId
        );
        return item;
    }
    public static void debugException(Exception e) {
        System.debug('*** Execption occured!!***');
        System.debug('Execption Type caught: ' + e.getTypeName());
        System.debug('Message: ' + e.getMessage());
        System.debug('Cause: ' + e.getCause());
        System.debug('Line Number: ' + e.getLineNumber());
        System.debug('Stack trace: ' + e.getStackTraceString());
    }
}