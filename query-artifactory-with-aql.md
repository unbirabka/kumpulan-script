berikut ini contoh untuk melakuykan

```
curl -u username:password -i -X POST "http://artifactory_host:8081/artifactory/api/search/aql" -H "Content-Type: text/plain" -d 'items.find({ "name": {"$match" : "rest-web*.jar"}, "name": {"$nmatch": "rest-web-NaN*.jar"}, "name": {"$nmatch": "rest-web-*sources.jar"}, "name": {"$nmatch": "rest-web-*javadoc.jar"}, "path": {"$match": "com/apps/slip/auth/rest-web/*"}, "path": {"$nmatch": "com/apps/slip/auth/rest-web/*SNAP*"}})'
```
