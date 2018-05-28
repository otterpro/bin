#!/usr/bin/env bash
# generate SSH KEY
if [[ -f $HOME/.ssh/id_rsa ]]; then 
	echo "ssh key already exists.  EXITING."
	exit 0
else 
	echo "generating SSH"
	/usr/bin/env ssh-keygen -t rsa -C "codequickly@gmail.com" -P "" -f $HOME/.ssh/id_rsa
	echo "SSH public key:"
	echo $HOME/.ssh/id_rsa.pub

fi
