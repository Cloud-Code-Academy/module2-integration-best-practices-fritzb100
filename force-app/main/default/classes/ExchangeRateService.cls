/**
 * @description Service class that handles API callouts to the Exchange Rate API
 * Students will implement the methods to make callouts and process responses
 */
public class ExchangeRateService {
    
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
        req.setEndpoint('callout:'+ NAMED_CREDENTIAL + '/'+ BASE_CURRENCY); //
        req.setMethod('GET');
        
        Http http = new Http();
        

            HttpResponse res = http.send(req);
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
            else{
                // TODO: Create an custom exception class
                response = 'Status Code: ' + res.getStatusCode() + 'Status: '+ res.getStatus();         
        }
        return null; 
    }

    
    /**
     * @description Processes the exchange rate data and creates or updates records
     * @param rateData The wrapper containing exchange rate data
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> processRates(List<Exchange_Rate__c> rateData) {
        //List<Exchange_Rate__c> listToReturn = new List<Exchange_Rate__c>();
        System.debug(rateData);
        // TODO: Implement the method to process rates and create/update records
        // get the list from the exchangeRateWrapper
        //upsert it with external Id
           // Database.upsert(rateData, 'External_Id__c'); // Replace with the correct external ID field
        //return it
        return rateData; // Replace with actual implementation
    }
    
    /**
     * @description Combines getting and processing rates into a single operation
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> updateExchangeRates() {
        // TODO: Implement the method to get and process rates
        // 1. Call getLatestRates to retrieve the data
        // 2. Call processRates to create/update records
        // 3. Return the processed records
        
        return null; // Replace with actual implementation
    }
}