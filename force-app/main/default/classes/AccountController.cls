public with sharing class AccountController {
  /**
   * This method is vulnerable to SOQL Injection
   * as the supplied user input is not being sanitized
   * and could be interpreted as part of que query
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsInjection(String searchValue) {
    String likeValue = '\'%' + searchValue + '%\'';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we prevent SOQL Injection
   * by making the query static
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccounts(String searchValue) {
    String likeValue = '%' + searchValue + '%';
    return [
      SELECT Name, AnnualRevenue, Industry
      FROM Account
      WHERE Name LIKE :likeValue
      ORDER BY Name
    ];
  }

  /**
   * In this method we prevent SOQL Injection
   * by binding the using supplied input with :
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccounts2(String searchValue) {
    String likeValue = '%' + searchValue + '%';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Name LIKE :likeValue ORDER BY Name'
    );
  }

  /**
   * In this method we prevent SOQL Injection
   * by escaping single quotes - not safe in all cases!
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccounts3(String searchValue) {
    String likeValue = '\'%' + String.escapeSingleQuotes(searchValue) + '%\'';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }


  @AuraEnabled
  public static Account createAccount() {
    Account acct = new Account();
    acct.Name = 'Cruzcampo';
    acct.AnnualRevenue = 1000000;
    acct.Industry = 'Food & Beverage';

    insert acct;

    return acct;
  }
}
