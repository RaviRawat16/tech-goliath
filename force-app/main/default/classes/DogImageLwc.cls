public with sharing class DogImageLwc {
@AuraEnabled
public static string Kennel() {
Http http = new Http(); 
HttpRequest request = new HttpRequest();
request.setEndpoint('https://dog.ceo/api/breeds/image/random');
request.setMethod('GET');
HttpResponse response = http.send(request);
string Message;
if(response.getStatusCode() == 200) {
    map<String,Object> results = (map<String,Object>) JSON.deserializeUntyped(response.getBody());
    Message = string.valueof(results.get('message'));
    }
    return Message;
}
}
