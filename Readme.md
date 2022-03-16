# Setting up Wsl2 Ubuntu

This tutorial will show you how to setup WSL2 in windows as well as how to install some tools like database management systems, programming languages, dependency management and building tools among other development tools. Running these scripts give you a choice of what to install as well as give some indications on how to configure those who need configuring.

## <span style="color: #028A0F">**1. Warning**</span>

If there is any problem with file manipulation, and Ubuntu says you can't save files, then you need to grant permissions to your user. Do that by going to the home directory (the parent dir of your user) and running:

    sudo chown -R {user} ./{user}

Because of conflicts between windows and linux character encoding, you might have an error like:

    ./initializer.sh: line 6: $'\r': command not found

If this appears, run the following command for **all** scripts:

    sed -i 's/\r$//' <script file>

## <span style="color: #028A0F">**2. Installer Script**</span>

The installer script lets you choose what to install. You need to select by clicking the options. The system works fine with VSCode terminal but can get buggy sometimes if on a Ubuntu native WSL terminal. If you encounter issues like not being able to select, try to resize the window (generally the fullscreen terminal doesn't work, but once you resize it, it works).

## <span style="color: #028A0F">**3. Configurer Script**</span>

The configurer script helps you go through the configuring process of some systems (mainly database management systems). 

In the case of MySQL you probably will need to setup a new root password. This will allow connecting to Spring Boot servers and MySQL Workbench or VSCode database extension with a connection string or username/password combo. By default the root password doesn't exist therefore this connecting method won't work. Running the next command replacing 'new-password' with the password you wish should fix it:

    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new-password';

If you wish to check if it worked, run:

    select user,authentication_string,plugin,host FROM mysql.user;

You should see a table where in the root line, the authentication_string column should have an hash and not be empty like it would be by default.

## <span style="color: #028A0F">**4. Other Scripts**</span>

There are three other script files:
<ul>
<li><code>common.sh</code> - this provides a set of functions use through the other scripts and was coded just for the sake of avoiding repetition.</li>
<li><code>initializer.sh</code> - initializes all database systems as a service that are present.</li>
<li><code>stopper.sh</code> - stops all database systems as a service that are present.</li>
</ul>

## <span style="color: #028A0F">**5. Configure to run as commands**</span>

In order to make the scripts commands you need to follow the steps:

First, move the files (the ones you want to make commands - always including common as is imported in all others) to a folder you will never delete. Then you need to give the scripts executable permission (note that even if you don't want to turn all into commands, the common.sh is always needed - meaning it needs to be executable and moved to the folder if any of the others are to work) run the command:

    chmod u+x <script>

If permission issues appear, remeber to change permission by using sudo chown as shown [here](#span-style"color-028a0f"0-warningspan).

Finally go to the <code>.bashrc</code> file (located in your user folder eg: /home/testpc/.bashrc) and add one line for each script (except common as it doesn't run as a standalone script).

    alias <alias name>='/home/path/to/your/folder/<script>'

Something like:

    alias start='/home/pc/aliases/initializer.sh'

Reboot your Ubuntu and when you type your new commands they should work.
