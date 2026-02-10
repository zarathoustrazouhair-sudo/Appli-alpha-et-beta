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

## 4. SÉCURITÉ & DATA (RENFORCÉ)

### Authentification & Cryptographie
*   **Secure Storage** : Les tokens Supabase et infos sensibles ne sont JAMAIS stockés en `SharedPrefs` (clair), mais via `flutter_secure_storage` (Keychain/Keystore).
*   **Hachage des PINs** : Les codes PIN résidents sont hachés (SHA-256 + Salt) avant l'envoi. La comparaison se fait côté serveur ou via comparaison de hash, jamais en clair.
*   **Row Level Security (RLS)** : Activation stricte des polices RLS sur Supabase.
    *   *Life* : Ne peut lire que SA propre ligne `resident_status`.
    *   *Manager* : Droit lecture/écriture global (sécurisé par Auth Admin).

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

## 6. DESIGN SYSTEM & UX STRATEGY (L'EXPÉRIENCE PREMIUM)

### A. Philosophie Visuelle "Dual-Core"
*   **Manager (Thème : "Onyx & Gold")** :
    *   *Inspiration* : Tableaux de bord financiers (Bloomberg Terminal) x Luxe moderne.
    *   *Palette* : Fond `#121212` (Vrai Noir), Accent `#D4AF37` (Or Métallique), Alertes `#CF6679` (Rouge Doux).
    *   *Font* : `Lato` ou `Roboto` (Lisibilité data dense).
    *   *Composants* : Cartes à bords nets, ombres portées "Néon" subtiles, jauges de performance précises.
*   **Life (Thème : "Atlas Zen")** :
    *   *Inspiration* : Hôtellerie 5 étoiles, clarté, chaleur marocaine subtile (zellige vectoriel en background très léger).
    *   *Palette* : Fond `#FAFAFA` (Blanc cassé), Accent `#00695C` (Vert Émeraude/Habous), Texte `#37474F`.
    *   *Interaction* : Boutons "Pill", animations de transition (Hero), retours haptiques légers.

### B. Architecture UI
*   **Atomic Design** : Découpage strict en `Atoms` (Icônes, Typos), `Molecules` (Boutons, Champs), `Organisms` (Cartes Résident).
*   **Responsive** : Le Manager doit être utilisable sur Tablette (iPad Pro) et Desktop, pas seulement Mobile.

---

## 7. DOCTRINE DE ROBUSTESSE (ZERO-CRASH POLICY)

### A. Gestion des Erreurs (Le "Filet de Sécurité")
1.  **Global Error Boundary** : Implémentation d'un Widget `AppErrorBoundary` à la racine.
    *   *Comportement* : Intercepte toute exception de rendu. Affiche une UI de secours ("Une erreur est survenue, recharger le module") au lieu de l'écran gris/rouge natif.
2.  **Zoned Guard** : Capture des erreurs asynchrones (Dart) dans le `main.dart`.
    *   *Action* : Log l'erreur dans une table locale `error_logs` (Drift) pour diagnostic ultérieur, puis notifie l'utilisateur discrètement (SnackBar).
3.  **Typage Strict** : Interdiction du type `dynamic`. Utilisation de `freezed` pour les modèles de données (Union Types) afin de gérer tous les états possibles (Loading, Data, Error).

### B. Stratégie Offline-First (Continuité de Service)
*   **Manager** : Utilise `Drift` comme source de vérité immédiate (Pattern Repository).
    *   *Lecture* : L'UI affiche toujours les données locales (instantané).
    *   *Écriture* : L'action est persistée localement -> Ajoutée à une `SyncQueue` -> Envoyée à Supabase en background.
    *   *Conflits* : Stratégie "Last Write Wins" ou arbitrage manuel via UI dédiée si conflit critique (ex: solde financier).
*   **Life** : Cache local via `Hive` ou `SharedPreferences` pour que l'app s'ouvre même en sous-sol (pas de réseau) avec les dernières infos connues.

### C. Maintenance Long Terme
*   **Version Pinning** : Toutes les dépendances dans `pubspec.yaml` doivent être fixées sans `^` (caret) pour garantir que le build de 2026 soit identique à celui de 2030.
*   **Linter Sévère** : Activation de `very_good_analysis` ou `flutter_lints` au niveau maximal. 0 Warning toléré au build.

---
**Fin du rapport technique.**
