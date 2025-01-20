public with sharing class CivicaWeatherAppController {
    @AuraEnabled(cacheable=false)
    public static String getWeather(String latitude, String longitude) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://api.api-ninjas.com/v1/weather?lat=' + latitude + '&lon=' + longitude);
            request.setMethod('GET');
            request.setHeader('X-Api-Key', '60nhUoypEfNvVKT61I11XA==sCjOJKxFTOAUfqUu');

            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                return response.getBody();
            } else {
                throw new CalloutException('Failed to fetch weather data: ' + response.getBody());
            }
        } catch (Exception ex) {
            throw new AuraHandledException('Error: ' + ex.getMessage());
        }
    }
}
