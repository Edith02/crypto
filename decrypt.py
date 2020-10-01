#!/usr/bin/env python3
import sys
import os
from Crypto.PublicKey import RSA

fichier_in = False
fichier_out = False
cle_prive = False
cle_public = False

homedir = os.path.expanduser("~")
chemin_gen = homedir + "/cryptoProject/keys/"
private_rsa_file = "private.pem"
public_rsa_file = "public.pem"


if (len(sys.argv) > 1):
        fichier_in = True
if (len(sys.argv) > 2):
        fichier_out = True
if (len(sys.argv) > 3):
        cle_prive = True
if (len(sys.argv) > 4):
        cle_public = True


def get_keys(private,public):

        #Retourne les clés
        with open(private,'r') as fk:
                private = RSA.importKey(fk.read())
                fk.close()

        with open(public, 'r') as fp:
                public = RSA.importKey(fp.read())
                fp.close()

        return (private,public)


#Importation des clés
if(cle_prive and cle_public):

        #importer clé existant
        try:
                key = get_keys(sys.argv[3],sys.argv[4])
        except:
                key = get_keys(chemin_gen+sys.argv[3],chemin_gen+sys.argv[4])
else:
	key = get_keys(chemin_gen+private_rsa_file,chemin_gen+private_rsa_file)

if(fichier_in):
        fichier = sys.argv[1]
else:
        fichier = input("Le fichier à crypter: ")


#Ouverture du fichier encrypté
with open(fichier, "rb") as fr:
	d_encrypt = fr.read()
	fr.close()
x = key[0].decrypt(d_encrypt)


#Sauvegarde du fichier decrypté
output = fichier + '.decrypt'
if (fichier_out):
        output = sys.argv[2]

with open(output,"wb") as fd:
	fd.write(x)
	fd.close() 
