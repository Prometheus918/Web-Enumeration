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
	
echo "Installing Feroxbuster"	
	sudo apt install feroxbuster
	echo ""
	
echo "Installing Mass Scan"
	sudo apt-get install masscan
	echo ""

echo "Installing sublist3r"	
	sudo apt install sublist3r
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
echo "Running sublist3r to obtain $name subdomains"
sublist3r -d $name -v -t 5 -o /$path/$name/domains.txt  
#sed 's/^/https:\/\//' domains.txt > new_domains.txt
echo ""
echo ""

#Ferox to enumerate sub-directories and unique subdomains from js files
'''
echo "Running Feroxbuster to enumerate sub-directories"
cat /$path/$name/new_domains.txt | feroxbuster --stdin --silent -s 200 301 302 --redirects -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -o /$path/$name/ferox_output.txt
echo ""
echo ""
'''
#Host command to get IPs of Subdomains
echo "Running Host command to obtain IPs of $name"
for ip in $(cat /$path/$name/domains.txt);
		do host $ip;
	done | grep "has address" | cut -d " " -f4 | sort -u > /$path/$name/ip.txt

#Port Scanning
echo "Running Mass Scan On IPs"

masscan -p1-65535 -iL ip.txt --rate=100000 > /$path/$name/masscan.txt

#Visual Identification
echo "Running Eyewitness to Grab Screenshots of Subdomains"

eyewitness -f /$path/$name/domains.txt --web 
 
echo "Enumeration Complete!"
echo "Results Stored in $path/$name"
done
exit
