public with sharing class ContactController {
  @AuraEnabled
  public static Contact getContactXSS() {
    return [SELECT Name, Title FROM Contact WHERE Name = 'Julián Duque'];
  }
}
