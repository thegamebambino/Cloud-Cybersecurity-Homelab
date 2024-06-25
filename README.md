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

<b>[Install Windows Subsystem for Linux:](https://learn.microsoft.com/en-us/windows/wsl/install)</b>
  
  - On the host machine, open Powershell in Administrator Mode and type the following code:
    
```bash
wsl --install
```
  - Be sure to setup a new Linux username and secure password during setup
  - This will, by default install Ubuntu the system and provide a linux shell option within powershell (as well as a faster running Linux Shell application accessible in the Start menu:
<p align="center">   
Linux Shell:<br/>
<img src="https://i.imgur.com/XUk3zdC.png" height="80%" width="80%" alt="Linux Shell"/>
<br />
<br />


<b>[Create an AWS Account](https://signin.aws.amazon.com/signup?request_type=register)</b>
- I will be using the free tier for this lab, although some of the resources incur a small fee. We will be using Terraform to automate the destruction of resources when they are not being used so no extra charges apply.
- Log into the console and ensure the region is set to "US-East-2" in the upper right corner. This region is important for the billing alerts we will set. Be sure all resources provisioned are in this region.

<p align="center">
Region Selection: <br/>
<img src="https://i.imgur.com/jH40Dmk.png" height="80%" width="80%" alt="Region Selection"/>
<br />

<b>Create a new IAM (Identity Access Management) User with Access Keys</b>
  - After logging into the AWS console, type IAM into the search box. OPTIONAL: Cick the STAR next to IAM to bookmark this page within the console screen.
<br />
<p align="center">
IAM Search: <br/>
<img src="https://i.imgur.com/XqGuSia.png" height="80%" width="80%" alt="IAM Search"/>
<br />

  - On the left sidebar under "Access Management" Click "Users", and in the next page, click "Create User" in the upper right.
  - Name the user "Terraform" and click "Next":
<br />
<p align="center">
New User Creation: <br/>
<img src="https://i.imgur.com/w0uMqrH.png" height="80%" width="80%" alt="New User Creation"/>
<br />

  - In the "Set Permissions" page, choose "Attach Policies Directly". In the search box below, type "VPCFullAccess" and select the policy, then again in the search box, type "EC2FullAccess" and select the policy. Click "Next"

<br />
<p align="center">
VPCFullAccess: <br/>
<img src="https://i.imgur.com/QzNItuC.png" height="80%" width="80%" alt="VPCFullAccess"/>
<br />

<br />
<p align="center">
EC2FullAccess: <br/>
<img src="https://i.imgur.com/3vPO83z.png" height="80%" width="80%" alt="EC2FullAccess"/>
<br />

  -In the "Review" page, ensure both policies are attached and click "Create User".
  -Back on the IAM > Users page, click the link of the new user. Below, select the "Security credentials" tab and scroll down to "Access Keys". Create a new access key.
  - On the first page of Access Keys, scroll down and select "Other" at the bottom. Click "Next"
<br />
<p align="center">
Access Key: <br/>
<img src="https://i.imgur.com/DK6Ew6P.png" height="80%" width="80%" alt="Access Key"/>
<br />

  - Create a tag (optional) and "Create access key".
  - As shown in the image, THIS IS THE ONLY TIME TO VIEW THE SECRET ACCESS KEY. Be sure to copy and paste both the Access Key and the Secret Access Key to a notepad file and save it somewhere secure.


<br />
<p align="center">
Access Key: <br/>
<img src="https://i.imgur.com/xIYuEOr.png" height="80%" width="80%" alt="Access Key"/>
<br />

<b>[Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)</b>
  - Type or copy the following text into the Ubuntu Shell:

 ```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

<b>Add Keys to AWS CLI</b>
  - Open the Ubuntu Shell and type or copy the following commands:
  - To confirm AWS is properly installed simply type:
    
```bash
aws
```
  - Change directory into the AWS directory:
```bash
cd ~/.aws
ls
```
  - There should be a "credentials" and "config" files within this directory. If these files are not present, they can be created using:
```bash
nano credentials
```
and
```bash
nano config
```

<p align="center">
AWS Files: <br/>
<img src="https://i.imgur.com/Ktdj1WY.png" height="80%" width="80%" alt="AWS Files"/>
<br />
<br />

  - Enter the secret key and secret access key from the newly created user into the credentials file. Save the file by pressing ctrl+x, y, and enter.

<p align="center">
Credentials File: <br/>
<img src="https://i.imgur.com/pig8rCJ.png" height="80%" width="80%" alt="Credentials file"/>
<br />
<br />

<b>Create a folder in the Home directory called "homelab'. This folder will hold the terraform automation scripts.

```bash
cd ~/
sudo mkdir projects
cd projects
sudo mkdir homelab
cd homelab
```

<b>[Install Terraform](https://developer.hashicorp.com/terraform/install)</b>
  - Type or copy the following code into the Ubuntu Shell:
 ```bash
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

<h2>Enable Billing Alerts</h2>

  - Some of our resources will incur a small fee, to monitor these fees, a billing alert is created to notify the user via email. First, ENABLE billing alerts:
  - To enable the monitoring of estimated charges
  - (Open the AWS Billing console)[https://console.aws.amazon.com/billing/].
  - In the navigation pane, choose Billing Preferences.
  - By Alert preferences choose Edit.
  - Choose Receive CloudWatch Billing Alerts.
  - Choose Save preferences.

<H2>Create a Billing Alert</H2>

  - To create a billing alarm using the CloudWatch console
  - (Open the CloudWatch console)[https://console.aws.amazon.com/cloudwatch/.
  - In the navigation pane, choose Alarms, and then choose All alarms.
  - Choose Create alarm.
  - Choose Select metric. In Browse, choose Billing, and then choose Total Estimated Charge.

<b>NOTE:</b>
<b>If you don't see the Billing/Total Estimated Charge metric, enable billing alerts, and change your Region to US East 2 (Ohio).</b>

  - Select the box for the EstimatedCharges metric, and then choose Select metric.
  - For Statistic, choose Maximum.
  - For Period, choose 6 hours.
  - For Threshold type, choose Static.
  - For "Whenever EstimatedCharges is . . .", choose Greater.
  - For "than . . .", define the value that you want to cause your alarm to trigger. For example, $10 USD, or whatever the intended budget for this homelab is.
  - The EstimatedCharges metric values are only in US dollars (USD), and the currency conversion is provided by Amazon Services LLC. For more information, see What is AWS Billing?.

<b>Note:
After you define a threshold value, the preview graph displays your estimated charges for the current month.</b>

  - Choose Additional Configuration and do the following:
  - For Datapoints to alarm, specify 1 out of 1.
  - For Missing data treatment, choose Treat missing data as missing.
  - Choose Next.
  - Under Notification, ensure that In alarm is selected. Then specify an Amazon SNS topic to be notified when your alarm is in the ALARM state. The Amazon SNS topic can include your email address so that you recieve email when the billing amount crosses the threshold that you specified.
  - Choose Next.
  - Under Name and description, enter a name for your alarm (HOMELAB)
  - Choose Next.
  - Under Preview and create, make sure that your configuration is correct, and then choose Create alarm.

<b>Now, when the AWS instances incur more than $10 USD fees, an alert will be sent to email.</b>


<h2>Launch the Utility</h2>
<b>In order to securely access the EC2 instances, an SSH key is needed.
 
  - In the AWS Console, create a new SSH Key Pair

  - In the EC2 dashboard, select "Key Pairs", then in the upper right corner "Create New Key Pair"
  
<p align="center">
Create Key Pair: <br/>
<img src="https://i.imgur.com/FQ12ZdN.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
 
  - Give the key pair a name like "Terraform"
  - Select the "RSA" encryption format
  - Select the ".pem" file format
  - Create key pair

<p align="center">
Download Key Pair: <br/>
<img src="https://i.imgur.com/AM16Lqq.png" height="80%" width="80%" alt="Download Key Pair"/>
<br />
<br />

  - This will initiate a download of the key pair. Save the key pair .pem file in the Ubuntu .ssh directory

<p align="center">
.ssh directory: <br/>
<img src="https://i.imgur.com/MSznLuo.png" height="80%" width="80%" alt="ssh directory"/>
<br />
<br />


<h2>Launch the Terraform Utility</h2>
   - Navigate to the homelab directory and clone the required terraform files:
    - install git if needed with:
    
```bash
sudo apt install git
```

and clone this repository into the directory:

```bash
git clone https://github.com/thegamebambino/Cloud-Cybersecurity-Homelab.git
```

  - This will copy the README and Terraform (.tf) files from this repository into the homelab directory.
  - Initialize Terraform with: 
   
```bash
terraform init
```
then

```bash
terraform plan
```
<b>NOTE: If there are any errors in the Terraform scripts, they will show here. Files can be edited and the "plan" command run again.

then if everything looks right with no errors, execute:

```bash
terraform apply -var="aws-key-Terraform"
```
  - Make sure the key matches the .pem file in the .ssh folder.


<p align="center">
Launch the utility: <br/>
<img src="https://i.imgur.com/jHwPWpu.png" height="80%" width="80%" alt="Launch the Utility"/>
<br />
<br />

<h2>Connect to EC2 Instances</h2>

<b>First, configure remote access (RDP) for the Kali Linux Machine:
  - Change directory into:

```bash
~/.ssh
```

  - Change the permissions for the Terraform.pem file to read only:

```bash
sudo chmod 400 Terraform.pem
```
  - In the AWS console,right-click the kali instance and click "connect" or check the box next to the Kali instance and, at the top of the screen, select "Connect"
<p align="center">
Connect to Kali (right-click): <br/>
<img src="https://i.imgur.com/SvXXc0V.png" height="80%" width="80%" alt="Connect to kali (right-click)"/>
<br />
<br />


  - In the "Connect to Instance" screen, copy the example ssh command

<p align="center">
Copy SSH command: <br/>
<img src="https://i.imgur.com/XvmCLHI.png" height="80%" width="80%" alt="SSH Command"/>
<br />
<br />

  - Paste the SSH command into the Ubuntu Shell. There may be a warning displayed, type yes to continue. It will ask you to log in as "kali" rather than root, so change the command to the following:

<p align="center">
paste and edit command: <br/>
<img src="https://i.imgur.com/ievqgI8.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />

  - With the correct login command of "kali@ec2-**-***-***-***.us-east-2.compute.amazonaws.com the screen should look like the above screen capture.


<b>To configure RDP on this Kali machine type or copy:

```bash
nano rdp.sh
```
  -Press Enter and in the new note, paste the following script:

```bash
#!/bin/sh
echo "[i] Updating and upgrading Kali (this will take a while)"
apt-get update
apt-get full-upgrade -y
echo "[i] Installing Xfce4 & xrdp (this will take a while as well)"
apt-get install -y kali-desktop-xfce xorg xrdp

echo "[i] Configuring xrdp to listen to port 3389 (but not starting the service)"
sed -i 's/port=3389/port=3389/g' /etc/xrdp/xrdp.ini
```

  - This will update and upgrade the repositories, install xrdp, and configure it to listen on port 3389.
  - Ctrl+x, y, enter to save this.
  - Back in the main shell, change the permissions of the file with:

```bash
chmod 755 rdp.sh
```

  - Change to root user:
```bash
sudo su
```
then

```bash
./rdp.sh
```

  - The script will run (this may take a while).

    
 <p align="center">
Running the script: <br/>
<img src="https://i.imgur.com/oj057RO.png" height="80%" width="80%" alt="Running the Script"/>
<br />
<br />   
  - NOTE: If there is a full screen pop up about restarting services, select "yes" and continue
  - Hit enter on this screen to keep the local version

 <p align="center">
Keep the local version: <br/>
<img src="https://i.imgur.com/S3qSxRU.png" height="80%" width="80%" alt="Keep the Local Version"/>
<br />
<br /> 

 <b>Once the script is done, use the following command to change the password (choose a secure password in a production environment, but for this practice lab we'll just use the default "kali":</b>

 ```bash
echo kali:kali | sudo chpasswd
```

<b>Enable XRDP</b>

```bash
systemctl enable xrdp --now
```

<b>Check Status</b>

```bash
systemctl status xrdp
```

  - We want to see "enabled" and "active" in the output

<p align="center">
Enabled and Active: <br/>
<img src="https://i.imgur.com/PmI3P8G.png" height="80%" width="80%" alt="Enabled and Active"/>
<br />
<br />

   - In the AWS EC2 console, select the Kali instance and copy the public IP address:

  - In the windows host machine, Start Menu, Search or "Run" box, type "mstsc". This will open the remote desktop service where you can paste your Kali public IP address.
  - NOTE: If there is a warning about the identity of the machine, click OK and remeber the Kali machine.

<p align="center">
Remote Desktop: <br/>
<img src="https://i.imgur.com/MdxFN9S.png" height="80%" width="80%" alt="Remote Desktop"/>
<br />
<br />

  - In the Kali machine, log in with the username "kali" and the password "kali" and the Kali Home screen will appear.

<p align="center">
Kali Homescreen: <br/>
<img src="https://i.imgur.com/QeFUoti.png" height="80%" width="80%" alt="Kali Homescreen"/>
<br />
<br />


<h2>Log Into the Ubuntu Instance</h2>
  - In the AWS EC2 console, select the "Security-Tools" instance and copy the public IP address. Open a new tab in the browser and paste the IP. The instance will run in the browser!

  - NOTE: THE PASSWORD FOR THIS SESSION IS THE EC2 INSTANCE ID. Copy and paste the instance ID from the AWS EC2 console into the Ubuntu Web Session at the top (middle) of the screen:


<p align="center">
Successful Login: <br/>
<img src="https://i.imgur.com/cQgVyVk.png" height="80%" width="80%" alt="Successful Login"/>
<br />
<br />
  - Click Next or configure the options and you will be presented with the Homescreen. Click the "Change VNC Password" so at the next login, you don't have to copy and paste the InstanceID.

<p align="center">
Change VNC Password: <br/>
<img src="https://i.imgur.com/1NOulJk.png" height="80%" width="80%" alt="Change VNC Password"/>
<br />
<br />



 
<h2>Log into Windows Instances using Remote Desktop</h2>

  - In the AWS EC2 console, right-click the Windows AD Instance and click "connect".
  - 
<p align="center">
Connect: <br/>
<img src="https://i.imgur.com/fid05zL.png" height="80%" width="80%" alt="Windows Connect"/>
<br />
<br />

In the "Connect to Instance" page, select the "RDP Client" tab.

<p align="center">
RDP Client: <br/>
<img src="https://i.imgur.com/KY3ttpn.png" height="80%" width="80%" alt="RDP Client"/>
<br />
<br />
  - Scroll to the bottom of the RDP Client page and click "Get Password.
  - Navigate to the .ssh directory and choose the "Terraform.pem" file created earlier:

<p align="center">
Uploading .pem file: <br/>
<img src="https://i.imgur.com/wKIACQZ.png" height="80%" width="80%" alt="Uploading .pem file"/>
<br />
<br />

  - Once uploaded, click "Decrypt Password".
  - Open a new Remote Desktop Session on the Windows host.
  - Paste the Windows AD Public IP Address.
  - If there is a warning, click yes to remember the Windows AD Instance
  - login with the username "Administrator" and the decrypted password from the AWS console.
<b>Windows Server starts up!</b>
<b>NOTE: THESE STEPS WILL ALSO LAUNCH THE SECOND WINDOWS INSTANCE. The public IP will be different, but the encrypted password steps will be the same.




 

  









<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
