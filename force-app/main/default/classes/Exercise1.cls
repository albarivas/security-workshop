public with sharing class Exercise1 {
  /**
   * This method is vulnerable to SOQL Injection
   * as the supplied user input is not being sanitized
   * and could be interpreted as part of que query
   */
  @AuraEnabled(cacheable=true)
  public static List<Lead> getFilteredLeadsInjection(String searchValue) {
    String likeValue = '\'%' + searchValue + '%\'';
    return (List<Lead>) Database.query(
      'SELECT Name, Rating FROM Lead WHERE Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }

  /**
   * Provide a solution that fixes the problem!
   */
  /*
  @AuraEnabled(cacheable=true)
  public static List<Lead> getFilteredLeadsNoInjection(String searchValue) {
    
  }
  */
}
