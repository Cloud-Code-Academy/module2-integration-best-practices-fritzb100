/**
 * @description Scheduler class to run the exchange rate update on a schedule
 * Scheduling should be done in Salesforce Setup Apex Classes -> Schedule Apex
 */
global class ExchangeRateScheduler implements Schedulable {
    
    /**
     * @description Executes the scheduled job to update exchange rates
     * @param context The SchedulableContext
     */
    global void execute (SchedulableContext sc) {
        // 1. Call ExchangeRateService.updateExchangeRates()
        // 2. Add error handling
        // 3. Consider adding logging if available
        try {
            System.enqueueJob(new ExchangeRateQueuable());
        } catch (Exception e) {
            ExchangeRateService.createItem(e, 'Schedulable class');
        }
        

        
    }
    // Schedule using cron expression
    public static void sheduleDailyJob() {
        String cronExp = '0 0 0 * * ?'; //midnight everyday
        System.schedule('DailyExchangeRateUpdate', cronExp, new ExchangeRateScheduler());
    }

    // run in apex anonymous
    //ExchangeRateScheduler.sheduleDailyJob();

    //TODO if there is a job scheduled, don't schedule another check CronTrigger
}