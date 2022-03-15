# Setting up Wsl2 Ubuntu

This tutorial will show you how to setup WSL2 in windows as well as how to install some tools like database management systems, programming languages, dependency management and building tools among other development tools. Running these scripts give you a choice of what to install as well as give some indications on how to configure those who need configuring.

## <span style="color: #028A0F">**1. Installer Script**</span>

The installer script lets you choose what to install. You need to select by clicking the options. The system works fine with VSCode terminal but can get buggy sometimes if on a Ubuntu native WSL terminal. If you encounter issues like not being able to select, try to resize the window (generally the fullscreen terminal doesn't work, but once you resize it, it works).

## <span style="color: #028A0F">**2. Configurer Script**</span>

The configurer script helps you go through the configuring process of some systems (mainly database management systems). 

In the case of MySQL you probably will need to setup a new root password. This will allow connecting to Spring Boot servers and MySQL Workbench or VSCode database extension with a connection string or username/password combo. By default the root password doesn't exist therefore this connecting method won't work. Running the next command replacing 'new-password' with the password you wish should fix it:

    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new-password';

If you wish to check if it worked, run:

    select user,authentication_string,plugin,host FROM mysql.user;

You should see a table where in the root line, the authentication_string column should have an hash and not be empty like it would be by default.

## <span style="color: #028A0F">**3. Other Scripts**</span>

There are three other script files:
<ul>
<li><code>common.sh</code> - this provides a set of functions use through the other scripts and was coded just for the sake of avoiding repetition.</li>
<li><code>initializer.sh</code> - initializes all database systems as a service that are present.</li>
<li><code>stopper.sh</code> - stops all database systems as a service that are present.</li>
</ul>