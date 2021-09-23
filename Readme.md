# Setting up Wsl2 Ubuntu

- ### [Installing Wsl2](#1-installing-wsl2)
- ### [Installing Ubuntu from Microsoft Store](#2-installing-ubuntu-from-microsoft-store)
- ### [Installing Coding Tools](#3-installing-coding-tools)
  - ### [Installing Java and Maven](#31-installing-java-and-maven)
  - ### [Installing NPM](#32-installing-npm)
  - ### [Installing MySQL](#33-installing-mysql)
  - ### [Installing Gcc and Make](#34-installing-gcc-and-make)
  - ### [Installing Python and Anaconda](#35-installing-python-and-anaconda)
- ### [Solving some issues](#solving-some-issues)
  - ### [4.1. File System Access Errors](#41-file-system-access-errors)
  - ### [4.2. Making VSCode work properly with Anaconda](#42-making-vscode-work-properly-with-anaconda)

<br/>

## <span style="color: #028A0F">**1. Installing Wsl2**</span>

You can install the Windows subsystem for linux by simply tying into your Command Prompt / Windows Power Shell / Windows Terminal the command:

    wsl --install

<br/>

If you have any issue with this it could mean you have a version of windows that doesn't directly support Wsl. Only some windows 10 versions do. If this happens you can try to install it <em>the old way</em>.

This old way is basically a set of commands that Microsoft combined. You can start by typing the following commands into a **Windows Power Shell and you should <em>Run as Administrator</em>**:

    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart 

    wsl --set-default-version 2

The first three commands enable the <em>Windows subsystem for Linux</em> and <em>Virtual Machine</em> feature of Windows while the last one just sets the WSL version to the newer WSL2 since this type of installation installs the old WSL by default.

<br/>

## <span style="color: #028A0F">**2. Installing Ubuntu from Microsoft Store**</span>

This step is as simple as just Opening the Microsoft Store, searching for your favorite Linux distro (supported by WSL) and pressing install. Once it downloads and installs not only you will be able to start using it but if you run the following command in your windows, it should list it and provide some details:

    wsl -l --verbose

For the sake of this tutorial i will be installing Ubuntu-20.04. When the system finishes installing its always a good idea to update/upgrade the system:

    sudo apt update

    sudo apt upgrade

<br/>

## <span style="color: #028A0F">**3. Installing Coding Tools**</span>

### <span style="color: #028A0F">**3.1. Installing Java and Maven**</span>

Installing Java is pretty straight forward. Just select the version you want (here i will install 11 but just change the number and you install another easily). I am also including sources so when coding in VsCode you can CTRL-Click the sources and it shows you the code. Totally unnecessary but I like to have the option, if you don't just remove the <em>source</em> block from the command.

    sudo apt-get install openjdk-11-jdk openjdk-11-source maven

Note that this will trigger a download of over 400Mb of data and it can take some time (up to 5/10 minutes depending on the machine) and <span style="color: red">DO NOT shutdown Ubuntu mid installation as it can do serious damage to once you retry.</span> You can always run the commands seperately and they will take significantly less each. This way ubuntu just starts one right next to the other.

At the end of the installation you should restart your Ubuntu and can check the installations by typing:

    java --version
    mvn --version

To this you should get something similar to:

    openjdk 11.0.11 2021-04-20
    OpenJDK Runtime Environment (build 11.0.11+9-Ubuntu-0ubuntu2.20.04)
    OpenJDK 64-Bit Server VM (build 11.0.11+9-Ubuntu-0ubuntu2.20.04, mixed mode, sharing)

    Apache Maven 3.6.3
    Maven home: /usr/share/maven
    Java version: 11.0.11, vendor: Ubuntu, runtime: /usr/lib/jvm/java-11-openjdk-amd64
    Default locale: en, platform encoding: UTF-8
    OS name: "linux", version: "5.10.16.3-microsoft-standard-wsl2", arch: "amd64", family: "unix"

<br/>

### <span style="color: #028A0F">**3.2) Installing NPM**</span>

