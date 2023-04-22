#!/bin/bash

# Instala 'yad' si no está instalado
if ! command -v yad >/dev/null 2>&1; then
  echo "Instalando dependencias..."
  sudo apt-get update
  sudo apt-get install -y yad
fi

# URL de la imagen del icono
ICON_URL="https://drive.google.com/uc?id=1kUqXG_wiTjL5R8QVAyXrBtgYNsAUAaxM"

# Cuadro de diálogo de bienvenida
yad --title="Bienvenido" --text="Bienvenido al creador de lanzador para Anaconda Navigator" --width=300 --button="Continuar"

# Obtén el nombre de usuario y la ruta de instalación de Anaconda
USERNAME=$(whoami)
ANACONDA_PATH=$(which conda | sed 's/\/bin\/conda//g')

# Verifica si Anaconda está instalado
if [ -z "$ANACONDA_PATH" ]; then
  yad --error --text="Anaconda no está instalado en tu sistema. Por favor, instálalo antes de ejecutar este script."
  exit 1
fi

# Descarga el icono y colócalo en la carpeta de imágenes del usuario
mkdir -p "/home/$USERNAME/imagenes"
wget -O "/home/$USERNAME/imagenes/anaconda-navigator.png" "$ICON_URL"

# Crea un archivo .desktop para el lanzador de Anaconda Navigator
cat > "/home/$USERNAME/Escritorio/anaconda-navigator.desktop" << EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Anaconda Navigator
GenericName=Anaconda Navigator
Comment=Inicie Anaconda Navigator
Exec=bash -c "source $ANACONDA_PATH/etc/profile.d/conda.sh && conda activate base && anaconda-navigator"
Icon=/home/$USERNAME/imagenes/anaconda-navigator.png
Terminal=false
Categories=Development;IDE;
EOL

# Hacer el lanzador ejecutable
chmod +x "/home/$USERNAME/Escritorio/anaconda-navigator.desktop"

# Copia el archivo .desktop en la carpeta de aplicaciones
cp "/home/$USERNAME/Escritorio/anaconda-navigator.desktop" "/home/$USERNAME/.local/share/applications/"

# Cuadro de diálogo de éxito con texto HTML
SUCCESS_TEXT="<html><body><p>Lanzador de <b><font color='red'>Anaconda Navigator</font></b> creado en el escritorio y el menú de aplicaciones.</p><p>Debe <b><font color='red'>permitir que se ejecute como programa</font></b> el nuevo icono creado. Para ello, sitúese sobre el nuevo icono creado y pulse botón derecho (secundario) y <b><font color='red'>permitir ejecutar</font></b>.</p><p>Recuerde que <b><font color='red'>Anaconda Navigator es lento abriéndose</font></b>, dependiendo de las características de su equipo. <b><font color='red'>SEA PACIENTE</font></b>, por favor.</p><p>Gracias por usar este creador de lanzador para Anaconda Navigator.</p></body></html>"

yad --text-info --html --title="Éxito" --text="$SUCCESS
