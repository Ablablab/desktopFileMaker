#

# Call getopt to validate the provided input.
# The option string f:gh::i: means that the are four options. f has a required argument, g has no argument, h has an optional argument and i has a required argument

# TEMP=`getopt -o a::bc: --long arga::,argb,argc: -n 'desktopMaker' -- "$@"`
name_flag=0;
command_flag=0;
icon_flag=0;
path_flag=0;
comment_flag=0;
default_location="/.local/share/applications/";
location=$default_location;
manual=0;
usage="Usage: $0 \n\t-n, --name\t\t\t(Required)Name of Application  \n\t-c, --command\t\t\t(Required)Command of Application \n\t-c, --comment\t\t\t(Required)Comment of Application
\n\t-l, --location\t\t\tAlternative location (default is $HOME$location)\n\t-i, --icon\t\t\tLocal Icon \n\t-I, --webicon\t\t\tIcon from web (.png) \n\tNo Params  \t\t\tWizard";

if [ "$1" == "" ];
then
   manual=1;
   echo "Insert your application name (it will be displayed in menu)"
   read name;
   echo "Insert command to execute"
   read command;
   echo "Insert comment of application (it will be displayed in menu)"
   read comment;
   echo -e "Icon Selection:\n\t c \tto use custom path of your icon\n\t w\tto use a icon from web (.png)\n \tempty\tuse no icons "
   read customOrWeb;
   if [ "$customOrWeb" == "c" ]; then
     echo "Insert icon path"
     read icon;
   elif [ "$customOrWeb" == "w" ]; then
     echo "Paste your icon url (png)"
     read urlIcon;
     icon=$HOME/.icons/"$name".png
     wget "$urlIcon" -O "$icon"
     errorWget=$?
     if [ "$errorWget" != 0 ]; then
       exit 1;
     fi
   elif [ "$customOrWeb" == "" ]; then
     icon="";
   else
     echo ":-("
     exit 1;
   fi

else

  while getopts 'getopt -o n:c:i:I:C:l:h --long name:,command:,icon:webicon:,comment:location:,help -n 'desktopMaker' -- "$@"' opt; do
    case $opt in
      h|-help)
        echo -e $usage;
        exit 0     ;;
      n|-name)
        echo "Name of Application: $OPTARG" >&2
        name_flag=1;
        name=$OPTARG
        ;;
      c|-command)
        echo "Command of Application: $OPTARG" >&2
        command=$OPTARG
        command_flag=1;
        ;;
      i|-icon)
        echo "Icon of Application: $OPTARG" >&2
        icon=$OPTARG
        icon_flag=1;
        ;;
      I|-webicon)
        echo "Icon of Application from web: $OPTARG" >&2
        urlIcon=$OPTARG
        icon=$HOME/.icons/"$name".png
        wget "$urlIcon" -O "$icon"
        errorWget=$?
        if [ "$errorWget" != 0 ]; then
          exit 1;
        fi
        icon_flag=1;
        ;;
      C|-comment)
        echo "Comment: $OPTARG" >&2
        comment=$OPTARG
        comment_flag=1;
        ;;
      l|-location)
        echo "Location: $OPTARG" >&2
        location=$OPTARG
        comment_flag=1;
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
    esac
  done
fi
if [ $(($name_flag * $comment_flag * $comment_flag)) == 1 ] || [ "$manual" == 1 ];
then
  echo;
  echo;
  echo "Create this dektop file in" $location;
  echo "type y or n";
  read resp;
  if [ "$resp" == "y" ] || [ "$resp" == "yes" ]
  then
    desktopFile="[Desktop Entry]
    Type=Application
    Encoding=UTF-8
    Name=$name
    Comment=$comment
    Exec=$command
    Icon=$icon
    Terminal=false";

    echo "$desktopFile" > $HOME"$location""$name".desktop;
    echo "DONE, bye"
    echo ;
    exit 0;
  else
    echo ":-(";
    exit 0;
  fi
fi


exit 0;
