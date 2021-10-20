public with sharing class Encryption {
  // Encrypts data with symmetric key --> secrecy
  @AuraEnabled
  public static String encryptAES256() {
    Blob data = Blob.valueOf('Test data');

    Blob encryptedData = Crypto.encryptWithManagedIV(
      'AES256',
      Keys.AES_KEY,
      data
    );

    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(encryptedData);
  }

  @AuraEnabled
  public static String decryptAES256() {
    String encryptedData = encryptAES256();

    // IV will be the first 128 bits (16 bytes) of the received data
    Blob data = Crypto.decryptWithManagedIV(
      'AES256',
      Keys.AES_KEY,
      EncodingUtil.base64Decode(encryptedData)
    );

    return data.toString();
  }

  // Generates hash that can be checked in destination --> integrity
  @AuraEnabled
  public static String originHashSHA512() {
    Blob data = Blob.valueOf('Test data');

    Blob hash = Crypto.generateDigest('SHA512', data);

    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(hash);
  }

  @AuraEnabled
  public static String destinationHashSHA512() {
    String receivedHash = originHashSHA512();
    Blob receivedData = Blob.valueOf('Test data');

    Blob hash = Crypto.generateDigest('SHA512', receivedData);

    // receivedHash and hash should  be identical!
    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(hash);
  }

  // Generates hash and encrypts it with a symmetric key --> integrity and authenticity
  @AuraEnabled
  public static String originMacHMAC512() {
    Blob data = Blob.valueOf('Test data');

    Blob mac = Crypto.generateMac('hmacSHA512', data, Keys.OTHER_PRIVATE_KEY);

    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(mac);
  }

  @AuraEnabled
  public static String destinationMacHMAC512() {
    String receivedMac = originHashSHA512();
    Blob receivedData = Blob.valueOf('Test data');

    Blob mac = Crypto.generateMac(
      'hmacSHA512',
      receivedData,
      Keys.OTHER_PRIVATE_KEY
    );

    // receivedMac and mac should  be identical!
    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(mac);
  }

  // Hash of the message is encrypted with the private key of the sender --> integrity, authenticity and no-repudiation
  @AuraEnabled
  public static String originDigitalSignature() {
    // Use private key (must be in RSA's PKCS #8 (1.2) Private-Key Information Syntax Standard form)

    Blob data = Blob.valueOf('Test data');

    Blob digitalSignature = Crypto.sign('RSA', data, Keys.PKCS8_PRIVATE_KEY);

    // Encode Blob in Base64 to see it as String for convenience
    return EncodingUtil.base64Encode(digitalSignature);
  }

  @AuraEnabled
  public static String destinationDigitalSignature() {
    String receivedSignature = originDigitalSignature();
    Blob receivedData = Blob.valueOf('Test data');

    Boolean correct = Crypto.verify(
      'RSA',
      receivedData,
      EncodingUtil.base64Decode(receivedSignature),
      Keys.PKCS8_PUBLIC_KEY
    );

    return correct + '';
  }
}
