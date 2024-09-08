#!/bin/bash

# Función para instalar librerías necesarias
instalar_librerias() {
    echo "Instalando librerías necesarias..."
    
  #!/bin/bash

# Comprobamos si el sistema es macOS
if [[ "$(uname)" == "Darwin" ]]; then
    echo "Instalando en macOS..."
    brew install ncurses sdl2 sdl2_mixer

# Comprobamos si el sistema es Debian/Ubuntu
elif [[ -x "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt install -y libncurses5-dev libncursesw5-dev libsdl2-dev libsdl2-mixer-dev

# Comprobamos si el sistema es Fedora
elif [[ -x "$(command -v dnf)" ]]; then
    sudo dnf install -y ncurses-devel SDL2-devel SDL2_mixer-devel

# Comprobamos si el sistema es Arch
elif [[ -x "$(command -v pacman)" ]]; then
    sudo pacman -S --noconfirm ncurses sdl2 sdl2_mixer

else
    echo "Sistema no soportado. Por favor, instala las librerías manualmente."
    exit 1
fi

}

# Compilar el programa
compilar() {
    gcc Naves_espaciales.c -o Naves_espaciales -lncurses -lSDL2 -lSDL2_mixer
}

# Comprobar si las librerías están instaladas
comprobar_librerias() {
    if ! dpkg -l | grep -q libncurses5-dev; then
        instalar_librerias
    fi
    
    if ! dpkg -l | grep -q libsdl2-dev; then
        instalar_librerias
    fi
    
    if ! dpkg -l | grep -q libsdl2-mixer-dev; then
        instalar_librerias
    fi
}

# Comenzar el script
echo "Comprobando librerías necesarias..."
comprobar_librerias

echo "Compilando el programa..."
compilar

if [ $? -eq 0 ]; then
    echo "Compilación exitosa. Ejecutando el programa..."
    ./Naves_espaciales
else
    echo "Error en la compilación."
fi