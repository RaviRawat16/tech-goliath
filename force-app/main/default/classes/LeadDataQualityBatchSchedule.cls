public class LeadDataQualityBatchSchedule implements Schedulable {
    public void execute(SchedulableContext ctx) {
        LeadDataQualityBatch scheduler = new LeadDataQualityBatch();
        database.executebatch(scheduler , 100);
    }
}