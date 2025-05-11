!#/bin/bash

VAULT_PASS_FILE="$HOME/.ansible/vault_pass"
ANSIBLE_PULL_CMD="ansible-pull -U https://github.com/Peppeppa/ansible-pull-ws-packages.git -u medvidec -K --vault-password-file $HOME/.ansible/vault_pass"

#create vault pw file
function set_vault_password {
  mkdir -p "$HOME/.ansible"
  
  echo -n "Bitte Vault Passwort eingeben"
  stty -echo 
  read VAULT_PASS 
  stty echo
  echo

  echo "$VAULT_PASS" > "$VAULT_PASS_FILE"
  chmod 600 "$VAULT_PASS_FILE"

  echo "Passwort wurde in $VAULT_PASS_FILE gespeichert."

}

if [[ "$1" == "--pass" ]]; then
  rm $VAULT_PASS_FILE
  set_vault_password
  exit 0
fi

if [ ! -f "$VAULT_PASS_FILE" ]; then
  set_vault_password
fi
$ANSIBLE_PULL_CMD
