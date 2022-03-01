# Unattended-upgrades 
Because 3000 lines of python in order to update your system, has to be the dumbest thing i've ever heard

# Why
Unattended upgrades is extremely bloated for what it's meant to do, it's written in python and spawns several processes.. for an upgrade. Since doing an upgrade took several hours on a weak machine I decided to make a **1** line bash script, to automatically upgrade linux systems periodically. **And not just apt, but all package types**.

_(Bare in mind the setup script isn't one line, the script it adds to cron is one line)_

# How to Run
1) `git clone https://github.com/t3dium/unattended-upgrades.git`
2) `cd unattended-upgrades`
3) `sudo bash setup.sh`

# Todo

- [x] TUI, text based terminal GUI
- [x] Adding support for snaps, flatpaks, pip, and other package managers. (Optional)
- [x] Schedule system cleanups and docker prunes (Optional)

Currently Supported Package Managers  |
-------------------|
Pacman (Arch)      |
Apt (debian/ubuntu)|
Pip                |
Flatpak            |
Snap               |
Docker (coming soon)
More coming soon|
