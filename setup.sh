#!/bin/bash
#The actual script is 1 line, the setup script isnt

###########################################################################################################
purple=`tput setaf 5`
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
###########################################################################################################

if [ "$USER" != "root" ]; then
      echo "${red} Permission Denied"
      echo "${red} Can only be run as root, make sure to run the script with sudo at the start of your command. For e.g, sudo bash linux.sh"
      exit
else
      echo "${green} Welcome"
fi

#complete rewrite of script in TUI, (whiptail is already installed on most systems)
echo "$red opening whiptail tui.. if you get an error you might need to install whiptail"
###########################################################################################################
check_root(){
  if [ "$USER" != "root" ]; then
        echo "${red} Permission Denied"
        echo "${red} Can only be run as root, make sure to run the script with sudo at the start of your command. For e.g, sudo bash linux.sh"
        exit
  else
        echo "${green} continuing..."
  fi
  add_to_cron
}
###########################################################################################################
if (whiptail --title "check distro" --yesno "Select [yes] if you're using debian/ubuntu, [no] if you're using arch" 8 78); then
  distro="debian"
  cron_value_distro="apt update; apt full-upgrade -y; "
else
  distro="arch"
  cron_value_distro="pacman -Syyu --noconfirm; "

fi
##########################################################################################################
if (whiptail --title "frequence" --yesno "how frequently would you like system upgrades to occur? [yes] = daily, [no] = weekly" 8 78); then
  cron_value_occurence="daily "
else
  cron_value_occurence="weekly "
fi
##########################################################################################################
if (whiptail --title "flatpak updates" --yesno "Do you want to enable unattended upgrades for flatpaks?" 8 78); then
  cron_value_flatpak="flatpak update -y --noninteractive; "
else
  #making an empty variable to avoid errors during concatination
  cron_value_flatpak=""
fi
##########################################################################################################
if (whiptail --title "snap updates" --yesno "Do you want to enable unattended upgrades for snaps? - Note: auto-updating snaps may not work as of now, as i cant find the flag to run the command without requiring confirmation" 8 78); then
  cron_value_snap="snap refresh; "
else
  ron_value_snap=""
fi
##########################################################################################################
if (whiptail --title "pip updates" --yesno "Do you want to enable unattended upgrades for python pip packages?" 8 78); then
  pip install pip-review
  cron_value_pip="pip-review --auto; "
else
  cron_value_pip=""
fi
##########################################################################################################
if [ $distro == "arch" ]; then
  if (whiptail --title "ruby updates" --yesno "Do you want to enable unattended upgrades for ruby gem packages? - Updating ruby gems this way is currently experimental." 8 78); then
    cron_value_ruby="gem update; "
  else
    cron_value_ruby=""
    echo "$red Updating ruby packages this way is disabled on debian/ubuntu systems, in order to not risk overwriting debian's ruby package and causing breakage, You should update via apt instead."
  fi
fi

##########################################################################################################
touch stuff.txt
if (whiptail --title "system cleanup" --yesno "Schedule monthly removal of unnused dependencies or files not needed anymore (old files etc)?" 8 78); then
  if [ $distro == "debian" ]; then
    echo "@monthly apt auto-remove -y" >> stuff.txt
  else
    #arch
    #below command pipes excplicit orphans (not optional ones) into pacman's full remove command.
    echo "@monthly pacman -Qtdq | pacman -Rns --noconfirm" >> stuff.txt
  fi
fi
##########################################################################################################
if (whiptail --title "docker cleanup" --yesno "Schedule monthly docker cleanup? Old images, unused volumes etc" 8 78); then
  #debian/ubuntu
  echo "@monthly docker system prune -f" >> stuff.txt
fi
##########################################################################################################
#passing a file to cron (as opposed to simply echo-ing to crontab -e) generates a cron file if none exists.
#concatinating all the cron values
thing="@${cron_value_occurence} ${cron_value_distro}${cron_value_flatpak}${cron_value_snap}${cron_value_pip}${cron_value_ruby}"
echo $thing >> stuff.txt
sudo crontab stuff.txt
rm stuff.txt
##########################################################################################################
