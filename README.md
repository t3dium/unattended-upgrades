# Unattended-upgrades 
Because 3000 lines of python in order to update your system, has to be the dumbest thing i've ever heard

# Why
Unattended upgrades is extremely bloated for what it's meant to do, it's written in python and spawns several processes.. for an upgrade. Since doing an upgrade took several hours on a weak machine I decided to make a **1** line bash script, to automatically upgrade debian based linux systems periodically. 

_(Bare in mind the setup script isn't one line, the script it adds to cron is one line)_

# How to Run
1) `git clone https://github.com/t3dium/unattended-upgrades.git`
2) `cd unattended-upgrades`
3) `sudo bash setup.sh`

# Todo

- [ ] Check if user is online, if so ask before upgrading.
- [ ] Ignore failed packages during upgrade, in order to prevent the upgrade stopping.
- [ ] Adding support for snaps, flatpaks, pip, and other package managers.
