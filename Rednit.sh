#!/bin/bash

##  Loads the file path to a variable
echo -e "\n\n\n Select your Rednit matches file\n\n\n"
read t_file

## Checking file
ls -lh $t_file

##  Separates the ID's
awk '/"_id": "/ {print $2}' $t_file | tr ',' ' ' | tr -d '"'> /tmp/id.rednit

##  Count the number of ID'S
id_num=$(cat /tmp/id.rednit | wc -l)

##  Check for the existance of this file
isso_n_ecxisti=$(ls /tmp/URL.dirt 2>&1 > /dev/null; echo $?)

echo "$isso_n_ecxisti"

if [ $isso_n_ecxisti -eq 0 ]; then
  echo -e "Cleaning out the dirt...\n"
  rm /tmp/URL.dirt
else
  echo -e "No dirt found\n"
fi

## Counting var 4 the loop
i=1

## Do a loop to get every ID
while [ $i -le $id_num ]
do
get_id=$(awk '{if(NR=='$i') print $0}' /tmp/id.rednit)
echo -e "Printing...$i\n"
i=$[$i+1]
cat $t_file | grep $get_id | grep "640" >> /tmp/URL.dirt
done

##  Use this shit to troubleshoot
#echo "We got this far..."
awk '/"url": "/ {print $2}' /tmp/URL.dirt | tr -d '"' | tr -d "," > /tmp/URL.clean

id_url=$(cat /tmp/URL.clean | wc -l)

##  Use this shit to troubleshoot
echo "So far so good"

i2=1
while [ $i2 -le $id_url ]
do get_url=$(awk '{if(NR=='$i2') print $0}' /tmp/URL.clean)
echo $get_url
firefox --private-window $get_url
i2=$[$i2+1]
done
