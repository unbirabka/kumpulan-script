#!/bin/bash

#function for tcp port 80 and 443 check
tcp_port_check () {
   for i in $(nslookup $nlb_url|grep Address|grep -v "#53"|awk -F " " {'print $2'})
   do
     export https=`nc -zv $i 443 -w 5 > /dev/null 2>&1 ; echo $?`
     export http=`nc -zv $i 80 -w 5 > /dev/null 2>&1 ; echo $?`
     if [ $https == 0 ]
     then
       echo "ingress $ingress_class dengan nlb url $i port 443 di eks $eks_cluster dapat terhubung"
     else
       curl -X POST --data-urlencode "payload={\"channel\": \"#catalyst-guard-gate\", \"username\": \"webhookbot\", \"text\": \"your ingress $ingress_class in $eks_cluster with nlb url \n- $nlb_url \n\nand A record ip \n- $i can't connect to tcp port 443.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/XXXXXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX > /dev/null 2>&1
     fi

     if [ $http == 0 ]
     then
       echo "ingress $ingress_class dengan nlb url $i port 80 di eks $eks_cluster dapat terhubung"
     else
       curl -X POST --data-urlencode "payload={\"channel\": \"#catalyst-guard-gate\", \"username\": \"webhookbot\", \"text\": \"your ingress $ingress_class in $eks_cluster with nlb url \n- $nlb_url \n\nand A record ip \n- $i can't connect to tcp port 80.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/XXXXXXXXXXX/XXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX > /dev/null 2>&1
     fi
   done
}


ingress_class="public"
nlb_url="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXX.elb.ap-southeast-1.amazonaws.com"
eks_cluster="sekolahlinux"
tcp_port_check

ingress_class="private"
nlb_url="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXX.elb.ap-southeast-1.amazonaws.com"
eks_cluster="sekolahlinux"
tcp_port_check


exit
