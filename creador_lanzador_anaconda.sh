#!/bin/bash

# URL de la imagen del icono
ICON_URL="https://drive.google.com/uc?id=1kUqXG_wiTjL5R8QVAyXrBtgYNsAUAaxM"

# Cuadro de diálogo de bienvenida
zenity --info --title="Bienvenido" --text="Bienvenido al creador de lanzador para Anaconda Navigator" --width=300 --ok-label="Continuar"

# Obtén el nombre de usuario y la ruta de instalación de Anaconda
USERNAME=$(whoami)
ANACONDA_PATH=$(which conda | sed 's/\/bin\/conda//g')

# Verifica si Anaconda está instalado
if [ -z "$ANACONDA_PATH" ]; then
  zenity --error --text="Anaconda no está instalado en tu sistema. Por favor, instálalo antes de ejecutar este script."
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

# Cuadro de diálogo de éxito con formulario
zenity --info --title="Éxito" --text="Anaconda Navigator creado en el escritorio y el menú de aplicaciones.


Debe permitir que se ejecute como programa el nuevo icono creado. Para ello, sitúese sobre el nuevo icono creado y pulse botón derecho (secundario) y permitir ejecutar.
Anaconda Navigator es lento abriéndose. SEA PACIENTE, por favor." --width=500 --height=150 --ok-label="Finalizar"

