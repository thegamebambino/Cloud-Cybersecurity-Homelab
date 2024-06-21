<h1>Cybersecurity Homelab with AWS and Terraform</h1>

 ### [YouTube Demonstration]()

<h2>Description</h2>
This project will guide you on the setup and configuration of a cloud-based cybersecurity homelab using AWS EC2 instances and a terraform script that automates the setup and teardown of resources. I'll be using some free-tier instances and some that cost money so I'll also show how to setup a billing alert for this lab.
<br />


<h2>Languages and Utilities Used</h2>

- <b>Python</b> 
- <b>WSL (Windows Subsystem for Linux)</b>
- <b>Terraform</b>
- <b>Amazon CLI</b>


<h2>Environments Used </h2>

- <b>Windows 10</b> (21H2)
- <b>Kali Linux</b>
- <b>Ubuntu Server</b>
- <b>Windows Server 2000</b>

<h2>Prerequisites:</h2>
  - <b>[Install Windows Subsystem for Linux:](https://learn.microsoft.com/en-us/windows/wsl/install)</b>
  
  - On the host machine, open Powershell in Administrator Mode and type the following code:
    
  ```bash
wsl --install
```
  
This will, by default install Ubuntu the system and provide a linux shell option within powershell.




<p align="center">
 <br/>
<img src="https://i.imgur.com/62TgaWL.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Select the disk:  <br/>
<img src="https://i.imgur.com/tcTyMUE.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Enter the number of passes: <br/>
<img src="https://i.imgur.com/nCIbXbg.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Confirm your selection:  <br/>
<img src="https://i.imgur.com/cdFHBiU.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Wait for process to complete (may take some time):  <br/>
<img src="https://i.imgur.com/JL945Ga.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Sanitization complete:  <br/>
<img src="https://i.imgur.com/K71yaM2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Observe the wiped disk:  <br/>
<img src="https://i.imgur.com/AeZkvFQ.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
