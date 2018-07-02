## active choice paramater only
jika kita ingin mendapatkan output dynamic dan berubah-ubah pada  active choices parameter, kita bisa memanfaatkan groovy script, dari groovy ini kita bisa memerintahkan untuk mengeksekusi script bash, yang outputnya bisa kita manfaatkan untuk digunakan sebagai value dari variable name/title active choices parameter
* **active choice paramater (groovy script)**
```
tags = [];
text = "/home/ubuntu/script_bash.sh".execute().text;
text.eachLine { tags.push(it) };
return tags;
```		
## active choice paramater & active choices reactive parameter
atau bisa juga dengan active choice paramater & active choices reactive parameter
* **active choice paramater (groovy script)**
```
return [
'TIX-API-PROMOCODE',
'TIX-CALENDAR-BE',
'TIX-GATEWAY',
]
```
* **active choice reactive paramater (groovy script)**
```
if (projects.equals("TIX-API-PROMOCODE")) {
  return ["tiket-tix-api-promocode-allt.sh"]
} else if (projects.equals("TIX-CALENDAR-BE")) {
  return ["tiket-tix-calendar-be-allt.sh"]
} else if (projects.equals("TIX-GATEWAY")) {
  return ["tiket-tix-gateway-all.sh"]
} else {
  return ["Unknown state"];
}
```


