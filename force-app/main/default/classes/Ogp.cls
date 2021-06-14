public class Ogp {
  // https://ogp.me

  public Ogp(Map<String, String> ogpMap) {
    this.title = ogpMap.get('og:title');
    this.type = ogpMap.get('og:type');
    this.url = ogpMap.get('og:url');
    this.description = ogpMap.get('og:description');
    this.siteName = ogpMap.get('og:site_name');
    this.determiner = ogpMap.get('og:determiner');
    this.locale = ogpMap.get('og:locale');
    this.image = new Ogp.Image(ogpMap);
    this.audio = new Ogp.Audio(ogpMap);
    this.video = new Ogp.Video(ogpMap);
    this.twitter = new Ogp.Twitter(ogpMap);
  }

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
  @AuraEnabled
  public Twitter twitter;

  public class Image {
    public Image(Map<String, String> ogpMap) {
      this.url = ogpMap.get('og:image');
      if (String.isBlank(this.url)) {
        this.url = ogpMap.get('og:image:url');
      }
      this.secureUrl = ogpMap.get('og:image:secure_url');
      this.type = ogpMap.get('og:image:type');
      this.width = ogpMap.get('og:image:width');
      this.height = ogpMap.get('og:image:height');
      this.alt = ogpMap.get('og:image:alt');
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
    public Video(Map<String, String> ogpMap) {
      this.url = ogpMap.get('og:video');
      if (String.isBlank(this.url)) {
        this.url = ogpMap.get('og:video:url');
      }
      this.secureUrl = ogpMap.get('og:video:secure_url');
      this.type = ogpMap.get('og:video:type');
      this.width = ogpMap.get('og:video:width');
      this.height = ogpMap.get('og:video:height');
      this.alt = ogpMap.get('og:video:alt');
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
    public Audio(Map<String, String> ogpMap) {
      this.url = ogpMap.get('og:audio');
      if (String.isBlank(this.url)) {
        this.url = ogpMap.get('og:audio:url');
      }
      this.secureUrl = ogpMap.get('og:audio:secure_url');
      this.type = ogpMap.get('og:audio:type');
    }
    @AuraEnabled
    public String url;
    @AuraEnabled
    public String secureUrl;
    @AuraEnabled
    public String type;
  }
  public class Twitter {

    public Twitter(Map<String, String> ogpMap) {
        this.card = ogpMap.get('twitter:card');
        this.site = ogpMap.get('twitter:site');
        this.title = ogpMap.get('twitter:title');
        this.image = ogpMap.get('twitter:image');
        this.description = ogpMap.get('twitter:description');
        this.player = ogpMap.get('twitter:player');
      }

    @AuraEnabled
    public String card;
    @AuraEnabled
    public String site;
    @AuraEnabled
    public String title;
    @AuraEnabled
    public String image;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String player;
  }
}
