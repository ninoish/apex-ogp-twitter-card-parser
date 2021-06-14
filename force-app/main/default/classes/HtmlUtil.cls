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
    Integer statusCode = res.getStatusCode();
    if (statusCode == 200) {
      return res.getBody();
    } else if(statusCode >= 300 && statusCode <= 307 && statusCode != 306) {
        String newUrl = res.getHeader('Location');
        if(newUrl == null) {
            throw new HtmlUtilException('Redirect Error : ' + res.getStatusCode());
        }
        System.debug('Redirecting to ... ' + newUrl);
        return request(newUrl);
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

}
