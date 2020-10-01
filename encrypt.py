#!/usr/bin/env python3

import sys
import os
from Crypto.PublicKey import RSA

fichier_in = False
fichier_out = False
cle_prive = False
cle_public = False

#chemin_gen = "./keys/"
homedir = os.path.expanduser("~")
chemin_gen = homedir + "/crypto/keys/"

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

	#Prend les clés
	with open(private,'r') as fk:
        	private = RSA.importKey(fk.read())
        	fk.close()
	with open(public, 'r') as fp:
        	public = RSA.importKey(fp.read())
        	fp.close()
	return (private,public)

def gen_rsaFiles(private,public):

	#Génerer la clé
	key = RSA.generate(1024)

	#Exporter la clé dans d'autres variables
	k = key.exportKey("PEM")

	p = key.publickey().exportKey('PEM')

	#Ecrire les clés dans des fichiers pem
	try:
		with open(private,'w') as kf:
			kf.write(k.decode())
			kf.close()

		with open(public,'w') as pf:
			pf.write(p.decode())
			pf.close()
	except:
		#Si le dossier n'existe pas
		os.system("mkdir -p " + chemin_gen)
		gen_rsaFiles(private,public)

	return key

#Determination de clé
if(cle_prive and cle_public):

	#importer clé existant
	try:
		key = get_keys(sys.argv[3],sys.argv[4])[0]
	except:
		key = get_keys(chemin_gen+sys.argv[3],chemin_gen+sys.argv[4])[0]
else:
	#generer nouveau clé
	key = gen_rsaFiles(chemin_gen+private_rsa_file,chemin_gen+public_rsa_file)

#Ouverture du fichier
if(fichier_in):
	fichier = sys.argv[1]
else:
	fichier = input("Le fichier à crypter: ")

fo = open(fichier,"rb")
text = fo.read()

#Encryption
d_encrypt = key.publickey().encrypt(text,None)

#Ecriture du fichier encrypté
output = fichier + '.crypt'
if (fichier_out):
	output = sys.argv[2]

fo = open(output, 'wb')
fo.write(d_encrypt[0])

fo.close()
