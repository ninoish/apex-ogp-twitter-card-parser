# Apex OGP & Twitter Card Parser

Retrieve and Parse Open Graph Protocol & Twitter Card values from URL in Apex.

## How to use

You only need to code like this.
```apex
Ogp ogp = OgpTwitterCardParser.parse(url);
```

Below shows an example scenario to get OGP data from a tweet when a Case record's tweet url field value changed.

When you try in your env, you must add Twitter URL (https://twitter.com) to your remote site settings.


```apex
trigger CaseTweetOgpTrigger on Case(after insert, after update) {
  List<Id> targetCases = new List<Id>();
  for (Case c : Trigger.new) {

    // Assume you have a field named TweetUrl__c containing Tweet URL. 
    if (String.isNotBlank(c.TweetUrl__c)) {
      if (Trigger.isUpdate) {
        Case oldC = Trigger.oldMap.get(c.Id);
        if (oldC.TweetUrl__c == c.TweetUrl__c) {
          continue;
        }
      }
      targetCases.add(c.Id);
    }
  }
  // Prevent trigger from invoking loop
  if(targetCases.size() > 0) {
    CaseTweetOgpRetriever.callout(targetCases);
  }
}
```

```apex
public with sharing class CaseTweetOgpRetriever {

  @future(callout=true)
  public static void callout(List<Id> targetCaseIds) {

    // Assume that you want to keep OGP data in a Case record with the following respecive fields.
    List<Case> cs = [
      SELECT
        TweetUrl__c,
        OgpUrl__c,
        OgpType__c,
        OgpTitle__c,
        OgpDescription__c,
        OgpSiteName__c,
        OgpImageUrl__c
      FROM Case
      WHERE Id IN :targetCaseIds
    ];
    for (Case c : cs) {
      // OGP Information fetched here
      Ogp ogp = OgpTwitterCardParser.parse(c.TweetUrl__c);
      if (ogp == null) {
        continue;
      }
      c.OgpUrl__c = ogp.url;
      c.OgpType__c = ogp.type;
      c.OgpTitle__c = ogp.title;
      c.OgpDescription__c = ogp.description;
      c.OgpSiteName__c = ogp.siteName;
      c.OgpImageUrl__c = ogp.image?.url;
    }
    update cs;
  }
}

```

## Structure

### OGP class
- String title
- String type
- String url
- String description
- String determiner
- String locale
- String siteName
- Ogp.Image image
- Ogp.Video video
- Ogp.Audio audio
- Ogp.Twitter twitter

### OGP.Image class
- String url
- String secureUrl
- String type
- String width
- String height
- String alt
### OGP.Video class
- String url
- String secureUrl
- String type
- String width
- String height
- String alt

### OGP.Audio class
- String url
- String secureUrl
- String type
- String width
- String height
- String alt

### OGP.Twitter class
- String card
- String site
- String title
- String image
- String description
- String player

## LICENSE
Licensed under BSD-3
