public with sharing class GoogleCalendarMeet {
    
    @AuraEnabled(cacheable=True)
    
    public static string googleMeet(String recordId , String startTime , String endTime){
        Contact testCon = [Select Id, Email,Title from Contact Where Id=: recordId];
        Http http = new Http();
        string meetType ='hangoutsMeet';  // added type to meet
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Google/calendars/'+testCon.Email+'/events');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        string retrievedResponse;
        String timeMeet = '{'+
            '"end": { "dateTime": "'+endTime+'"},'+
            '"start": { "dateTime": "'+startTime+'"},'+
            '"attendees": [{'+
            '"email": "'+testCon.Title+
            '" }],'+
            '"conferenceData": {'+
                '"createRequest": {'+
                    '"conferenceSolutionKey": {'+
                        '"type": "'+meetType+'"'+
            '}'+
                '}'+
            '}'+
        '}';
        request.setBody(timeMeet);
        HttpResponse response = http.send(request);
        system.debug(response.getBody());
        if (response.getStatusCode() == 200){
            system.debug('Meetin Arranged');
            system.debug(startTime);
            system.debug(endTime);
            system.debug(timeMeet);
            retrievedResponse = 'response.getBody()';
            
        }
        return (retrievedResponse);
    }
}