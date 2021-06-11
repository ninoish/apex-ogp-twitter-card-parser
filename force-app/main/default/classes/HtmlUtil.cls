public with sharing class HtmlUtil {
  // mimic facebook crawler
  private static final String BOT_USER_AGENT = 'facebookexternalhit';

  public static String request(String url) {
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('GET');
    req.setHeader('User-Agent', BOT_USER_AGENT);
    HttpResponse res = h.send(req);
    if (res.getStatusCode() == 200) {
      return res.getBody();
    } else {
      throw new HtmlUtilException('Request Error : ' + res.getStatusCode());
    }
  }

  public static String sanitizeHead(String html) {
    String head = html.substringBetween('<head>', '</head>');
    head = head.replaceAll('\r\n|\n|\r', '');
    head = head.replaceAll('<script[^>]*>(.*?)</script>', '');
    head = head.replaceAll('<style[^>]*>(.*?)</style>', '');
    return head;
  }

  public static String getMetaContent(String head, String property) {
    try {
      String regex =
        '<meta\\s[^>]*(property="' +
        property +
        '"|property=\'' +
        property +
        '\')[^>]*>';
      Pattern metaTagPattern = Pattern.compile(regex);
      Matcher m = metaTagPattern.matcher(head);
      if (m.find() && m.groupCount() > 0) {
        String target = m.group(0);
        String tregex = '<meta\\s[^>]*content="(.*)"[^>]*>';
        Pattern contentPattern = Pattern.compile(tregex);
        Matcher tm = contentPattern.matcher(target);
        if (tm.find() && tm.groupCount() > 0) {
          return tm.group(1);
        }
      }
      return null;
    } catch (Exception e) {
      System.debug(e.getMessage());
      throw new HtmlUtilException('Metadata Pasing Error');
    }
  }
}
