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
   * This method is vulnerable to SOQL Injection
   * as the supplied user input is not being sanitized
   * and could be interpreted as part of que query
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsInjection2(
    String searchValue
  ) {
    String filterValue = String.isEmpty(searchValue) ? '0' : searchValue;
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we prevent SOQL Injection
   * by making the query static
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsStaticQuery(
    String searchValue
  ) {
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
  public static List<Account> getFilteredAccountsVariableBinding(
    String searchValue
  ) {
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
  public static List<Account> getFilteredAccountsEscaping(String searchValue) {
    String likeValue = '\'%' + String.escapeSingleQuotes(searchValue) + '%\'';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by escaping single quotes - but this is one of the cases in which escaping
   * doesn't fix the problem
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsEscapingNotEffective(
    String searchValue
  ) {
    String filterValue = String.isEmpty(searchValue)
      ? '0'
      : String.escapeSingleQuotes(searchValue);
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by type casting
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsTypeCasting(
    String searchValue
  ) {
    Integer filterValue = String.isEmpty(searchValue)
      ? 0
      : Integer.valueOf(searchValue);
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by allow listing
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsAllowListing(
    String searchValue
  ) {
    Map<String, Integer> allowedValues = new Map<String, Integer>();
    allowedValues.put('100', 100);
    allowedValues.put('500', 500);
    allowedValues.put('1000', 1000);

    Integer filterValue = allowedValues.get(searchValue);

    if (filterValue == null) {
      filterValue = 0;
    }
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE NumberOfEmployees > ' +
      filterValue +
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
