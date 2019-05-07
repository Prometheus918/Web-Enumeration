#!/bin/bash

#Dependencies Installations

echo "Need to Install a few tools to run the automated Web Enumeration Script"
while true
do
echo "Install/Update Dependencies?[y/n] "
read n
if [ $n = "y" ]
then

echo ""

echo "Installing Eyewitness"
	sudo apt-get install eyewitness
	echo ""

echo "Installing Mass Scan"
	sudo apt-get install masscan
	echo ""

echo "Installing Amass"
	sudo apt install snapd
	sudo systemctl start snapd
	sudo systemctl enable snapd
	sudo systemctl start apparmor
	sudo systemctl enable apparmor
	export PATH=$PATH:/snap/bin
	sudo snap refresh
	sudo snap install amass
	echo ""

echo "Dependencies up to date"
else
if [ $n = "n" ]
then
echo "Continuing with script "
else
echo "non-acceptable entry ... Press enter to continue"
read phew
exit
fi
fi

#Folder Creation
read -p "Enter Path to save results: " path
echo ""
read -p "Enter main domain name : " name
echo ""
echo "Creating Directory $name to Store Results."

	mkdir /$path/$name
	cd /$path/$name
	echo ""

#Subdomain Scrapping
echo "Running Amass to obtain $name subdomains"
amass -d $name > amass.txt 

echo ""
echo ""

#Host command to get IPs of Subdomains
echo "Running Host command to obtain IPs of $name"
for ip in $(cat amass.txt);
		do host $ip;
	done | grep "has address" | cut -d " " -f4 | sort -u > ip.txt

#Port Scanning
echo "Running Mass Scan On IPs"

masscan -p1-65535 -iL ip.txt --rate=100000 > masscan.txt

#Visual Identification
echo "Running Eyewitness to Grab Screenshots of Subdomains"

eyewitness -f /$path/$name/amass.txt --web 

rm amass.txt 
echo "Enumeration Complete!"
echo "Results Stored in $path/$name"
done
