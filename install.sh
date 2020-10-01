#!/bin/bash
#Creation du daemon et des dossiers

#Pour ne pas creer dans home/root
USERNAME=$( logname )

CHEMIN_FICHIERS=${PWD} #ou .

#chemin où l'on va copier les fichiers python
CHEMIN_PY=/home/$USERNAME/cryptoProject

TO_CRYPT="/home/$USERNAME/crypto/toCrypt"
CRYPTED="/home/$USERNAME/crypto/crypted"
TO_DECRYPT="/home/$USERNAME/crypto/toDecrypt"
DECRYPTED="/home/$USERNAME/crypto/Decrypted"
KEYS="/home/$USERNAME/crypto/keys"


NOM_SERVICE="cryptDecrypt_edith.service"
DESCRIPTION="Cryptage et decryptage automatique"

#INSTALLATION
sudo mkdir -p ${TO_CRYPT}
sudo mkdir -p ${CRYPTED}
sudo mkdir -p ${TO_DECRYPT}
sudo mkdir -p ${DECRYPTED}
sudo mkdir -p ${KEYS}
sudo chown -R $USERNAME ${CHEMIN_PY}



sudo printf "%s\n" "[Unit]" "Description=${DESCRIPTION}" "[Service]" "User=${USERNAME}" "ExecStart=${CHEMIN_FICHIERS}/encdec_Service.sh" "Restart=on-failure" "[Install]" "WantedBy=multi-user.target" > /etc/systemd/system/${NOM_SERVICE}

sudo cp ./encrypt.py ${CHEMIN_PY}
sudo cp ./decrypt.py ${CHEMIN_PY}

#LANCEMENT DU SERVICE
sudo systemctl start ${NOM_SERVICE}
