public class Catfact {
    public static void Fact(){
        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://catfact.ninja/fact');
        request.setMethod('GET');
        string displayFact;
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            map<String,Object> results = (map<String,Object>) JSON.deserializeUntyped(response.getBody());
            displayFact=string.valueof(results.get('fact')); 
        }
        system.debug(displayFact);
    }
}