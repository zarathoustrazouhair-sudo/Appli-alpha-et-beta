# MASTER TECHNICAL BLUEPRINT: AMANDIER SUITE
**Version:** 1.0.0 (Gold Master Analysis)
**Status:** VALIDATED
**Architect:** Jules

---

## 1. ARCHITECTURE GLOBALE

### Structure Monorepo
Le projet est un **Monorepo Flutter** unique contenant les deux applications. La distinction se fait au niveau du point d'entrée (`main.dart`).

*   **Racine** : `operation_sauvetage/SYNDIC PRO AMANDIER`
*   **Dossier Source** : `lib/` (Code partagé et spécifique)
*   **Points d'entrée** :
    *   `lib/main.dart` : **Amandier Manager** (Syndic/Admin).
    *   `lib/main_resident.dart` : **Amandier Life** (Résident/SOS).

### Tech Stack & Packages Critiques
*   **Framework** : Flutter (SDK >=3.0.0)
*   **State Management** : `flutter_riverpod` (v2.4.10) + `riverpod_generator`
*   **Backend** : `supabase_flutter` (v2.12.0)
*   **Base de Données Locale** : `drift` (v2.16.0) + `sqlite3` (Offline-First pour Manager)
*   **PDF Generation** : `pdf` (v3.10.8) + `printing` (v5.14.2)
*   **Audio** : `audioplayers` (v6.5.1) (Pour alertes SOS ?)
*   **UI Components** : `percent_indicator` (Jauges), `fl_chart` (Graphiques)
*   **Sécurité** : `flutter_dotenv` (Gestion des secrets)

---

## 2. LE "PONT" SUPABASE (COMMUNICATION MANAGER <-> LIFE)

### Mécanisme de Communication
Les deux applications ne se parlent pas directement (P2P). Elles utilisent **Supabase** comme relai temps réel.
*   **Manager** : Écoute les changements via `Stream` (Realtime).
*   **Life** : Écrit (Insert/Upsert) dans la base de données.

### Schéma de Données (Déduit)
| Table Supabase | Rôle | Modèle Dart associé |
| :--- | :--- | :--- |
| `incidents` | Stocke les SOS et signalements des résidents. | `IncidentModel` |
| `resident_status` | Stocke l'état financier/info du résident (synchro par Manager). | N/A (Direct Insert) |
| `app_config` | Configuration globale de l'application. | N/A (Map) |

### Flux Temps Réel (SOS)
1.  **Émetteur (Life)** : Le résident appuie sur SOS ou crée un signalement.
    *   `Supabase.instance.client.from('incidents').insert({...})`
2.  **Canal** : Supabase Realtime propage l'événement `INSERT`.
3.  **Récepteur (Manager)** : Le Manager écoute via `IncidentRepository`.
    *   `_supabase.from('incidents').stream(primaryKey: ['id'])`
    *   L'interface (`IncidentsScreen` / `Dashboard`) se met à jour instantanément via `StreamProvider`.

---

## 3. CARTOGRAPHIE DES FEATURES

### A. AMANDIER MANAGER (Le "Cockpit")
L'application de gestion complète pour le Syndic.

*   **Dashboard (Cockpit)** :
    *   Vue d'ensemble "Cyber-Prestige" (Or/Noir).
    *   Suivi Trésorerie & Runway (Mois de survie).
    *   **Matrice Résidents** : Grille 15 cellules (Rouge/Vert/Or) pour état des dettes.
    *   **Smart Feed** : Flux des dernières transactions locales.
    *   **Recovery HUD** : Jauge de recouvrement global.
*   **Gestion Résidents** :
    *   Liste complète, Détails, Historique, Balance.
    *   Relance de masse (`BulkRelaunchScreen`).
*   **Finances** :
    *   Saisie de transaction (Recette/Dépense).
    *   Historique complet.
    *   Gestion des dépenses (`ExpensesScreen`).
*   **Incidents (Siren)** :
    *   Réception des SOS et signalements en temps réel.
*   **Juridique & Admin** :
    *   Génération de documents légaux (Mise en demeure, Contrats).
    *   Gestion des Assemblées Générales (AG) : Présence, Votes, PV.
*   **Prestataires** :
    *   Annuaire et gestion des fournisseurs.

### B. AMANDIER LIFE (Le "Compagnon")
L'application légère pour les résidents.

*   **Authentification** :
    *   Login simplifié par Numéro de téléphone + Code PIN (vérifié via `resident_status`).
*   **Dashboard** :
    *   Consultation du solde personnel (synchro depuis Manager).
    *   Signalement d'incidents / SOS.
    *   Fil d'actualité (Posts).

---

## 4. SÉCURITÉ & DATA

### Authentification
*   **Manager** : Pas d'authentification forte implémentée dans le code analysé (Logique "Local-First" sur appareil sécurisé).
*   **Life** : Authentification "Soft" via PIN Code stocké en clair dans la table `resident_status`.
    *   *Risque Identifié* : Les PINs sont synchronisés depuis le Manager vers le Cloud sans hachage visible.

### Gestion des Clés API
*   **État Actuel** : Sécurisé via `.env`.
*   **Mécanisme** : `flutter_dotenv` charge les variables `SUPABASE_URL` et `SUPABASE_ANON_KEY` au démarrage (`main.dart`).
*   **Git** : Le fichier `.env` est ignoré (`.gitignore`), ce qui prévient les fuites accidentelles.

---

## 5. DIAGNOSTIC MODULES SPÉCIFIQUES

### Moteur PDF (`EcoPdfService`)
Une usine à gaz très complète capable de générer quasiment tout document administratif.
*   **Tech** : `package:pdf` (création bas niveau).
*   **Documents Supportés** :
    *   Reçus Paiement.
    *   Appels de fonds & Mises en demeure.
    *   PV d'Assemblée Générale & Feuilles de présence.
    *   Contrats de travail & Bulletins de paie.
    *   Bons de commande.
    *   Journaux de caisse & Tableaux annuels.

### Bouton SOS (`Incidents`)
*   **Trigger** : Insertion directe en base Supabase (`incidents`).
*   **Champs Critiques** : `is_urgent` (Booléen), `title` (Type d'incident), `resident_phone`.
*   **Alerte** : Le Manager détecte le flag `is_urgent` et affiche une icône rouge/alerte dans le flux.

---
**Fin du rapport technique.**
