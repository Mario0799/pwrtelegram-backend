# PWRtelegram backend

This repository contains all of the configuration files for the backend of the pwrtelegram API, along with an installation script.

To install the PWRTelegram API run the following command:

```
wget -O install.sh https://raw.githubusercontent.com/pwrtelegram/pwrtelegram-backend/master/install.sh && chmod +x install.sh && sudo bash -e install.sh
```

This script is created to run on Ubuntu 14.04.

PWRTelegram and its dependencies require at least 1.5 GB of RAM (a swap file or partition is highly recommended) and 1 gb of hard drive space.

The php part of PWRTelegram is updated minutely, but tg-cli and all of the other submodules can by updated by running the update.sh script located in he pwrtelegram directory.
