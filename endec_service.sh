#!/bin/bash

USERNAME=$( whoami )
if [[ "$USERNAME" = "root" ]]
then
	#Prendre l'utilisateur de sudo
	USERNAME=$( logname )
	if [ -z $USERNAME ]
	then
		#L'utilisateur a réellement demarré en session root
		USERNAME="root"
	fi
fi

#variables modifiables par l'utilisateur
SUFFIX_CR=".crypt"
SUFFIX_DCR=".decrypt"
CHEMIN_FICHIERS="/home/$USERNAME/cryptoProject"
CHEMIN_CLE="${CHEMIN_FICHIERS}/keys"
CLE_PRIVE="private.pem"
CLE_PUB="public.pem"
TO_CRYPT="/home/$USERNAME/cryptoProject/toCrypt"
CRYPTED="/home/$USERNAME/cryptoProject/crypted"
TO_DECRYPT="/home/$USERNAME/cryptoProject/toDecrypt"
DECRYPTED="/home/$USERNAME/cryptoProject/Decrypted"

while true
do

	#verification si  les clés sont déjà générées
	cle=0
	if [ -f ${CHEMIN_CLE}/${CLE_PRIVE} ] && [ -f ${CHEMIN_CLE}/${CLE_PUB} ]
	then
		cle=1
	fi

	#CRYPTAGE
	while IFS=$'\n' read fichier
	do
		if [ -z $fichier ]
                then
                	break
                fi

		deja_enc=0
		while IFS=$'\n' read encryptd_file
		do

			#verifie si le fichier est déjà encrypté
			if ! [ -z $encryptd_file ]
			then
				if [[ "$fichier" = "${encryptd_file:0:-${#SUFFIX_CR}}" ]]
				then
					deja_enc=1
				fi
			fi

		done <<<$(ls ${CRYPTED}/)

		if [ $deja_enc -eq 0 ]
		then
			echo Cryptage
			#Execution de encrypt.py
			if [ $cle -eq 0 ]
			then
				echo et génération de la clé
				${CHEMIN_FICHIERS}/encrypt.py ${TO_CRYPT}/$fichier ${CRYPTED}/${fichier}${SUFFIX_CR}
			else
				${CHEMIN_FICHIERS}/encrypt.py ${TO_CRYPT}/$fichier ${CRYPTED}/${fichier}${SUFFIX_CR} ${CHEMIN_CLE}/${CLE_PRIVE} ${CHEMIN_CLE}/${CLE_PUB}
			fi
		fi

	done <<<$(ls ${TO_CRYPT}/) 


	if [ $cle -ne 0 ]
	then
		#DECRYPTAGE
		while IFS=$'\n' read fichier
        	do
			if [ -z $fichier ]
			then
				break
			fi

                	deja_dec=0
                	while IFS=$'\n' read cryptd_file
                	do

                        	#verifie si le fichier est déjà encrypté
                        	if ! [ -z $cryptd_file ]
                        	then
                                	if [[ "$fichier" = "${cryptd_file:0:-${#SUFFIX_DCR}}" ]]
                                	then
                                        	deja_dec=1
                                	fi
                       		fi

                	done <<<$(ls ${DECRYPTED}/)

                	if [ $deja_dec -eq 0 ]
                	then
                        	echo Decryptage
                        	#Execution de decrypt.py
                                ${CHEMIN_FICHIERS}/decrypt.py ${TO_DECRYPT}/$fichier ${DECRYPTED}/${fichier}${SUFFIX_DCR} ${CHEMIN_CLE}/${CLE_PRIVE} ${CHEMIN_CLE}/${CLE_PUB}

                	fi

        	done <<<$(ls ${TO_DECRYPT}/)

	fi

	sleep 1
done#!/bin/bash



USERNAME=$( whoami )
if [[ "$USERNAME" = "root" ]]
then
	#Prendre l'utilisateur de sudo
	USERNAME=$( logname )
	if [ -z $USERNAME ]
	then
		#L'utilisateur a réellement demarré en session root
		USERNAME="root"
	fi
fi

#variables modifiables par l'utilisateur
SUFFIX_CR=".crypt"
SUFFIX_DCR=".decrypt"
CHEMIN_FICHIERS="/home/$USERNAME/cryptoProject"
CHEMIN_CLE="${CHEMIN_FICHIERS}/keys"
CLE_PRIVE="private.pem"
CLE_PUB="public.pem" 
TO_CRYPT="/home/$USERNAME/crypto/toCrypt"
CRYPTED="/home/$USERNAME/crypto/crypted"
TO_DECRYPT="/home/$USERNAME/crypto/toDecrypt"
DECRYPTED="/home/$USERNAME/crypto/Decrypted"



while true
do


	#verification si  les clés sont déjà générées
	cle=0
	if [ -f ${CHEMIN_CLE}/${CLE_PRIVE} ] && [ -f ${CHEMIN_CLE}/${CLE_PUB} ]
	then
		cle=1
	fi

	#CRYPTAGE
	while IFS=$'\n' read fichier
	do
		if [ -z $fichier ]
                then
                	break
                fi

		deja_enc=0
		while IFS=$'\n' read encryptd_file
		do

			#verifie si le fichier est déjà encrypté
			if ! [ -z $encryptd_file ]
			then
				if [[ "$fichier" = "${encryptd_file:0:-${#SUFFIX_CR}}" ]]
				then
					deja_enc=1
				fi
			fi

		done <<<$(ls ${CRYPTED}/)

		if [ $deja_enc -eq 0 ]
		then
			echo Cryptage
			#Execution de encrypt.py
			if [ $cle -eq 0 ]
			then
				echo et génération de la clé
				${CHEMIN_FICHIERS}/encrypt.py ${TO_CRYPT}/$fichier ${CRYPTED}/${fichier}${SUFFIX_CR}
			else
				${CHEMIN_FICHIERS}/encrypt.py ${TO_CRYPT}/$fichier ${CRYPTED}/${fichier}${SUFFIX_CR} ${CHEMIN_CLE}/${CLE_PRIVE} ${CHEMIN_CLE}/${CLE_PUB}
			fi
		fi

	done <<<$(ls ${TO_CRYPT}/) 


	if [ $cle -ne 0 ]
	then
		#DECRYPTAGE
		while IFS=$'\n' read fichier
        	do
			if [ -z $fichier ]
			then
				break
			fi

                	deja_dec=0
                	while IFS=$'\n' read cryptd_file
                	do

                        	#verifie si le fichier est déjà encrypté
                        	if ! [ -z $cryptd_file ]
                        	then
                                	if [[ "$fichier" = "${cryptd_file:0:-${#SUFFIX_DCR}}" ]]
                                	then
                                        	deja_dec=1
                                	fi
                       		fi

                	done <<<$(ls ${DECRYPTED}/)

                	if [ $deja_dec -eq 0 ]
                	then
                        	echo Decryptage
                        	#Execution de decrypt.py
                                ${CHEMIN_FICHIERS}/decrypt.py ${TO_DECRYPT}/$fichier ${DECRYPTED}/${fichier}${SUFFIX_DCR} ${CHEMIN_CLE}/${CLE_PRIVE} ${CHEMIN_CLE}/${CLE_PUB}

                	fi

        	done <<<$(ls ${TO_DECRYPT}/)

	fi

	sleep 1
done
