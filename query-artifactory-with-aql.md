# artifactory query leanguage
## contoh query dengan curl
```
curl -u username:password -i -X POST "http://artifactory_host:8081/artifactory/api/search/aql" -H "Content-Type: text/plain" -d 'items.find({ "name": {"$match" : "rest-web*.jar"}, "name": {"$nmatch": "rest-web-NaN*.jar"}, "name": {"$nmatch": "rest-web-*sources.jar"}, "name": {"$nmatch": "rest-web-*javadoc.jar"}, "path": {"$match": "com/apps/slip/auth/rest-web/*"}, "path": {"$nmatch": "com/apps/slip/auth/rest-web/*SNAP*"}})'
```

## link belajar artifactory
* **[curl aql and content type header](https://jfrog.com/knowledge-base/aql-and-content-type-headers/)**
* **[artifactory query leanguage details](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language)**
* **[aql comparison operator](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language#ArtifactoryQueryLanguage-ComparisonOperators)**
* **[aql entities field](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language#ArtifactoryQueryLanguage-EntitiesandFields)**
