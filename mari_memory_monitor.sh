#!bin/bash
export PATH=$PATH

DATE=`date +%Y%m%d`
declare -A SERVER
declare -A TS_SERVER
declare -A M
declare -A N
L=0
P=0

#Add route 

SERVER=(['CC1NMLC1-CP2-PRD']='http://172.30.183.60' ['CC1NMRP1-CP2-PRD']='http://172.30.183.62' ['CC1NMRP2-CP2-PRD']='http://172.30.183.63' ['CC1NMRP1-TYN-PRD']='http://172.30.181.66' ['CC1NMRP2-TYN-PRD']='http://172.30.181.67' ['CC1NMTN1-TYN-PRD']='http://172.30.181.68' ['CC1NMLC1-TYN-PRD']='http://172.30.181.69')

TS_SERVER=(['CCMRA01-GYM-PRD']='http://172.30.149.144' ['CCMRA02-GYM-PRD']='http://172.30.149.145' ['CCMRL01-GYM-PRD']='http://172.30.149.146' ['CCMRT01-GYM-PRD']='http://172.30.149.147')


echo "Memory on Mari server"
for i in "${!SERVER[@]}"; do 
    echo -n "Server: $i Memory: ${SERVER[$i]} = " ; curl -u admin:pass ${SERVER[$i]}:2812/  2>/dev/null  | awk -F'GB]' {'print $1'} | awk -F'>' {'print $79'} | awk -F' ' {'print $1'}
    
    M[$L]=`curl -u admin:pass ${SERVER[$i]}:2812/  2>/dev/null  | awk -F'GB]' {'print $1'} | awk -F'>' {'print $79'} | awk -F' ' {'print $1'}`
    ((L++)) 
done
printf '%s\n' $DATE `for i in {0..6}; do echo -n "${M[$i]} ";done` | paste -sd ' ' >> /root/script/mari.csv

    

echo ''
echo ''
echo "Memory on ThaiSmile server"
for j in "${!TS_SERVER[@]}"; do
    echo -n "Server: $j Memory: ${TS_SERVER[$j]} = " ; curl -u admin:pass ${TS_SERVER[$j]}:2812/  2>/dev/null  | awk -F'GB]' {'print $1'} | awk -F'>' {'print $79'} | awk -F' ' {'print $1'}
    N[$P]=`curl -u admin:pass ${TS_SERVER[$j]}:2812/  2>/dev/null  | awk -F'GB]' {'print $1'} | awk -F'>' {'print $79'} | awk -F' ' {'print $1'}`
    ((P++))
done
printf '%s\n' $DATE `for k in {0..3}; do echo -n "${N[$k]} ";done` | paste -sd ' ' >> /root/script/thaismile.csv
