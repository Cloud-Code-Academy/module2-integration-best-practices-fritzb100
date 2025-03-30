public with sharing class ExchangeRateQueuable implements Queueable, Database.AllowsCallouts {

    private static final Integer MAX_JOBS = 1;

    // queue the job
    public static void enqueueJob() {
        System.enqueueJob(new ExchangeRateQueuable());
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
        if(!reachMaxDepth) {
            ExchangeRateQueuable.enqueueJob();
        }
    }

    // check is a schedule job
}