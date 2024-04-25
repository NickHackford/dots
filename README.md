# my dotfiles

## NixOS

`sudo nixos-rebuild switch --flake ~/.config/dots`

## Home Manager

```
sh <(curl -L https://nixos.org/nix/install) --no-daemon
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel update

nix-shell '<home-manager>' -A install
nix-shell -p git

nix-shell '<home-manager>' -A install -p git?

mkdir -p ~/.config/nix && echo 'extra-experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
git clone https://github.com/NickHackford/dots.git ~/.config/dots

home-manager switch --flake ~/.config/dots
home-manager --extra-experimental-features 'nix-command flakes' switch --flake .#hack56224
```

## dconf
Home-manager needs dconf installed to work properly which doesn't come stock on Debian
```
sudo apt-get update
sudo apt install dconf-cli dconf-editor
```

## Docker
Home-manager cannot manage a root docker installation so it should be installed normally

### Script
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker azureuser                                                                                                                                                                 azureuser@ae-camel 18:34:23
 ```
### Manual
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker azureuser                                                                                                                                                                 azureuser@ae-camel 18:34:23

```
