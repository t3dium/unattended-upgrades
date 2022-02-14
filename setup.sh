# The actual script is 1 line, the setup script isnt

#TODO skip errors preventing upgrade from continue, if the user is online ask before running, other package managers
###########################################################################################################
purple=`tput setaf 5`
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
###########################################################################################################
add_to_cron(){
      #concatinating all the cron values
      thing="${occurence} ${cron_value_distro} ${cron_value_flatpak} ${cron_value_snap} ${cron_value_pip} "
      touch thing
      echo $thing >> thing
      sudo crontab thing
      rm thing
      echo "Finished, system upgrades have been scheduled without the need for 3k python lines of code."
    fi
}
###########################################################################################################
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
###########################################################################################################


###########################################################################################################
#cron_value_name-here values will all be concatinated later, in the add to cron function
echo "$red Do not enter [] for the options, just the word inside, also only enable unattended upgrades for package managers you have installed."
###########################################################################################################
echo "$green how frequently would you like system upgrades to occur? $purple [Options] = [daily] [weekly]"
read occurence
if [ $occurence == "daily" ]; then
  cron_value_occurence="@daily "
else
  cron_value_occurence="@weekly "
fi
###########################################################################################################
echo "$green [Enter] [1] if you're running a debian/ubuntu based distro, or [2] if running arch"
read distro
if [ $distro == "1" ]; then
  cron_value_distro="apt update; apt full-upgrade -y; "
else
  cron_value_distro="pacman -Syyu --noconfirm; "
fi
###########################################################################################################
echo "$green Do you want to enable unattended upgrades for flatpaks? [Options] = [y] [n]"
read flatpak
if [ $flatpak == "y" ]; then
  cron_value_flatpak="flatpak update -y --noninteractive; "
else
  #making an empty variable to avoid errors during concatination
  cron_value_flatpak=""
fi
###########################################################################################################
echo "$green Do you want to enable unattended upgrades for snaps? [Options] = [y] [n]"
read snap
echo "$red auto-updating snaps may not work as of now, as i cant find the flag to run the command without requiring confirmation"
if [ $snap == "y" ]; then
  cron_value_snap="snap refresh; "
else
  cron_value_snap=""
fi
###########################################################################################################
echo "$green Do you want to enable unattended upgrades for python pip packages? [Options] = [y] [n]"
read pip
if [ $pip == "y" ]; then
  #using the common pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U seems to break pip somehow so i'm using the pip-review package instead as it works flawlessly
  pip install pip-review
  cron_value_pip="pip-review --auto; "
else
  cron_value_pip=""
fi
#script needs to run as sudo
check_root
