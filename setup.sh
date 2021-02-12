#
#    AWS Workspace Setup
#    ~~~~~~~~~~~~~~~~~~~
#
#    This script documents the steps required to
#    configure and personalize a Linux workspace
#    from scratch in AWS.
#
####################################
# (1) Initialize Workspace
####################################
# Create a WorkSpace in AWS using Quick Start:
#   (a) In AWS Console
#           > WorkSpaces
#             > Quick Start
#               > Linux Bundle


####################################
# (2) Customize OS Preferences
####################################
# (a) Keyboard shortcuts
# (b) Add Caja, Firefox to Panel
# (c) Enable Firefox sync


####################################
# (3) Customize bash profile
####################################
echo "source ~/.git-prompt.sh" >> ~/.bash_profile;
echo "alias ll='ls -all'" >> ~/.bash_profile;
echo "export PS1='\e[0;34m[\u@\h]\e[m \e[0;95m(\w)\e[m $(__git_ps1 "\e[0;92m(%s)\e[m") \n\$ '" >> ~/.bash_profile;
source ~/.bash_profile;

# Follow below steps to apply bash profile on startup:
#   (a) In Terminal:
#           > 'Settings'
#             > 'Use profile'
#               > '~/.bash_profile'


####################################
# (4) Install PyCharm
####################################
# Download -> https://www.jetbrains.com/pycharm/
# Install:
sudo tar xfz pycharm-*.tar.gz -C /opt/;
cd /opt/pycham-*/bin;
./pycharm.sh;

# Follow the below steps to add PyCharm to Desktop:
#  (a) In PyCharm:
#          > Tools
#            > Create Desktop Entry
#              > Create
#
#  (b) Once complete, kill PyCharm, then:
#          > Applications
#            > Programming
#              > Right-click 'PyCharm'
#                > 'Add this launcher to panel'
#
# (c) Update keyboard shortcuts in PyCharm


####################################
# (5) Setup Git
####################################
# Configure user/pass/name
git config --global user.email "<GIT_EMAIL>"
git config --global user.name "<GIT_USERNAME>"

# Add aliases
git config --global alias.lga "log --graph --oneline --all --decorate"
git config --global alias.s "status"

# Enable autocompletion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
  -o ~/.git-completion.bash

# Create dir to persist repos
mkdir ~/repos


####################################
# (6) Configure AWS CLI
####################################
# (a) Create IAM user:
#         > AWS Console
#           > IAM
#             > Create User
#               > Add to 'Administrators' group
#                 > Enable console & programmatic access
# Enter credentials & region

# (b) Authenticate CLI
aws configure


####################################
# (7) Configure gcloud CLI
####################################
cd ~/repos/
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-325.0.0-darwin-x86_64.tar.gz;
tar -xf google-cloud-sdk-325.0.0-darwin-x86_64.tar.gz;
rm google-cloud-sdk-325.0.0-darwin-x86_64.tar.gz;
./google-cloud-sdk/install.sh;
./google-cloud-sdk/bin/gcloud init
gcloud components install alpha;
gcloud components install beta;
gcloud config set run/region us-central1;
gcloud config set core/project andrewblange;

# TODO: Create service account & bind to JSON credentials file.


####################################
# (8) Install pyenv
####################################
# Install OS dependencies
sudo yum install yum-utils
sudo yum-builddep python3

# Use pyenv-installer project to install pyenv
curl https://pyenv.run | bash

# Add the following to ~/.bashrc:
export PATH="/home/ablange/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Restart shell


################################
# (9) Use pyenv to Install Python
################################
# List all available Python versions

# List Python versions from 3.6 to 3.8
pyenv install --list | grep " 3\.[678]"

# Install a version Python3
pyenv install -v 3.8.7

# List installed versions
pyenv versions

# (optional) Test that a version was installed correctly
pyenv global 3.8-dev
python -m test

# (optional) Switch back to default Python version
pyenv global system
python -V
#>>> Python 2.7.12

# (optional) Uninstall a version
pyenv uninstall 3.8.7


################################
# (10) Create a Project
################################
# Create venv
pyenv virtualenv 3.8.7 "<PROJECT>"

# Activate venv
pyenv activate "<PROJECT>"

# Deactivate venv
pyenv deactivate

####################################
# (11) Install Other Applications
####################################
# Install Postman
cd ~/Downloads/;
wget https://dl.pstmn.io/download/latest/linux64;
tar -xf Postman-linux-x64-8.0.4.tar.gz;
rm Postman-linux-x64-8.0.4.tar.gz;
sudo mv Postman /opt/;
# Create desktop entry
sudo nano ~/.local/share/applications/Postman.desktop;
'''
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
'''
