#!/bin/bash
# ==============================================================================
# 🏛️ KRONOS SOBERANO - SCRIPT DE DESPLIEGUE ATÓMICO (V19.3)
# Automatización de Renombramiento y Publicación de Infraestructura
# Arquitecto: Marco Antonio Rojas Valdovinos
# ==============================================================================

PRIMARY='\033[0;36m'
GOLD='\033[0;33m'
DANGER='\033[0;31m'
NC='\033[0m'

echo -e "${PRIMARY}--- INICIANDO PROTOCOLO DE DESPLIEGUE KRONOS ---${NC}"

# 1. Validación de Identidad
echo -e "${GOLD}[1/5] Verificando firma de mando...${NC}"
gh auth status || {
  echo -e "${DANGER}ERROR: No autenticado en GitHub CLI.${NC}"
  exit 1
}

# 2. Respaldo de Seguridad
echo -e "${GOLD}[2/5] Creando punto de restauración inmutable...${NC}"
git checkout main && git pull origin main
git branch backup-soberano-$(date +%s)
echo -e "🟢 Respaldo creado en la rama local."

# 3. Alineación Perimetral
echo -e "${GOLD}[3/5] Alineando activos en el perímetro...${NC}"
if [ -d "public" ]; then
  mv public/* .
  rmdir public
  git add .
  git commit -m "chore: alineacion de activos para despliegue soberano"
  git push origin main
  echo -e "🟢 Archivos posicionados correctamente."
else
  echo "Aviso: Carpeta public/ no detectada. Continuando..."
fi

# 4. Renombramiento de Bóveda
echo -e "${GOLD}[4/5] Renombrando bóveda a kronosproyect.github.io...${NC}"
OLD_REPO="KRONOSPROYECT/tejido-cuantico-nacional-v17-"
NEW_NAME="kronosproyect.github.io"

gh repo rename "$OLD_REPO" "$NEW_NAME" --yes \
  && echo -e "🟢 Repositorio renombrado con éxito."

# 5. Apertura de Perímetro
echo -e "${GOLD}[5/5] Abriendo perímetros al público internacional...${NC}"
gh repo edit "KRONOSPROYECT/$NEW_NAME" --visibility public --yes

echo -e "${PRIMARY}--- 🏛️ INFRAESTRUCTURA SOBERANA DESPLEGADA ---${NC}"
echo -e "${GOLD}URL: https://kronosproyect.github.io/${NC}"
echo -e "Espere 60 segundos a que los robots de GitHub terminen la construcción."