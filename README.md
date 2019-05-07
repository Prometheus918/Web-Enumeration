# Web_Enum
A simple tool for web enumeration

One of the most important steps in web application testing or bug bounty hunting is enumeration. Enumeration is the first attack on target network. It is the process of actively or passively collecting information about the target. The more information we collect about the target, the easier it becomes to exploit the target in further steps. Although web enumeration holds so much importance in testing, it is one of the most neglected steps by many pen-testers.

This tool automates a few steps of web enumeration.
The processes covered are:
-Subdomain Enumeration (Using OWASP Amass)
A subdomain is, as the name would suggest, an additional section of your main domain name. In most cases, the main domain of a website is tested on by many pen-testers and the subdomains are left untouched. Due to this, many critical vulnerabilities are left un-exploited on these sub-domains. Also, many times, developers leave some private subdomains publicly available. These subdomains can contain useful information regarding the target or organization. Due to this reason it is always useful to find as many subdomains of the target as possible. 

-IP Identification (host command)
Identifying the IP addresses target is the initial step of enumeration. It helps in further steps of active scanning.

-Port Scanning (masscan)
Port scanning is used to determine what ports a system may be listening on. This will help an attacker to determine what services may be running on the system. According to the services being run, the attacker might find ways to exploit vulnerabilities of the system and gain unauthorized access.

-Visual Identification (Eyewitness)
Visual Identification is an important step to categorize our targets. It helps us understand what web applications are running on the different subdomains and decide which targets may be easy to exploit.

The scripts also provides options for installing/updating the above tools.

Will keep updating the above script for more functionality.

Suggestions are welcome :)
