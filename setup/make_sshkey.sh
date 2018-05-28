#!/usr/bin/env bash
# generate SSH KEY
if [[ -f $HOME/.ssh/id_rsa ]]; then 
	echo "SSH key already exists."
else 

	echo "new SSH key generated."
	/usr/bin/env ssh-keygen -t rsa -C "codequickly@gmail.com" -P "" -f $HOME/.ssh/id_rsa

fi

echo "Add this SSH public key to Github and Bitbucket:"
echo $HOME/.ssh/id_rsa.pub
