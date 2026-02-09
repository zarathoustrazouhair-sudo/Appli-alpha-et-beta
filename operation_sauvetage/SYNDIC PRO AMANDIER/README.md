# SYNDIC PRO AMANDIER SUITE V2.0

## Architecture
Ce dépôt contient deux applications Flutter partageant le même code source ("Monorepo Logic") mais compilées avec des points d'entrée différents.

### 1. AMANDIER MANAGER (Admin)
*   **Point d'entrée :** `lib/main.dart`
*   **Cible :** Syndic & Adjoint.
*   **Fonctionnalités :** 
    *   Gestion locale (Offline-First) via SQLite (Drift).
    *   Tableau de bord "Cockpit" (Finances, Résidents, Incidents).
    *   Génération de documents légaux (PDF Loi 18-00).
    *   Synchronisation des soldes vers le Cloud.
    *   Réception des alertes "Siren" (Incidents urgents).

### 2. AMANDIER LIFE (Résident)
*   **Point d'entrée :** `lib/main_resident.dart`
*   **Cible :** Copropriétaires.
*   **Fonctionnalités :**
    *   Connexion sécurisée (Etage -> Apt -> PIN).
    *   Signalement d'incidents (Anonyme/Signé, Urgent).
    *   Bouton SOS (WhatsApp + Cloud).
    *   Visualisation Caméra Entrée.
    *   Consultation Solde & Communications.

## Commandes de Build

### Pré-requis
*   Flutter SDK >= 3.0
*   Supabase Account (configuré dans `lib/main.dart` et `lib/main_resident.dart`)

### Installation
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Compiler AMANDIER MANAGER (APK)
```bash
flutter build apk --release -t lib/main.dart --name=AmandierManager
```

### Compiler AMANDIER LIFE (APK)
```bash
flutter build apk --release -t lib/main_resident.dart --name=AmandierLife
```

### Script Automatisé
Utilisez le script interactif pour nettoyer, générer et compiler :
```bash
./reboot_syndic.sh
```

## Base de Données
*   **Locale (Admin) :** SQLite (Drift). Schéma version 11.
*   **Cloud (Sync) :** Supabase. Voir `supabase_schema_v2_final.sql` pour la structure.

## Auteur
Zouhair - Version Prestige 2.0 (Février 2026)
