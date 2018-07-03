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

## other sample build with paramater with pipeline
pada sample ini saya ingin agar ketika memilih suatu project maka akan muncul version jar release dari artifactory, serta muncul nama file shell untuk menjalankan ansible

**name: projects**

**type: active choice paramater**
* Groovy Script
```
return [
'SEKOLAHLINUX-1',
'SEKOLAHLINUX-2',
]
```
* Fallback Script
```
return ['Error’]
```

**name: version**

**type: active choice reactive paramater-1**
* Groovy Script
```
if (projects.equals("SEKOLAHLINUX1")) {
  linux = [];
  bash = "bash /home/ubuntu/artifactory-sekolah.sh com/sekolahlinux/apps/image".execute().text;
  bash.eachLine { linux.push(it) };
  return linux;
} else if (projects.equals("SEKOLAHLINUX2")) {
  linux = [];
  bash = "bash /home/ubuntu/artifactory-sekolah.sh com/sekolahlinux/apps/calendar".execute().text;
  bash.eachLine { linux.push(it) };
  return linux;
} else {
  return ["Unknown state"];
}
```
* Fallback Script
```
return ['Error’]
```
* Referenced parameters (projects)


**name: ansible**

**type: active choice reactive paramater-2**
* Groovy Script
```
if (projects.equals("SEKOLAHLINUX1")) {
  return ["sekolahlinux-ansible-image.sh"]
} else if (projects.equals("SEKOLAHLINUX2")) {
  return ["sekolahlinux-ansible-calendar.sh"]
} else {
  return ["Unknown state"];
}
```
* Fallback Script
```
return ['Error’]
```
* Referenced parameters (projects)


**type: pipeline groovy script**
```
node {
   stage('Deploy') {
    sh 'ssh ubuntu@ip-ansible-server "sudo /home/ubuntu/ansible/deploy/hotfix/"${ansible}" "${version}""'
   }
   stage('Results') {
    echo "Success"   
   }
}
```

## untuk detailnya kamu bisa mengunjungi link plugin active choices parameter untuk jenkin dibawah
* **[active choices parameter](https://wiki.jenkins.io/display/JENKINS/Active+Choices+Plugin)**


