set -x
mkdir .linux_local_setup
cd .linux_local_setup || exit
python -m venv .venv
.venv/bin/pip install ansible
.venv/bin/ansible-playbook -i ../hosts.ini --limit local_node ../myLinuxSetup.yml
cd ..
rm -rf .linux_local_setup
exec bash
