# The actual script is 1 line, the setup script isnt

#TODO skip errors preventing upgrade from continue, if the user is online ask before running

purple=`tput setaf 5`
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

add_to_cron(){
    if [ $how_often == "daily" ]; then
      thing="@daily apt update; apt full-upgrade -y"
    else
      thing="@weekly apt update; apt full-upgrade -y"
      touch thing
      echo $thing >> thing
      sudo crontab thing
      rm thing
      echo "Finished, system upgrades have been scheduled without the need for 3k python lines of code."
    fi
}

check_root(){
  if [ "$USER" != "root" ]; then
        echo "${red} Permission Denied"
        echo "${red} Can only be run as root, make sure to run the script with sudo at the start of your command. For e.g, sudo bash linux.sh"
        exit
  else
        echo "${green} Welcome"
  fi
  add_to_cron
}

echo "$green how frequently would you like system upgrades to occur? $purple [Options] = [daily] [weekly], dont use the []"
read how_often
#script needs to run as sudo
check_root
