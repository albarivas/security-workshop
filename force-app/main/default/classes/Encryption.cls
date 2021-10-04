public with sharing class Encryption {
  static final Blob AES_KEY = Crypto.generateAesKey(256);
  static final Blob OTHER_PRIVATE_KEY = Blob.valueOf('secret key');
  static final Blob PKCS8_PRIVATE_KEY = EncodingUtil.base64Decode(
    'MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKNwapOQ6rQJHetP\n' +
    'HRlJBIh1OsOsUBiXb3rXXE3xpWAxAha0MH+UPRblOko+5T2JqIb+xKf9Vi3oTM3t\n' +
    'KvffaOPtzKXZauscjq6NGzA3LgeiMy6q19pvkUUOlGYK6+Xfl+B7Xw6+hBMkQuGE\n' +
    'nUS8nkpR5mK4ne7djIyfHFfMu4ptAgMBAAECgYA+s0PPtMq1osG9oi4xoxeAGikf\n' +
    'JB3eMUptP+2DYW7mRibc+ueYKhB9lhcUoKhlQUhL8bUUFVZYakP8xD21thmQqnC4\n' +
    'f63asad0ycteJMLb3r+z26LHuCyOdPg1pyLk3oQ32lVQHBCYathRMcVznxOG16VK\n' +
    'I8BFfstJTaJu0lK/wQJBANYFGusBiZsJQ3utrQMVPpKmloO2++4q1v6ZR4puDQHx\n' +
    'TjLjAIgrkYfwTJBLBRZxec0E7TmuVQ9uJ+wMu/+7zaUCQQDDf2xMnQqYknJoKGq+\n' +
    'oAnyC66UqWC5xAnQS32mlnJ632JXA0pf9pb1SXAYExB1p9Dfqd3VAwQDwBsDDgP6\n' +
    'HD8pAkEA0lscNQZC2TaGtKZk2hXkdcH1SKru/g3vWTkRHxfCAznJUaza1fx0wzdG\n' +
    'GcES1Bdez0tbW4llI5By/skZc2eE3QJAFl6fOskBbGHde3Oce0F+wdZ6XIJhEgCP\n' +
    'iukIcKZoZQzoiMJUoVRrA5gqnmaYDI5uRRl/y57zt6YksR3KcLUIuQJAd242M/WF\n' +
    '6YAZat3q/wEeETeQq1wrooew+8lHl05/Nt0cCpV48RGEhJ83pzBm3mnwHf8lTBJH\n' +
    'x6XroMXsmbnsEw=='
  );

  // Encrypts data with symmetric key --> secrecy
  @AuraEnabled
  public static String encryptAES256() {
    Blob data = Blob.valueOf('Test data');

    Blob encryptedData = Crypto.encryptWithManagedIV('AES256', AES_KEY, data);

    // Encode Blob in Base64
    return EncodingUtil.base64Encode(encryptedData);
  }

  @AuraEnabled
  public static String decryptAES256() {
    String encryptedData = encryptAES256();

    // IV will be the first 128 bits (16 bytes) of the received data
    Blob data = Crypto.decryptWithManagedIV(
      'AES256',
      AES_KEY,
      EncodingUtil.base64Decode(encryptedData)
    );

    return data.toString();
  }

  // Generates hash that can be checked in destination --> integrity
  @AuraEnabled
  public static String originHashSHA512() {
    Blob data = Blob.valueOf('Test data');

    Blob hash = Crypto.generateDigest('SHA512', data);

    // Encode Blob in Base64
    return EncodingUtil.base64Encode(hash);
  }

  @AuraEnabled
  public static String destinationHashSHA512() {
    String receivedHash = originHashSHA512();
    Blob receivedData = Blob.valueOf('Test data');

    Blob hash = Crypto.generateDigest('SHA512', receivedData);

    // receivedHash and hash should  be identical!
    // Encode Blob in Base64
    return EncodingUtil.base64Encode(hash);
  }

  // Generates hash and encrypts it with a symmetric key --> integrity and authenticity
  @AuraEnabled
  public static String originMacHMAC512() {
    Blob data = Blob.valueOf('Test data');

    Blob mac = Crypto.generateMac('hmacSHA512', data, OTHER_PRIVATE_KEY);

    // Encode Blob in Base64
    return EncodingUtil.base64Encode(mac);
  }

  @AuraEnabled
  public static String destinationMacHMAC512() {
    String receivedMac = originHashSHA512();
    Blob receivedData = Blob.valueOf('Test data');

    Blob mac = Crypto.generateMac(
      'hmacSHA512',
      receivedData,
      OTHER_PRIVATE_KEY
    );

    // receivedMac and mac should  be identical!
    // Encode Blob in Base64
    return EncodingUtil.base64Encode(mac);
  }

  // Hash of the message is encrypted with the private key of the sender --> integrity, authenticity and no-repudiation
  @AuraEnabled
  public static String originDigitalSignature() {
    // Use private key (must be in RSA's PKCS #8 (1.2) Private-Key Information Syntax Standard form)

    Blob data = Blob.valueOf('Test data');

    Blob digitalSignature = Crypto.sign('RSA', data, PKCS8_PRIVATE_KEY);

    // Encode Blob in Base64
    return EncodingUtil.base64Encode(digitalSignature);
  }

  @AuraEnabled
  public static String destinationDigitalSignature() {
    String receivedSignature = originDigitalSignature();
    Blob receivedData = Blob.valueOf('Test data');

    Blob digitalSignature = Crypto.sign('RSA', receivedData, PKCS8_PRIVATE_KEY);

    // receivedMac and mac should  be identical!
    // Encode Blob in Base64
    return EncodingUtil.base64Encode(digitalSignature);
  }
}
