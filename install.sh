#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# URL del repositorio
REPO_URL="https://raw.githubusercontent.com/jdanielr07/scripts/main"

echo -e "${BLUE}🚀 Instalando comp...${NC}"

# Verificar si curl está instalado
if ! command -v curl &> /dev/null; then
    echo -e "${RED}❌ curl no está instalado. Instálalo primero.${NC}"
    exit 1
fi

# Crear directorio si no existe
sudo mkdir -p /usr/local/bin

# Descargar el script principal
echo -e "${YELLOW}📥 Descargando comp...${NC}"
if sudo curl -fsSL "$REPO_URL/comp" -o /usr/local/bin/comp; then
    echo -e "${GREEN}✅ Script descargado correctamente${NC}"
else
    echo -e "${RED}❌ Error al descargar el script${NC}"
    exit 1
fi

# Hacer el script ejecutable
sudo chmod +x /usr/local/bin/comp

# Función para instalar gum desde GitHub
install_gum_from_github() {
    echo -e "${YELLOW}📦 Instalando gum desde GitHub...${NC}"
    
    # Detectar arquitectura
    ARCH=$(uname -m)
    case $ARCH in
        x86_64) ARCH="x86_64" ;;
        aarch64|arm64) ARCH="arm64" ;;
        armv7l) ARCH="armv7" ;;
        i386|i686) ARCH="i386" ;;
        *) echo -e "${RED}❌ Arquitectura no soportada: $ARCH${NC}"; return 1 ;;
    esac
    
    # Detectar sistema operativo
    OS="Linux"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="Darwin"
    fi
    
    # Obtener la versión más reciente
    GUM_VERSION=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
    GUM_VERSION_SHORT=${GUM_VERSION#v}
    GUM_URL="https://github.com/charmbracelet/gum/releases/download/${GUM_VERSION}/gum_${GUM_VERSION_SHORT}_${OS}_${ARCH}.tar.gz"
    
    echo -e "${YELLOW}📥 Descargando gum ${GUM_VERSION}...${NC}"
    
    # Descargar e instalar
    if curl -fsSL "$GUM_URL" -o /tmp/gum.tar.gz && \
       sudo tar -xzf /tmp/gum.tar.gz -C /tmp && \
       sudo mv /tmp/gum_${GUM_VERSION_SHORT}_${OS}_${ARCH}/gum /usr/local/bin/gum && \
       sudo chmod +x /usr/local/bin/gum && \
       sudo rm -rf /tmp/gum_${GUM_VERSION_SHORT}_${OS}_${ARCH}; then
        echo -e "${GREEN}✅ gum instalado correctamente desde GitHub${NC}"
        rm -f /tmp/gum.tar.gz
        return 0
    else
        echo -e "${RED}❌ Error al instalar gum desde GitHub${NC}"
        echo -e "${YELLOW}💡 Intenta instalar manualmente:${NC}"
        echo -e "   Visita: https://github.com/charmbracelet/gum#installation"
        rm -f /tmp/gum.tar.gz
        sudo rm -rf /tmp/gum_${GUM_VERSION_SHORT}_${OS}_${ARCH} 2>/dev/null
        return 1
    fi
}

# Verificar si gum está instalado
if ! command -v gum &> /dev/null; then
    echo -e "${YELLOW}📦 Instalando gum...${NC}"
    
    # Detectar sistema operativo
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install gum
        else
            install_gum_from_github
        fi
    else
        # Linux - Intentar primero con gestores de paquetes
        GUM_INSTALLED=false
        
        if command -v apt-get &> /dev/null; then
            if sudo apt-get update -qq && sudo apt-get install -y -qq gum >/dev/null 2>&1; then
                GUM_INSTALLED=true
            fi
        elif command -v dnf &> /dev/null; then
            if sudo dnf install -y -q gum >/dev/null 2>&1; then
                GUM_INSTALLED=true
            fi
        elif command -v yum &> /dev/null; then
            if sudo yum install -y -q gum >/dev/null 2>&1; then
                GUM_INSTALLED=true
            fi
        elif command -v pacman &> /dev/null; then
            if sudo pacman -S gum --noconfirm --quiet >/dev/null 2>&1; then
                GUM_INSTALLED=true
            fi
        elif command -v zypper &> /dev/null; then
            if sudo zypper install gum --non-interactive --quiet >/dev/null 2>&1; then
                GUM_INSTALLED=true
            fi
        fi
        
        # Si no se pudo instalar con gestores de paquetes, usar GitHub
        if [[ "$GUM_INSTALLED" == "false" ]]; then
            install_gum_from_github
        fi
    fi
fi

echo -e "${GREEN}🎉 ¡Instalación completada!${NC}"
echo -e "${BLUE}💡 Usa el comando:${NC}"
echo -e "   ${YELLOW}comp${NC} - Inicia el compresor interactivo"
echo ""
echo -e "${BLUE}📖 Ejemplo de uso:${NC}"
echo -e "   ${YELLOW}comp${NC} - Inicia el compresor interactivo"
