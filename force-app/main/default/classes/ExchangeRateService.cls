/**
 * @description Service class that handles API callouts to the Exchange Rate API
 * Students will implement the methods to make callouts and process responses
 */
public class ExchangeRateService {
    // static Strings to use for exception messages
    private static String UNRESOLVED_NAME = 'Exception in ExchangeRateService';
    private static String OBJECT_NAME = 'Exchange_Rate__c';
    
    // The named credential to use for the callout
    private static final String NAMED_CREDENTIAL = 'ExchangeRate_API';
    
    // The base currency to use for exchange rates
    private static final String BASE_CURRENCY = 'USD';
    
    /**
     * @description Makes a callout to the Exchange Rate API to get the latest exchange rates
     * @return ExchangeRateWrapper containing the response data
     */
    public static ExchangeRateWrapper getLatestRates() {
        // TODO: Implement the method to make a callout to the Exchange Rate API
        String response;
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:'+ NAMED_CREDENTIAL + '/'+ BASE_CURRENCY);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        try {
            if(res.getStatusCode() >= 200 && res.getStatusCode() < 300) {
                response = res.getBody();
                // Parse the JSON response into the wrapper class
                ExchangeRateWrapper exchangeRateWrapperData = ExchangeRateWrapper.parse(response);
                
                // Call the toExchangeRates() method to get the list of Exchange_Rate__c records
                List<Exchange_Rate__c> exchangeRateRecords = exchangeRateWrapperData.toExchangeRates();
                List<Exchange_Rate__c> processRateRecords  = processRates(exchangeRateRecords);
                
                System.debug('processRateRecords: ' + processRateRecords);
                return exchangeRateWrapperData; // Replace with actual implementation
            }
        } catch (Exception e) {
            createItem(e, 'getLatestRates');
        }
        return null; 
    }

    
    /**
     * @description Processes the exchange rate data and creates or updates records
     * @param rateData The wrapper containing exchange rate data
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> processRates(List<Exchange_Rate__c> rateData) {
        // get the list from the exchangeRateWrapper
        //upsert it with external Id
        for(Exchange_Rate__c exchangeRateRecord : rateData){
            exchangeRateRecord.External_Id__c     = (String)exchangeRateRecord.External_Id__c;
            exchangeRateRecord.Base_Currency__c   = (String)exchangeRateRecord.Base_Currency__c;
            exchangeRateRecord.Last_Updated__c    = (Datetime)exchangeRateRecord.Last_Updated__c;
            exchangeRateRecord.Target_Currency__c = (String)exchangeRateRecord.Target_Currency__c; 
        }
        try {
            if (Schema.sObjectType.Exchange_Rate__c.isCreateable() && Schema.sObjectType.Exchange_Rate__c.isUpdateable()) {
                Database.upsert(rateData, Exchange_Rate__c.External_Id__c); // Replace with the correct external ID field
            } 
        } catch (Exception e) {
            createItem(e, 'processRates');
        }
        //return it
        return rateData; // Replace with actual implementation
    }
    
    /**
     * @description Combines getting and processing rates into a single operation
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> updateExchangeRates() {
        try {
                //1. Call getLatestRates to retrieve the data
            ExchangeRateWrapper exchangeRateWrapper = getLatestRates();
            List<Exchange_Rate__c> exchangeRateRecords = exchangeRateWrapper.toExchangeRates();
                // 2. Call processRates to create/update records
            List<Exchange_Rate__c> processedRecords = processRates(exchangeRateRecords);
                // 3. Return the processed records
            return processedRecords; // Replace with actual implementation
        } catch (Exception e) {
            createItem(e, 'updateExchangeRates');
        }
        return null; 
    }

    // Method to catch exceptions and create an unresolved item to troubleshoot
    public static void createItem(Exception e, String method) {
        Module2Utility.debugException(e);
        Unresolved_Item__c item = Module2Utility.createUnresolvedItem(
        UNRESOLVED_NAME, OBJECT_NAME, method, e.getMessage() + ' ' + e.getCause() + ' ' + e.getStackTraceString(), UserInfo.getUserId()
        );
        insert item;
    }
}