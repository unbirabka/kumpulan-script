# artifactory query leanguage
## contoh query dengan curl
**contoh-1 tanpa file pom.xml**
```
curl -u username:password -i -X POST "http://artifactory_host:8081/artifactory/api/search/aql" -H "Content-Type: text/plain" -d 'items.find({ "name": {"$match" : "rest-web*.jar"}, "name": {"$nmatch": "rest-web-NaN*.jar"}, "name": {"$nmatch": "rest-web-*sources.jar"}, "name": {"$nmatch": "rest-web-*javadoc.jar"}, "path": {"$match": "com/sekolahlinux/auth/rest-web/*"}, "path": {"$nmatch": "com/sekolahlinux/auth/rest-web/*NaN*"}})'
```
**contoh-2 dengan file pom.xml**
```
curl -s -u username:password -i -X POST "http://artifactory_host:8081/artifactory/api/search/aql" -H "Content-Type: text/plain" -d 'items.find({ "name": {"$match" : "rest-web*.jar"}, "name": {"$nmatch": "rest-web-NaN*.jar"}, "name": {"$nmatch": "rest-web-*sources.jar"}, "name": {"$nmatch": "rest-web-*javadoc.jar"}, "path": {"$match": "'`cat pom.xml|grep -m 1 "groupId"|awk -F ">" {'print $2'}|awk -F "<" {'print $1'}|sed 's/\./\//g'`'/*"}, "path": {"$nmatch": "'`cat pom.xml|grep -m 1 "groupId"|awk -F ">" {'print $2'}|awk -F "<" {'print $1'}|sed 's/\./\//g'`'/*model*"}, "repo": {"$eq": "libs-release-local"}})'|grep name|awk -F "\"" {'print $4'}|awk -F"\.jar" {'print $1'}|sed 's/rest-web-//g'
```
**atau**
```
curl -s -u username:password -X POST -H "Content-Type: text/plain" -d 'items.find({"name":{"$match":"rest-web*.jar"}, "name":{"$nmatch":"rest-web*javadoc.jar"}, "name":{"$nmatch":"rest-web*sources.jar"}, "path":{"$match":"'`cat pom.xml | grep -E -m 1 -o "<groupId>(.*)</groupId>" | cut -d \> -f 2 | cut -d \< -f 1 | sed -e 's/\./\//g'`'/rest-web/*"}})' http://artifactory_host:8081/artifactory/api/search/aql
```
**contoh-3 parsing menggunakan jq**
```
curl -s -u jenkins:jenkins@123  -X POST "http://13.228.24.146:8081/artifactory/api/search/aql" -H "Content-Type: text/plain" -d 'items.find({ "name": {"$match" : "rest-web*.jar"}, "name": {"$nmatch": "rest-web-NaN*.jar"}, "name": {"$nmatch": "rest-web-*sources.jar"}, "name": {"$nmatch": "rest-web-*javadoc.jar"}, "path": {"$match": "com/tiket/tix/auth/*"}, "path": {"$nmatch": "com/tiket/tix/auth/*model*"}, "repo": {"$eq": "libs-release-local"}})'|jq .results|jq 'sort_by(.updated)'|jq reverse|grep -m 3 "name"|awk -F "\"" {'print $4'}|sed 's/rest-web-//g'|sed 's/.jar//g'
```

## link belajar artifactory
* **[curl aql and content type header](https://jfrog.com/knowledge-base/aql-and-content-type-headers/)**
* **[artifactory query leanguage details](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language)**
* **[aql comparison operator](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language#ArtifactoryQueryLanguage-ComparisonOperators)**
* **[aql entities field](https://www.jfrog.com/confluence/display/RTF/Artifactory+Query+Language#ArtifactoryQueryLanguage-EntitiesandFields)**
