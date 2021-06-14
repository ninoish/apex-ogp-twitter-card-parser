public with sharing class OgpTwitterCardParser {
  public static Ogp parse(String url) {
    String html = HtmlUtil.request(url);
    try {
      String head = HtmlUtil.sanitizeHead(html);
      Map<String, String> ogpMap = getOgps(head);
      ogpMap.putAll(getTwitter(head));
      Ogp ogp =  new Ogp(ogpMap);
      System.debug(ogp);
      return ogp;
    } catch (HtmlUtilException htmle) {
      return null;
    } catch (OgpException ogpe) {
      return null;
    }
  }

  private static Map<String, String> getOgps(String head) {
    return getMetaMaps(head, 'og:');
  }

  private static Map<String, String> getTwitter(String head) {
    return getMetaMaps(head, 'twitter:');
  }

  private static Map<String, String> getMetaMaps(String head, String prefix) {
    try {
      Map<String, String> mp = new Map<String, String>();
      String regex =
        '<meta\\s[^>]*(property="(' +
        prefix +
        '[^"]+)"|property=\'(' +
        prefix +
        '[^\']+)\')[^>]*>';
      Pattern pat = Pattern.compile(regex);
      Matcher m = pat.matcher(head);
      while (m.find() == true) {
        String content = 'content="([^"]+)"|content=\'([^\'])\'';
        Pattern contentPattern = Pattern.compile(content);
        Matcher cm = contentPattern.matcher(m.group(0));
        if (cm.find()) {
          String key = m.group(2);
          if (String.isBlank(key)) {
            key = m.group(3);
          }
          String value = cm.group(1);
          if (String.isBlank(value)) {
            value = cm.group(2);
          }
          mp.put(key, value);
        }
      }
      return mp;
    } catch (Exception e) {
      System.debug(e.getMessage());
      throw new OgpException('Metadata Pasing Error');
    }
  }
}
