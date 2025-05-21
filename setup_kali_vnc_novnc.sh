#!/bin/bash
# filepath: setup_kali_vnc_novnc.sh

echo "=== Update & Grundpakete installieren ==="
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tigervnc-standalone-server git python3

echo "=== VNC-Passwort setzen ==="
echo "Bitte VNC-Passwort eingeben (wird für die Verbindung benötigt):"
vncpasswd

echo "=== VNC xstartup konfigurieren ==="
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<EOF
#!/bin/sh
xrdb \$HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

echo "=== VNC-Server einmalig starten & stoppen, um alles zu initialisieren ==="
vncserver :1
vncserver -kill :1

echo "=== noVNC herunterladen und vorbereiten ==="
git clone https://github.com/novnc/noVNC.git ~/noVNC
cd ~/noVNC
git clone https://github.com/novnc/websockify.git

echo "=== Fertig! ==="
echo ""
echo "Starte deine Desktop-Session künftig mit:"
echo "------------------------------------------"
echo "1. VNC-Server starten:"
echo "   vncserver :1"
echo ""
echo "2. noVNC starten (im ~/noVNC Verzeichnis):"
echo "   cd ~/noVNC"
echo "   ./utils/novnc_proxy --vnc localhost:5901"
echo ""
echo "3. Im Browser öffnen:"
echo "   http://<deine-ip>:6080/vnc.html"
echo ""
echo "Viel Erfolg!"
