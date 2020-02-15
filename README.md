## Description
The script creates an archive with the folders necessary for transferring to another server.  

What is archived:  
```
~/.ethereum/keystore/*
~/.ethereum/goerli/keystore/*
~/nucypher-venv/*
~/.local/share/nucypher/*
```

### Note
If you did not follow the paths specified in the [official](https://docs.nucypher.com/en/latest/guides/installation_guide.html) installation guide, then you can fork this repository and edit the paths

## How to use
`curl -s https://raw.githubusercontent.com/c29r3/nucypher-backup-script/master/backup.sh | bash`
