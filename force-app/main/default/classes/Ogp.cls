public class Ogp {
  // https://ogp.me

  // Basics
  @AuraEnabled
  public String title;
  @AuraEnabled
  public String type;
  @AuraEnabled
  public Image image;
  @AuraEnabled
  public String url;

  // Optionals
  @AuraEnabled
  public Audio audio;
  @AuraEnabled
  public String description;
  @AuraEnabled
  public String determiner;
  @AuraEnabled
  public String locale;
  @AuraEnabled
  public String siteName;
  @AuraEnabled
  public Video video;

  public class Image {
    public Image(String url) {
      this.url = url;
    }

    public Image(
      String url,
      String secureUrl,
      String type,
      String width,
      String height,
      String alt
    ) {
      this.url = url;
      this.secureUrl = secureUrl;
      this.type = type;
      this.width = width;
      this.height = height;
      this.alt = alt;
    }

    @AuraEnabled
    public String url;
    @AuraEnabled
    public String secureUrl;
    @AuraEnabled
    public String type;
    @AuraEnabled
    public String width;
    @AuraEnabled
    public String height;
    @AuraEnabled
    public String alt;
  }
  public class Video {
    public Video(String url) {
      this.url = url;
    }

    public Video(
      String url,
      String secureUrl,
      String type,
      String width,
      String height,
      String alt
    ) {
      this.url = url;
      this.secureUrl = secureUrl;
      this.type = type;
      this.width = width;
      this.height = height;
      this.alt = alt;
    }
    @AuraEnabled
    public String url;
    @AuraEnabled
    public String secureUrl;
    @AuraEnabled
    public String type;
    @AuraEnabled
    public String width;
    @AuraEnabled
    public String height;
    @AuraEnabled
    public String alt;
  }
  public class Audio {
    public Audio(String url) {
      this.url = url;
    }

    public Audio(String url, String secureUrl, String type) {
      this.url = url;
      this.secureUrl = secureUrl;
      this.type = type;
    }
    @AuraEnabled
    public String url;
    @AuraEnabled
    public String secureUrl;
    @AuraEnabled
    public String type;
  }
}
