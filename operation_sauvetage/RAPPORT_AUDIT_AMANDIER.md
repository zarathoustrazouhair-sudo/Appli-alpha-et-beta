# RAPPORT D'AUDIT QUALITÉ - AMANDIER SUITE V2.0
**Date:** 09 Février 2026
**Auditeur:** Jules (AI Architect)
**Projet:** Syndic Pro Amandier (Manager & Life)

---

## 1. TESTS 'ÉTAT DE L'ART' (HEADLESS)

### Résultat de l'exécution
- **Tests exécutés :** 2 tests passés avec succès.
- **Rapport de Couverture :** 
  - `AboutScreen` : Couverture UI de base.
  - `WhatsappLogic` : Couverture logique de base.

### 🔴 CRITICAL DEBT (Dette Critique)
Les zones critiques suivantes ne disposent **AUCUN TEST** automatisé :
1. **Transactions Financières** (`lib/features/transactions`) : Calcul des soldes, création de reçus, validation des montants.
2. **Login Résident** (`lib/features/resident_app/presentation/login`) : Sécurité d'accès, vérification PIN, lien Supabase.
3. **Incidents** (`lib/features/incidents`) : Logique de signalement, filtrage urgent/anonyme.

**Recommandation Immédiate :** Créer des tests unitaires pour `TransactionRepository` et des tests de widget pour `ResidentLoginScreen` avant toute nouvelle fonctionnalité.

---

## 2. CARTOGRAPHIE ARCHITECTURE

### Structure Globale
L'architecture suit une séparation claire par "Features" (Fonctionnalités) avec des modules partagés (Core, Data).

```
SYNDIC PRO AMANDIER/lib
├── main.dart                  <-- POINT D'ENTRÉE (AMANDIER MANAGER)
├── main_resident.dart         <-- POINT D'ENTRÉE (AMANDIER LIFE)
├── core/                      <-- [SHARED LOGIC] Utilitaires, Thèmes, Services (PDF, WhatsApp)
├── data/                      <-- [SHARED LOGIC] Base de données Drift, Repositories génériques
│   └── database/              <-- Schéma SQLite unifié
├── domain/                    <-- [SHARED LOGIC] Entités métiers (Resident, Payment, etc.)
└── features/                  <-- Modules Fonctionnels
    ├── ag/                    <-- Gestion Assemblées Générales
    ├── dashboard/             <-- Tableau de Bord Admin (Cockpit)
    ├── expenses/              <-- Dépenses
    ├── incidents/             <-- Gestion des Incidents (Siren)
    ├── legal/                 <-- Génération Documents Légaux
    ├── management/            <-- Onglets de Gestion
    ├── navigation/            <-- Scaffold Principal Admin
    ├── providers/             <-- Prestataires
    ├── resident_app/          <-- [SPECIFIC] Module Résident (Dashboard, Login)
    ├── residents/             <-- Gestion des Résidents
    ├── settings/              <-- Paramètres & Config
    ├── sync/                  <-- Synchronisation Cloud
    ├── tasks/                 <-- Copilote / Tâches
    └── transactions/          <-- Historique Financier
```

---

## 3. CHASSE AUX ORPHELINS (DEAD CODE)

L'analyse statique a identifié plusieurs fichiers sources qui ne semblent pas importés par les points d'entrée ou leurs dépendances directes.

### 🟠 Composants Oubliés (Risque Modéré)
Ces écrans existent mais ne sont peut-être pas accessibles via la navigation principale :
- `lib/features/providers/presentation/provider_list_screen.dart`
- `lib/features/expenses/presentation/expenses_screen.dart`
- `lib/features/settings/presentation/settings_screen.dart` (Le bouton Settings existe-t-il ?)

### 🟡 Logique Obsolète Potentielle
- `lib/core/services/pdf_service.dart` : Semble être une ancienne version remplacée par `EcoPdfService.dart` (qui est massivement utilisé).
- `lib/features/dashboard/presentation/global_report_controller.dart` : Possiblement non branché.
- `lib/features/sync/data/sync_service.dart` : Vérifier si le service de sync est bien instancié dans `main.dart`.

### 🟢 Fichiers de Test Isolés
- Aucun test abandonné détecté (seulement 2 tests actifs).

---

## 4. AUDIT DES PDF (TRACABILITÉ UI -> BACKEND)

Le moteur principal de génération PDF est **`EcoPdfService`**.

| Document PDF (Nom) | App (Manager/Life) | Fichier Service (Code) | Écran UI (Déclencheur) | Label du Bouton |
|--------------------|--------------------|------------------------|------------------------|-----------------|
| **Journal Caisse** | Manager | `EcoPdfService.dart` | `GlobalReportController` | *(Via GlobalSituationScreen)* 'IMPRIMER ÉTAT' |
| **Convocation AG** | Manager | `EcoPdfService.dart` | `ConvocationDialog` | 'Générer Convocation' |
| **Contrat Travail** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Générer Contrat' |
| **Bulletin Paie** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Bulletin de Paie' |
| **Décharge Logement** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Décharge Logement' |
| **Pouvoir AG** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Pouvoir' |
| **Mise En Demeure** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Mise en Demeure' |
| **Consentement Digital** | Manager | `EcoPdfService.dart` | `LegalDocsScreen` | 'Consentement' |
| **Reçu Paiement** | Manager | `EcoPdfService.dart` | `TransactionEntryScreen` (implied) | 'Valider & Imprimer' (via logique interne) |
| **Bon de Commande** | Manager | `EcoPdfService.dart` | *(Non détecté en UI explicite)* | *N/A* |

**Observation :** `EcoPdfService` centralise toute la logique "Loi 18-00", ce qui est une excellente pratique (Single Source of Truth pour le formatage légal).

---

## CONCLUSION
L'architecture est saine et bien modulaire. Le principal risque réside dans la **couverture de tests quasi-inexistante** sur les modules critiques (Finance/Login). L'application Manager conserve bien son autonomie locale (Drift/EcoPdfService), respectant la règle "Local-First".
