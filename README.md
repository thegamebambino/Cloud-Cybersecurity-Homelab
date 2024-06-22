<h1>Cybersecurity Homelab with AWS and Terraform</h1>

 ### [YouTube Demonstration]()

<h2>Description</h2>
This project will guide you on the setup and configuration of a cloud-based cybersecurity homelab using AWS EC2 instances and a Terraform script that automates the setup and teardown of resources. I'll be using some free-tier instances and some that cost money so I'll also show how to setup a billing alert for this lab. This lab is setup using a Windows 10 machine.
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

<b>[Create an AWS Account](https://signin.aws.amazon.com/signup?request_type=register)</b>
- I will be using the free tier for this lab, although some of the resources incur a small fee. We will be using Terraform to automate the destruction of resources when they are not being used so no extra charges apply.
- Log into the console and ensure the region is set to "US-East-2" in the upper right corner. This region is important for the billing alerts we will set. Be sure all resources provisioned are in this region.

<p align="center">
Region Selection: <br/>
<img src="https://i.imgur.com/1YDkg7D.png" height="80%" width="80%" alt="Region Selection"/>
<br />

<b>Create a new IAM (Identity Access Management) User with Access Keys</b>
  - After logging into the AWS console, type IAM into the search box. OPTIONAL: Cick the STAR next to IAM to bookmark this page within the console screen.
<br />
<p align="center">
IAM Search: <br/>
<img src="https://i.imgur.com/wy5bVlZ.png" height="80%" width="80%" alt="IAM Search"/>
<br />

  - On the left sidebar under "Access Management" Click "Users", and in the next page, click "Create User" in the upper right.
  - Name the user "Terraform" and click "Next":
<br />
<p align="center">
New User Creation: <br/>
<img src="https://i.imgur.com/Yzcq5Pw.png" height="80%" width="80%" alt="New User Creation"/>
<br />

  - In the "Set Permissions" page, choose "Attach Policies Directly". In the search box below, type "VPCFullAccess" and select the policy, then again in the search box, type "EC2FullAccess" and select the policy. Click "Next"

<br />
<p align="center">
VPCFullAccess: <br/>
<img src="https://i.imgur.com/Jil9K4h.png" height="80%" width="80%" alt="VPCFullAccess"/>
<br />

<br />
<p align="center">
EC2FullAccess: <br/>
<img src="https://i.imgur.com/2QfdmZo.png" height="80%" width="80%" alt="EC2FullAccess"/>
<br />

  -In the "Review" page, ensure both policies are attached and click "Create User".
  -Back on the IAM > Users page, click the link of the new user. Below, select the "Security credentials" tab and scroll down to "Access Keys". Create a new access key.
  
<br />
<p align="center">
Security Credentials and Access Key: <br/>
<img src="https://i.imgur.com/Jil9K4h.png" height="80%" width="80%" alt="Security Credentials"/>
<br />




<b>[Install Windows Subsystem for Linux:](https://learn.microsoft.com/en-us/windows/wsl/install)</b>
  
  - On the host machine, open Powershell in Administrator Mode and type the following code:
    
```bash
wsl --install
```
  - Be sure to setup a new Linux username and secure password during setup
  - This will, by default install Ubuntu the system and provide a linux shell option within powershell (as well as a faster running Linux Shell application accessible in the Start menu:
<p align="center">   
Linux Shell:<br/>
<img src="https://i.imgur.com/HC523Fd.png" height="80%" width="80%" alt="Linux Shell"/>
<br />
<br />

<b>[Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)</b>
  - Type or copy the following text into the Ubuntu Shell:

  ```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

<b>[Install Terraform](https://developer.hashicorp.com/terraform/install)</b>
  - Type or copy the following code into the Ubuntu Shell:
 ```bash
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```








<p align="center">
Launch the utility: <br/>
<img src="https://i.imgur.com/62TgaWL.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />


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
