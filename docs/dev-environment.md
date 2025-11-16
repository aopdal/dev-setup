# Oppsett av PC for utvikling

Dette oppsettet er basert på at brukeren har en Windows 11 PC.
Og vi bruker WSL2 med Ubuntu 24.04, docker for devcontainers og VSCode som editor

Dette er i første rekke en hjelp for netverkskonsulenter for å komme opp på felles
verktøyplatform for deling av kode og enkelt kunne hoppe inn o kjøre andres kode.

## Installasjon av WSL2

[Microsoft dokumentasjon](https://learn.microsoft.com/en-us/windows/wsl/install)

Start PowerShell som administrator og kjør:

```bash
wsl --install
```

Så må PC rebootes.

I PowerShell som admin igjen:

```bash
wsl.exe --install Ubuntu-24.04
```

Du blir spurt om å lage bruker og sette passord i ubuntuen som ble installert.

```bash
exit
```

Finn ubuntu i startmenyen og velg det og se at det starter opp.

Oppdater programvaren med:

```bash
sudo apt update
sudo apt upgrade -y
```

i PowerShell vinduet:

```bash
wsl --shutdown
```

Etter reboot kommer ubuntu profil inn i terminal

## Docker i WSL2 (uten docker desktop som krever lisens)

Installere docker i wsl2:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
```

Lukk Linux vinduet og åpne igjen, sjekk at du er medlem av docker gruppa:

```bash
id
```

output skal bli noe som dette:

```bash
uid=1000(arne) gid=1000(arne) groups=1000(arne),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),100(users),989(docker)
```

Teste docker:

```bash
docker run hello-world
```

Installer docker-compose og Python venv

```bash
sudo apt install docker-compose -y
sudo apt install python3.12-venv -y
```

## SSH nøkkel

SSH pålogging uten brukernavn og passord krever ssh nøkkel.

```bash
ssh-keygen
```

(Sett passord)

Laste ssh nøkkel inn i ssh-agent ved start (innlogging)

```bash
nano ~/.bashrc
```

Legg inn på slutten:

```bash
# start ssh-agent and load key
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
   ssh-agent -s > ~/.ssh/ssh-agent-env
fi
if [ -f ~/.ssh/ssh-agent-env ]; then
    . ~/.ssh/ssh-agent-env > /dev/null
fi
ssh-add ~/.ssh/id_ed25519
```

Teste å laste inn med:

```bash
source ~/.bashrc
```

Du blir spurt om passordet. For sessjonen vil du nå ikke bli spurt om passordet på
nøkkelen hver gang den er i bruk. Det er mulig å legge passordet i lastpass og bruke
commandline lpass osv.

## VSCode

I Windows - start opp "Microsoft store" og finn fram med å søke på vscode og klikk installer.

Nede i høyre hjørne klikk på open a Remote window og velg connect to wsl.

![Open Remote](images/open_remote.png)

Det er en setting som må endres:

File - Preferences - Settings

![Settings](images/settings.png)

Så husker jeg ikke om jeg tok en reboot av hele maskinen før jeg testet videre.
