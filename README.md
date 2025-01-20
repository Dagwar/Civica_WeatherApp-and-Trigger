# Civica_WeatherApp-and-Trigger
Interview Task LWC and Trigger




Task 1:

Consider a standard Salesforce org, with two additional custom fields: Account.Status__c, and Contact.Status__c. These are both picklists with values of 'Active' and 'Inactive'. 

Write a trigger so that whenever an Account becomes Inactive, all child Contacts are also set to be Inactive. 

This Code should be production ready with tests to ensure not only coverage but also correctness of functionality. Either use a developer sandbox or a scratch org to complete this in.


Task 2:

Two input fields to allow user to enter latitude and longitude and do a callout to api-ninjas and display all the attributes from the response

Please find below the curl request to do this
curl --location 'https://api.api-ninjas.com/v1/weather?lat=51.5105&lon=0.5950' \
--header 'X-Api-Key: 60nhUoypEfNvVKT61I11XA==sCjOJKxFTOAUfqUu'


Sample Response
{
    "cloud_pct": 75,
    "temp": 9,
    "feels_like": 7,
    "humidity": 83,
    "min_temp": 8,
    "max_temp": 10,
    "wind_speed": 3.09,
    "wind_degrees": 190,
    "sunrise": 1737014132,
    "sunset": 1737044330
}
