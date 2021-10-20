public with sharing class Keys {
  public static final Blob AES_KEY = Crypto.generateAesKey(256);
  public static final Blob OTHER_PRIVATE_KEY = Blob.valueOf('secret key');
  public static final Blob PKCS8_PRIVATE_KEY = EncodingUtil.base64Decode(
    'MIIEvaIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDIxM3n2w5utLyI\n' +
    'Umd4otfyrEYwl3s7E9j3yI2DrcCo3ZcRtX5I3bZYxeq9XzWH6+PzjeOBz+f5LtLN\n' +
    'zMijhuR/mYITzBg3an6U87Lkyg4E5+nDat8NPwAiH04TldNl/oM231GUzo4YGl0g\n' +
    'C6FBlsOEoU+UaZtC2QdKxKH7GFe9Ny4+YKRc8b/soK5gdFzJ12PFeWnfPrLaP415\n' +
    'mNn2peUOhek4Zni5Xld6yzi9A5jdiLt8ZB+jggCID+zF2y1v9IQQywg4K6HIczLG\n' +
    '65I0OXZSOu3pe0td226M72icVILXIYcjATvV7cFRXcka7/8ScNwW5pXX3gNmVp7z\n' +
    'FlWTaVYxAgMBAAECggEBALoKLGdSBNCvKBkGix0tgQA9hRkX9bgrzxzkucWwZ1vT\n' +
    'Yl6lmKz6zjL6y2fJ5vfZrbSN4ajzuBieu/a6cZ2erPRUkkW4FSScyUlLfZUmatE+\n' +
    '+c38pU5H996mtZnOd0MHEh3x2E4VDXTmUS8Vt8roYqrvM6fqKFZMd8Zf6V2dFAif\n' +
    'iMmUpYYivK7ZOGjvxmP4jBcVoK5pqAPW3QvBFKgq3KwfUrV8IXRNRkcnmS1vWWdh\n' +
    'uBdESANgTOco2r5l7KHWSQOsqabZ7P4vt1TNg5RCtzAcaotPQgSK899sTNhcJ6Gv\n' +
    'Hq0digaaWSMGxDKaDM3eGRnU1mIIcALMKJ6CFwjAcQUCgYEA9uIPhc1NA1T5KxY3\n' +
    '7REmFnfVKyNSuNJ9Rgu6Wz+/rQQrDis1qIouH/9O0UDTGzch5SRRrOTu1b3zXtqG\n' +
    'GrFnIKfIwTOv1X7vIIyg/6St1UYrkDnghpLSv69evXKNRz6jEjoAFHe12BcZkDWp\n' +
    'GkXTUpPqQb5G+o/kIcnIYIC5TDcCgYEA0C7L76CRQxeecb+z9+LAGRI68J4O4Pi6\n' +
    'JMi1EWpNae0XXfaN7J/HqJOrpkuP3siUfik+yyb7VpCjniXOY7Yje/YM/eCXP+mJ\n' +
    'G0JcPfdOtbHysrmxZmw1H/KR6Tl2xLIGFlTUoBokPANizwCB96NynZcTpcD1/unc\n' +
    '5L2Ud4MmTNcCgYAhlWDNL79BK8b1UIFtEz8eIVDzHEv9bkyyQZgpH4Pgcke1FrWm\n' +
    '5p0dpyo+ltXgxuAqfoVJwp6mnr9DcPB7IxTHQWuytGg/35OB1v9zpyAqefAlH2pm\n' +
    'hAR9JMr7dGC5h1DBgvhN0HcBHStSDaqiM0tq2UothUe8f+RloEBMuFX8gwKBgHCy\n' +
    'xKfmTnz5jkaZtr1cvQ1Vdx7HEdrsCyjallrlJx9OwDWXwWD1Zkp2Fpghk7LQ9sIN\n' +
    'ZfboFWvZRRnZ8Y69DRyQKJxPNtHchOKC3BiXhr6JpI7oQ4bk0SWIVUDiYM8+aFky\n' +
    'dyBsxmzOkHDrH3CFxQhWvsYeXY0v4OrbTkIcd2FlAoGBAN7Z4YfQiPBAWXwLS0HX\n' +
    'sc91GT/SifrX672TAQRPEv26uGXg27Vf7gJR53nXQo5MzQDAeuTkXmjwTt7rMUX4\n' +
    'UyLhd8myC6T6CzJukae/74cCTQ1bgmzwsVQgKVjGrFTLBND7uzhx8A5UJUNUX2qG\n' +
    'bzZat8b4jWDn5y0cImr3xbC/'
  );
  public static final Blob PKCS8_PUBLIC_KEY = EncodingUtil.base64Decode(
    'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyMTN59sObrS8iFJneKLX\n' +
    '8qxGMJd7OxPY98iNg63AqN2XEbV+SN22WMXqvV81h+vj843jgc/n+S7SzczIo4bk\n' +
    'f5mCE8wYN2p+lPOy5MoOBOfpw2rfDT8AIhdOE5XTZf6DNt9RlM6OGBpdIAuhQZbD\n' +
    'hKFPlGmbQtkHSsSh+xhXvTcuPmCkXPG/7KCuYHRcyddjxXlp3z6y2j+NeZjZ9qXl\n' +
    'DoXpOGZ4uV5Xess4vQOY3Yi7fGQfo4IAiA/sxdstb/SEEMsIOCuhyHMyxuuSNDl2\n' +
    'Ujrt6XtLXdtujO9onFSC1yGHIwE71e3BUV3JGu//EnDcFuaV194DZlae8xZVk2lW\n' +
    'MQIDAQAB'
  );
}
