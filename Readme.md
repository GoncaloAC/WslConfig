# **Setting up Wsl2 Ubuntu**

<div style="text-align: justify; text-justify: inter-word;">

This tutorial will show you how to setup WSL2 in windows as well as how to install some tools like database management systems, programming languages, dependency management and building tools among other development tools. Running these scripts give you a choice of what to install as well as give some indications on how to configure those who need configuring.

## **1. Initial Ubuntu setup**

I strongly advise that the first thing you do after installing your wsl distro is running a chown command over your root. You can do this by changing directory until you are in the `home` directory (if you just booted your distro, run `cd ..`) and you should see the prompt end in `/home$`, and then run:

    sudo chown -R {user} ./{user}

**NOTE**: Some of the software like npm/nvm and maven need you to **reboot the WSL distro** like you will need to when installing the script. You can run the command on windows prompt `wsl -t <distro name>`. Make sure you have everything related to WSL (like the shell, VSCode and through windows explorer).

## **2. Installing the script**

Now you need to install the script. For this, follow the steps below:

1) Copy the script file to a directory you won't delete. (I recommend to put it into the /home/{username} directory as that will never be deleted because it is the root of your system).

2) You will need to run a command to turn the file into an executable. This means the script will run without the need to type `bash` into the console.

        chmod u+x script.sh

3) After this, there can be issues with encoding. I am not sure why since it was coded on a Ubuntu WSL machine but GitHub changes the format to a point where Ubuntu's console will not be able to run it and throws an error. 

        sed -i 's/\r$//' script.sh

4) Then you need to create an alias so that Ubuntu. To do that, open your `.bashrc` file (located in your user folder eg: /home/{username}/.bashrc) and add the code:

        alias system='/home/{username}/script.sh'
        
    Note that if you did not put the script file in the '/home/{username}' folder, you need to update the line above before saving the file. You can also change the alias. With the above alias you will be able to access the script by typing `system <command name>`. If you change the alias you will need to type `<alias> <function>`.
    
5) Finally you need to reboot your wsl distro. This is not as simple as closing VSCode or the Windows App itself. You will need to open a Windows prompt (either through Windows Terminal, Windows Command Line or Windows PowerShell) run the command below to stop your distro from running (basically a shut down).

        wsl -t <distro name>

    If you do not know the name of your distro (meaning the name of the installation of a distro), you can check by running:

        wsl -l -v

## **3. Script commands**

For the sake of consistency, all examples below follow the previous section, which means all commands will be shown here as `system <command name>`

1) **Installing Software** - This script will give you a prompt with a UI that allows you to choose the software you need. After you choose, it will proceed to install it. **_Note_**: Since it is using WSL, dialog (the package used for the selection process) can bug specially if the window is in full screen. If this happened, resize the window and it should work then.
    
        system install

   **_WARNING_:** some of the software, namely maven, nvm/npm need you to restart the system, just like described above using a Windows prompt and running `wsl -t <distro name>`.
    
2) **Configuring Software** - As the script warns you during installation, some of the software needs to be configured to function properly. 
    
        system config

    This command will prompt a Dialog UI like the previous, which has:
   
    1) **NVM** - The installation only installed Node Version Manager, to install the latest NPM run. This configuration process will install the latest stable version of NPM.

    2) **MySQL** - If you installed MySQL you need to run the configuration process. Here it will run a command `sudo mysql_secure_installation` that will ask for user input in order to configure the system. <span style="font-weight:bold">I recommend</span>:

        - First MySQL asks if you need VALIDATE PASSWORD. That is a system that evaluates the strength of passwords. If your installation is for personal/professional use but is not accessible to the outside, you can say no as the password is a mere formality. If you are installing it to run a permanent system that will connect to deployed front-end then you probably should. In my WSL installation I said **no**.
        - Following that it will ask you for a password. Fill with whatever you want.
        - When it asks you `Remove Anonymous Users` say **yes**, otherwise there won't even be the need to provide username/password authentication.
        - When you see `Disallow login remotely` say **no** because your in WSL, if you want to access the db in the same machine but in windows that's a remote login.
        - Then it asks you whether or not you want to remove the test database. That is pretty much indifferent, keep it or not it's pretty much useless anyway.
        - Finally it asks you if you want to `reload privilege tables` to that, say **yes** as it will be necessary for the next step.

        After this you should see yourself in the MySQL shell. Here you need to make a small change that will set a password to your root. If you run the command:

            select user,authentication_string,plugin,host FROM mysql.user;

        You should now see that the root's `authentication_string` is empty. That is required if you want to connect to the db via localhost. To fix this, run the command below, replacing new-password with the password of your choice (remember not to delete the '').

            ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
        
        Finally you can now exit the MySQL shell forever by running 

            quit

        **_WARNING:_** some of the software, namely maven, nvm/npm need you to restart the system, just like described above using a Windows prompt and running `wsl -t <distro name>`.

    3) **Postgres** will just ask you to set a password, after you set one it's pretty much done.

3) **Initializing Databases** - This will initialize the server for all databases you have installed. It will give you an output string for each database supported in the `system install` command. It will say that the server started successfully or that is not installed (this script won't install any of the databases that are not installed, the output is merely informative). To run this, type:

        system start

4) <span style="font-weight:bold">Stopping Databases</span> - Equal to the previous command in every way but instead of starting the databases server it stops it (after this, any connection you had with the dbs will crash).

        system stop

5) <span style="font-weight:bold">Help</span> - This will print the right syntax to use within the script.

        system help


</div>
