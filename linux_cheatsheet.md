# 🐧 Linux & DevOps Cheat Sheet

Zestaw najprzydatniejszych poleceń, trików i notatek do codziennej pracy z Linuxem, siecią, procesami, tmuxem, Vimem i zarządzaniem pakietami.  
Komentarze dodane tam, gdzie coś może być nieoczywiste.  

---

## 📑 Spis treści

- [📂 Nawigacja po katalogach](#-nawigacja-po-katalogach)  
  - [pushd / popd](#pushd--popd-stos-katalogów)  
- [🔄 Procesy i joby](#-procesy-i-joby)  
- [⚡ Zarządzanie procesami](#-zarządzanie-procesami)  
- [📝 Historia i skróty w bash](#-historia-i-skróty-w-bash)  
- [🛠️ Edycja i triki w shellu](#️-edycja-i-triki-w-shellu)  
  - [Tworzenie pliku EOF](#tworzenie-pliku-na-szybko-eof)  
- [📦 Archiwizacja i kompresja](#-archiwizacja-i-kompresja)  
- [📡 Przekierowania i strumienie](#-przekierowania-i-strumienie)  
  - [tee](#tee-czytaj--zapisuj)  
  - [xargs](#xargs-masowe-wywołania)  
- [🔍 Wyszukiwanie](#-wyszukiwanie)  
- [🔤 Alias i konfiguracja](#-alias-i-konfiguracja)  
- [🔎 awk w praktyce](#-awk-w-praktyce)  
- [📖 Vim – szybkie notatki](#-vim--szybkie-notatki)  
- [📦 Zarządzanie pakietami](#-zarządzanie-pakietami)  
- [🔥 Firewalle](#-firewalle)  
  - [ufw](#ufw-ubuntudebian)  
  - [firewalld](#firewalld-rhelcentosfedora)  
- [🌐 Narzędzia sieciowe](#-narzędzia-sieciowe)  
- [🖥️ Tmux – zarządzanie sesjami](#️-tmux--zarządzanie-sesjami)  
- [📌 Pakiety (Debian / RHEL)](#-pakiety-debian--rhel)  

---

## 📂 Nawigacja po katalogach

```bash
pwd                      # pokaż bieżący katalog
ls -la                   # lista plików, także ukrytych
ls -lh                   # rozmiary plików w czytelnej formie
cd -                     # powrót do poprzedniego katalogu
cd ~                     # powrót do katalogu domowego
```

### pushd / popd (stos katalogów)
```bash
pushd /etc               # przejdź do /etc i dodaj do stosu
pushd -                  # zamiana katalogów (rotate)
popd                     # usuń katalog ze stosu i wróć
dirs -v                  # lista stosu katalogów
```

---

## 🔄 Procesy i joby

```bash
sleep 100 &              # uruchomienie w tle (&)
jobs                     # lista jobów
fg %1                    # przeniesienie joba 1 na foreground
bg %1                    # wznowienie joba w tle
disown %1                # odłączenie joba od terminala
nohup cmd &              # proces nie zakończy się po wylogowaniu
```

💡 **Różnica `disown` vs `nohup`**:  
- `disown` → proces zostaje w tle, ale może zginąć po wylogowaniu.  
- `nohup` → proces ignoruje sygnał `HUP`, więc przeżyje wylogowanie.  

---

## ⚡ Zarządzanie procesami

```bash
ps aux                   # pełna lista procesów
ps -ef                   # alternatywny format
top / htop               # monitorowanie procesów
lsof -i :80              # który proces używa portu 80
kill -9 1234             # zabij proces o PID 1234
renice -n 10 -p 1234     # zmień priorytet procesu (większa wartość = mniejszy priorytet)
```

---

## 📝 Historia i skróty w bash

```bash
Ctrl+R                   # reverse search w historii
!!                       # powtórz ostatnie polecenie
!$                       # ostatni argument ostatniego polecenia (Alt+. też działa)
!*                       # wszystkie argumenty
!^                       # pierwszy argument
```

---

## 🛠️ Edycja i triki w shellu

```bash
Ctrl+U                   # wytnij od początku linii do kursora
Ctrl+K                   # wytnij od kursora do końca linii
Ctrl+Y                   # wklej ostatnio wycięty tekst
```

### Tworzenie pliku „na szybko” (EOF)
```bash
cat <<EOF > file.txt
Hello world
EOF
```

---

## 📦 Archiwizacja i kompresja

```bash
tar -czf archive.tar.gz dir1 dir2   # spakuj katalogi do .tar.gz
tar -xzf archive.tar.gz             # rozpakuj do bieżącego katalogu
tar -xzf archive.tar.gz -C newdir   # rozpakuj do nowego katalogu
unzip file.zip -d targetdir         # rozpakuj ZIP do katalogu
split -b 50M bigfile.iso part_      # podziel na kawałki po 50 MB
cat part_* > bigfile.iso            # złóż pliki w całość
```

---

## 📡 Przekierowania i strumienie

```bash
command > out.txt         # stdout do pliku (nadpisanie)
command >> out.txt        # stdout do pliku (dopisz)
command 2> err.txt        # stderr do pliku
command &> all.txt        # stdout + stderr razem
command > /dev/null 2>&1  # wszystko w niebyt
```

### tee (czytaj + zapisuj)
```bash
ls -la | tee list.txt              # pokaż i zapisz
ls -la | tee -a list.txt           # dopisz do pliku
```

### xargs (masowe wywołania)
```bash
find . -name "*.log" | xargs rm    # usuń wszystkie *.log
cat list.txt | xargs -I{} echo {}  # użyj {} jako placeholdera
```

---

## 🔍 Wyszukiwanie

```bash
find . -type d -name "conf*"       # katalogi pasujące do conf*
find . -type f -name "*.log"       # pliki .log
find /etc -maxdepth 1 -type f      # pliki tylko w /etc
grep -R "ERROR" /var/log           # wyszukaj "ERROR" w logach
```

---

## 🔤 Alias i konfiguracja

```bash
alias ll='ls -la'                  # alias tymczasowy
unalias ll                         # usuń alias
# na stałe: dodaj do ~/.bashrc
echo "alias ll='ls -la'" >> ~/.bashrc && source ~/.bashrc
```

---

## 🔎 awk w praktyce

```bash
LOCAL_IP=$(ip r | awk '/default/ {print $9}')   # IP interfejsu
awk '{print $2}' file.txt                       # druga kolumna
awk '/error/ {print $0}' log.txt                # linie z "error"
awk '{sum += $2} END {print sum}' file.txt      # suma wartości
```

---

## 📖 Vim – szybkie notatki

### Podstawowe ruchy
- `gg` → początek pliku  
- `G` → koniec pliku  
- `:n` → idź do linii n  

### Markery
```vim
ma     " ustaw marker a
`a     " idź do markera (dokładnie)
'a     " idź do linii z markerem
```

### Makra
```vim
qa     " nagrywanie makra do rejestru a
q      " zakończenie nagrywania
@a     " odtwórz makro
@@     " powtórz ostatnie makro
```

---

## 📦 Zarządzanie pakietami

### Debian/Ubuntu (apt)
```bash
sudo apt update
sudo apt upgrade
sudo apt install pkg
sudo apt remove pkg
sudo apt autoremove
sudo apt clean
apt list --installed
```

### RHEL/CentOS/Fedora (yum/dnf)
```bash
sudo yum install pkg
sudo yum remove pkg
sudo yum update
sudo yum list installed
sudo yum clean all

# nowsze systemy:
sudo dnf install pkg
sudo dnf upgrade
```

---

## 🔥 Firewalle

### ufw (Ubuntu/Debian)
```bash
sudo ufw enable / disable
sudo ufw status verbose
sudo ufw allow 22/tcp
sudo ufw deny from 10.0.0.0/8
sudo ufw allow from 192.168.1.10 to any port 22
sudo ufw delete allow 22/tcp
```

### firewalld (RHEL/CentOS/Fedora)
```bash
sudo firewall-cmd --state
sudo firewall-cmd --list-all
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# dla IP
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.10" port port="22" protocol="tcp" accept'
```

---

## 🌐 Narzędzia sieciowe

### Ports & sockets
```bash
ss -tuln                  # nasłuchujące porty (pakiet: iproute2/iproute)
netstat -tuln             # starsze narzędzie (pakiet: net-tools)
lsof -i :80               # proces używający portu 80
```

### Skanowanie
```bash
nmap localhost            # skan portów (pakiet: nmap)
nmap -p 20-100 127.0.0.1  # zakres portów
nmap -sV 192.168.1.1      # wersje usług
```

### Sniffing
```bash
tcpdump -i eth0           # sniff na interfejsie eth0
tcpdump -i eth0 port 22   # tylko SSH
tshark -i eth0            # Wireshark CLI (pakiet: wireshark)
```

---

## 🖥️ Tmux – zarządzanie sesjami

```bash
tmux new -s mysession       # nowa sesja
tmux ls                     # lista sesji
tmux attach -t mysession    # dołącz do sesji
tmux detach (Ctrl+b d)      # odłącz
```

### Panes & windows
```bash
Ctrl+b %                   # podziel pionowo
Ctrl+b "                   # podziel poziomo
Ctrl+b o                   # przełącz pane
Ctrl+b x                   # zamknij pane
Ctrl+b c                   # nowe okno
Ctrl+b n/p                 # następne/poprzednie okno
```

💡 Sesje w tmuxie działają dalej na serwerze nawet po rozłączeniu SSH.  
Możesz się ponownie podpiąć z innego hosta, jeśli masz dostęp do tego samego serwera.

---

## 📌 Pakiety (Debian / RHEL)

| Narzędzie  | Debian/Ubuntu        | RHEL/Fedora            |
|------------|----------------------|------------------------|
| ss         | iproute2             | iproute                |
| netstat    | net-tools            | net-tools              |
| nmap       | nmap                 | nmap                   |
| wireshark  | wireshark            | wireshark, wireshark-cli|
| tshark     | wireshark            | wireshark-cli          |
| tcpdump    | tcpdump              | tcpdump                |
| lsof       | lsof                 | lsof                   |
| hping3     | hping3               | hping (EPEL repo)      |

---
