public with sharing class OgpTwitterCardParser {
  public static Ogp parse(String url) {
    String html = HtmlUtil.request(url);
    String head = HtmlUtil.sanitizeHead(html);
    String ogpType = HtmlUtil.getMetaContent(head, 'og:type');
    String ogpUrl = HtmlUtil.getMetaContent(head, 'og:url');
    String ogpTitle = HtmlUtil.getMetaContent(head, 'og:title');
    String ogpImage = HtmlUtil.getMetaContent(head, 'og:image');
    String ogpImageUserGenerated = HtmlUtil.getMetaContent(
      head,
      'og:image:user_generated'
    );
    String ogpDesc = HtmlUtil.getMetaContent(head, 'og:description');
    String ogpSiteName = HtmlUtil.getMetaContent(head, 'og:site_name');

    Ogp ogp = new Ogp();
    ogp.type = ogpType;
    ogp.url = ogpUrl;
    ogp.title = ogpTitle;
    ogp.description = ogpDesc;
    ogp.siteName = ogpSiteName;
    return ogp;
  }
}
