#!/bin/bash

# folder where nucypher-venv stored
NU_VENV_FOLDER=~/nucypher-venv
# folder where keys stored
NU_MAIN_FOLDER=~/.local/share/nucypher/
ETH_FOLDER=~/.ethereum
CURRENT_DATE=$(date +"%d-%m-%Y")
green="\e[92m"
red="\e[91m"
normal="\e[39m"

check_path() {
    if [ -d "$1" ]; then
        echo -e $green"Backup folder exists $1"

    else
        echo -e $red "ERROR: $1 does not exists --> exit"
        exit 1
    fi
}


echo "Сhecking backup directories..."
for folder in $NU_VENV_FOLDER $ETH_FOLDER $NU_MAIN_FOLDER; do
    check_path $folder
done


echo -e $normal"Getting current Nucypher version"
NU_VERSION=$(source $NU_VENV_FOLDER/bin/activate && nucypher --version | grep version | sed -r 's/^version //')
echo -e $green "Nucypher version: $NU_VERSION"

BACKUP_NAME=nucypher\_$NU_VERSION\_$HOSTNAME\_$CURRENT_DATE
mkdir $BACKUP_NAME && cd $BACKUP_NAME

echo -e $green"Copy ethereum keys"
mkdir -p .ethereum/goerli/keystore && cp $ETH_FOLDER/goerli/keystore/* .ethereum/goerli/keystore/
if [ -d "~/.ethereum/keystore/" ]; then
    cp -r $ETH_FOLDER/keystore/ .ethereum/keystore/
fi

#echo -e $green"Copy nucypher virtual env"
#cp -r $NU_VENV_FOLDER .

echo -e $green"Copy Ursula data"
mkdir -p .local/share/ && cp -r $NU_MAIN_FOLDER .local/share/

echo -e $green"Removing old backup files"
rm ~/*$HOSTNAME*.tar.gz

echo -e $normal"Creating tar.gz archive"
time tar -zcf ~/$BACKUP_NAME.tar.gz -C . nucypher-venv -C . .local -C . .ethereum

echo "Removing temp folder"
rm -rf ~/$BACKUP_NAME

echo -e $normal"$CURRENT_DATE Backup completed."
