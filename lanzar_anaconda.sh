#!/bin/bash

# Guardar la ruta de instalación de Anaconda
ANACONDA_PATH="/home/yo/anaconda3"

# Mostrar una ventana de diálogo preguntando si desea lanzar Anaconda Navigator
response=$(zenity --question --text="¿Desea lanzar Anaconda Navigator?" --ok-label="Sí" --cancel-label="No" --width=300 --height=100; echo $?)

# Si el usuario elige Sí (código de salida 0), activar conda en el proyecto base y lanzar Anaconda Navigator
if [ "$response" -eq "0" ]; then
    source "$ANACONDA_PATH"/bin/activate
    anaconda-navigator
fi
