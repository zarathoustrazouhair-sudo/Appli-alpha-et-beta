#!/bin/bash

# --- CONFIGURATION ---
APP_NAME="SyndicPro_Amandier_Gold"
OUTPUT_DIR="build/app/outputs/flutter-apk"
TIMESTAMP=$(date +"%Y%m%d_%H%M")

# --- COULEURS ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=================================================${NC}"
echo -e "${YELLOW}🚀 PROTOCOLE DE REBOOT: SYNDIC PRO (L'AMANDIER)${NC}"
echo -e "${BLUE}=================================================${NC}"

# ETAPE 1: NETTOYAGE
echo -e "\n${YELLOW}[1/4] 🧹 Grand Nettoyage (Flutter Clean)...${NC}"
flutter clean
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Erreur lors du nettoyage.${NC}"
    exit 1
fi

# ETAPE 2: DÉPENDANCES
echo -e "\n${YELLOW}[2/4] 📦 Récupération des librairies (Pub Get)...${NC}"
flutter pub get
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Erreur lors du pub get.${NC}"
    exit 1
fi

# ETAPE 3: GÉNÉRATION DE CODE (CRITIQUE DRIFT/DB)
echo -e "\n${YELLOW}[3/4] ⚙️ Régénération de la Base de Données (Build Runner)...${NC}"
echo -e "${BLUE}      Cela peut prendre une minute...${NC}"
dart run build_runner build --delete-conflicting-outputs
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Erreur Critique : La base de données n'a pas pu être générée.${NC}"
    exit 1
fi

# ETAPE 4: COMPILATION MULTI-TARGET
echo -e "\n${YELLOW}QUELLE APPLICATION VEUX-TU COMPILER ?${NC}"
echo "1) SYNDIC PRO (Admin - Alpha)"
echo "2) RÉSIDENT (Client - Beta)"
read -p "Choix (1 ou 2) : " app_choice

if [ "$app_choice" == "1" ]; then
    TARGET="lib/main.dart"
    NAME="SyndicPro_Admin"
elif [ "$app_choice" == "2" ]; then
    TARGET="lib/main_resident.dart"
    NAME="SyndicPro_Resident"
else
    echo "Choix invalide."
    exit 1
fi

echo -e "\n${YELLOW}[4/4] 🔨 Compilation de $NAME (Optimisée R8)...${NC}"
# Suppression de --no-shrink pour activer l'optimisation (R8) et réduire la taille de l'APK
flutter build apk --release -t $TARGET

if [ $? -eq 0 ]; then
    # RENOMMAGE FINAL
    SOURCE_APK="$OUTPUT_DIR/app-release.apk"
    FINAL_NAME="${NAME}_v1_${TIMESTAMP}.apk"
    mv "$SOURCE_APK" "$OUTPUT_DIR/$FINAL_NAME"
    
    echo -e "\n${GREEN}✅ SUCCÈS ! APK GÉNÉRÉ : $FINAL_NAME${NC}"
    echo -e "${GREEN}📁 Votre APK est prêt ici :${NC}"
    echo -e "${BLUE}👉 $OUTPUT_DIR/$FINAL_NAME${NC}"
    
    # Ouverture du dossier (optionnel, marche souvent sur Linux/Gnome)
    xdg-open "$OUTPUT_DIR" 2>/dev/null
else
    echo -e "\n${RED}❌ ÉCHEC de la compilation.${NC}"
    exit 1
fi
