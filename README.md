# Desktop File Maker!

# Usage (through Bash)
1. Clone this repo:
> git clone https://github.com/Ablablab/desktopFileMaker.git
2. Go into folder
> cd desktopFileMaker
3. Set correctly permissions with:
> make install

4. Use it!
> ./desktopMaker.sh


# Experimental
To generate a desktop entry for this program.
> ./desktopMaker.sh --install

# Parameters
> -n,--name
* (Required) Name of the Application entry (not the command)

> -c,--command
* (Required) Command of the Application entry

> -C,--comment
* (Required) Comment of the Application entry (not the command)

> -i,--icon
* Path of local icon to use

> -I,--webicon
* Url of PNG to download to use as icon

> -t,--terminal
* Execute application in terminal

> -z,--install
* Generate a desktop entry for this application

> -u,--uninstall
* Delete desktop Entry for this application
