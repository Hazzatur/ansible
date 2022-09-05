#!/bin/bash
cd "${0%/*}" || exit
export PATH=$HOME/.local/bin/:$PATH

# TODO: Pending support for macOS and other distros
# if [ $(uname) == "Darwin" ]; then
# else
#     DISTRO_ID=`. /etc/os-release; echo "$ID" | awk '{print $1}'`
# fi

install_ansible(){
    # Install ansible if not installed
    if ! command -v ansible &>/dev/null; then
        # Install python3 if not installed
        if ! command -v python3 &>/dev/null; then
            sudo apt install python3 -y
        fi

        # Install pip if not installed
        if ! command -v pip &>/dev/null; then
            sudo apt install python3-pip -y
        fi

        # Install ansible
        python3 -m pip install --user ansible
    fi

    if ! pip show jmespath &>/dev/null; then
        python3 -m pip install --user jmespath
    fi
}

run_playbook(){
    if command -v ansible &>/dev/null; then
        ansible-playbook $TAGS main.yml --ask-become-pass --ask-vault-pass
    else
        echo "Ansible not found"
    fi
}

install_ansible
run_playbook