You can check the Microsoft Tutorial from which I based mine [here](https://docs.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl).

Microsoft tells you in their tutorial that you should install curl, but by default Ubuntu should already have it therefore you can skip that step.

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

1. Run the curl command to install NVM. 
2. Restart your system.
3. Install the lastest NPM stable version by running <code>nvm install --lts</code>
4. You can now run <code>npm --version</code> and you will see that NPM is installed.

### <span style="color: #028A0F">**3.3. Installing MySQL**</span>

You can check the Microsoft Tutorial from which I based mine [here](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-mysql).

1. If you are doing this tutorial in order, you can skip the update microsoft tells you to do since you've done it before.
2. Install mysql server by typing <code>sudo apt install mysql-server</code>
3. After this, secure your installation. This is needed or you will have problems connecting to mysql, specially from localhost. So you need to start mysql by running <code>sudo /etc/init.d/mysql start</code> and then go through the securing process by running <code>sudo mysql_secure_installation</code>.

Finally if you're like me and have MySQL Workbench installed on windows, in order to connect to it you need to reconfigure MySQL Root Security.

Enter MySQL (simple sudo mysql should do it) and run the query:

    select user,authentication_string,plugin,host FROM mysql.user;

You should see something of the sort:

    +------------------+------------------------------------------------------------------------+-----------------------+-----------+
    | user             | authentication_string                                                  | plugin                | host      |
    +------------------+------------------------------------------------------------------------+-----------------------+-----------+
    | debian-sys-maint | $A$005$@U^YQhn>gU8NBJ9rLCcFnsp1YjA28S4dia2n4l2Xp.DONQaIh//Gy.    | caching_sha2_password | localhost |
    | mysql.infoschema | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
    | mysql.session    | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
    | mysql.sys        | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED | caching_sha2_password | localhost |
    | root             |                                                                        | auth_socket           | localhost |
    +------------------+------------------------------------------------------------------------+-----------------------+-----------+

Notice that the authentication string for the root is empty. This is due to the fact that Ubuntu installer uses socket authentication by default while MySQL Workbench uses the authentication string. To fix this just set a password for the root user by typing (replace 'new-password' with an actual safe password):

    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new-password';

After this you can connect to MySQL from Windows including connecting with the Workbench.

<br/>

### <span style="color: #028A0F">**3.4. Installing Gcc and Make**</span>

To install gcc and makefile is simple. However if you need to install anaconda in [3.5](#35-installing-python-and-anaconda) there is no need to install them manually since anaconda and python need them and will install them if they are not present in your system.

    sudo apt install gcc make

### <span style="color: #028A0F">**3.5. Installing Python and Anaconda**</span>
Open your command prompt and run the following command. This will prompt anaconda's download. Take in mind it is a 450Mb download that can take some time, and as mentioned in the previous section if you don't have gcc it will install it as well as other tools where python runs.

    wget https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh

Once the download is finished, let's install it and configure it. Run the file you just downloaded:
    
    bash Anaconda3-5.3.1-Linux-x86_64.sh

Once installed it will ask you whether you want to include it in .bashrc, say yes. Once it asks if you want VSCode say no because VSCode in WSL2 is installed through VSCode itself from Windows. Once you restart you can see that if you run <code>which python</code> or <code>which conda</code> it will point to anaconda's python or anaconda itself.

## <span style="color: #028A0F">**4. Solving some issues**</span>

### <span style="color: #028A0F">**4.1. File System Access Errors**</span>

If you copy files to your Ubuntu System or even sometimes create new files it can occur that Ubuntu doesn't give you permissions to write to its file system. If you're using VSCode this is the warning it shows:

    led to save 'Test.java': Unable to write file 'vscode-remote://wsl+ubuntu-20.04/home/{username}/workspace/Test.java.md' (NoPermissions (FileSystemError): Error: EACCES: permission denied, open '/home/{username}/workspace/Test.java')

Test.java being a file i copied to the workspace folder (this is my base folder for code projects - I recommend you create something like it for your work since your home directory will be used for installation of software and will become cluttered with installation folders). 

To fix this just run the command in the parent folder (ie if you want to give permissions to your <em>workspace</em> folder, go to the {username} folder) and run the command:

    sudo chown -R {username} ./workspace

### <span style="color: #028A0F">**4.2. Making VSCode work properly with Anaconda**</span>

Python and VSCode work well, but in order to use anaconda's python and dependencies you need to explicitly tell VSCode to use it. For that:
1. Press F1 and type <em>Select Python Interpreter</em>.
2. Select the one coming from Anaconda.
3. Now you can run python files or cells!