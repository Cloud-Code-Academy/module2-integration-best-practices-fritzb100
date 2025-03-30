public with sharing class ExchangeRateQueuable implements Queueable, Database.AllowsCallouts {

    private static final Integer MAX_JOBS = 1;

    // queue the job
    public static void enqueueJob() {
        if(!isQueueableJobRunning()) {
        System.enqueueJob(new ExchangeRateQueuable());   
        }

    }
    // execute method to process
    public void execute(QueueableContext context) {
        try {
            ExchangeRateService.updateExchangeRates();
        } catch (Exception e) {
            Module2Utility.debugException(e);
            ExchangeRateService.createItem(e, 'ExchangeRateQueueable Class');
        }

        // requeue the job 
        Boolean reachMaxDepth = AsyncInfo.getCurrentQueueableStackDepth() == MAX_JOBS;
        if(!reachMaxDepth && !isQueueableJobRunning() ) {                           
            ExchangeRateQueuable.enqueueJob();
        }   
    }

    // check is a Queueable job already exist
    public static Boolean isQueueableJobRunning() {
        List<AsyncApexJob> queuablejobs = [
            SELECT Id, Status, JobType
            FROM AsyncApexJob
            WHERE JobType = 'Queueable'
            AND ApexClass.Name = 'ExchangeRateQueuable'
            AND Status IN ('Processing,', 'Queued')
        ];
        return !queuablejobs.isEmpty();
    }
}