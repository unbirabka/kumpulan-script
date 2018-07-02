## active choice paramater only
jika kita ingin mendapatkan output dynamic dan berubah-ubah pada  active choices parameter, kita bisa memanfaatkan groovy script, dari groovy ini kita bisa memerintahkan untuk mengeksekusi script bash, yang outputnya bisa kita manfaatkan untuk digunakan sebagai value dari variable name/title active choices parameter
* **active choice paramater (groovy script)**
```
sekolahlinux = [];
bashscript = "/home/ubuntu/sekolahlinux.sh".execute().text;
bashscript.eachLine { sekolahlinux.push(it) };
return sekolahlinux;
```		
## active choice paramater & active choices reactive parameter
atau bisa juga dengan active choice paramater & active choices reactive parameter
* **active choice paramater (groovy script)**
```
return [
'SEKOLAHLINUX1',
'SEKOLAHLINUX2',
'SEKOLAHLINUX3',
]
```
* **active choice reactive paramater (groovy script)**
```
if (projects.equals("SEKOLAHLINUX1")) {
  return ["sekolahlinux1.sh"]
} else if (projects.equals("SEKOLAHLINUX2")) {
  return ["sekolahlinux2.sh"]
} else if (projects.equals("SEKOLAHLINUX3")) {
  return ["sekolahlinux3.sh"]
} else {
  return ["Unknown state"];
}
```

## untuk detailnya kamu bisa mengunjungi link plugin active choices parameter untuk jenkin dibawah
* **[active choices parameter](https://wiki.jenkins.io/display/JENKINS/Active+Choices+Plugin)**


