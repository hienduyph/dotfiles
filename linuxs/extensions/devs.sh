sudo snap install intellij-idea-community --classic
sudo snap install code --classic


curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo add-apt-repository ppa:serge-rider/dbeaver-ce

packages=(
  nodejs
  gcc g++ make
  libmysqlclient-dev
  libssl-dev
  libpq-dev
  dbeaver-ce
)

sudo apt install -y "$packages[@]"
