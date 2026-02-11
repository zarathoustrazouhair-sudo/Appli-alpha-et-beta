# 🛡️ Rapport d'Audit Infrastructure & Architecture

## 1. État de Santé (Score: 85/100)

### ✅ Points Forts
*   **Infrastructure Native (Android)** : La migration vers le *Version Catalog* (`libs.versions.toml`) est un succès. Le build est modernisé, robuste et prêt pour la maintenance à long terme (LTS).
*   **Sécurité** : La gestion des secrets via `flutter_dotenv` est opérationnelle. Aucune clé critique n'est exposée dans le code source.
*   **Gouvernance** : Le fichier `AGENTS.md` définit clairement les règles du jeu (MVI, Clean Arch, Riverpod Generator). C'est un atout majeur pour éviter la dette technique.

### ⚠️ Points de Vigilance
*   **Structure Hybride (Confusion)** : Le projet souffre d'une hésitation entre une approche "Layer-First" (tout dans `lib/domain/`) et "Feature-First" (chaque feature a son `domain/`).
    *   Exemple : `ResidentRepository` est dans `lib/domain/repositories/` (centralisé), alors que `IncidentRepository` est dans `lib/features/incidents/data/` (décentralisé).
*   **Services "Fourre-tout"** : La présence de `EcoPdfService` dans `lib/core/services/` suggère une logique métier potentiellement couplée à l'infrastructure, ce qui viole la Clean Architecture stricte.

---

## 2. Analyse de Conformité (AGENTS.md)

| Critère | Statut | Analyse |
| :--- | :--- | :--- |
| **Monorepo Logique** | 🟢 Valide | Les deux points d'entrée (`main.dart`, `main_resident.dart`) partagent correctement le code. |
| **Clean Architecture** | 🟠 Partiel | La séparation UI/Domain/Data est respectée globalement, mais l'emplacement des fichiers manque de cohérence (voir point "Structure Hybride"). |
| **State Management** | 🟢 Valide | L'utilisation de `Riverpod` et `Riverpod Generator` semble généralisée. |
| **Dependency Injection** | 🟢 Valide | Riverpod gère l'injection, aucun service locator "sale" détecté. |

**Manquements identifiés :**
*   Absence d'un dossier `lib/features/shared/` ou `lib/core/usecases/` pour la logique métier transversale explicite.
*   Incohérence dans le nommage des fichiers Repository (parfois dans `data`, parfois dans `domain`).

---

## 3. Risques Identifiés

### 🔴 Risque Critique : "Spaghetti Architecture" à moyen terme
Si l'équipe ne tranche pas immédiatement entre "Centralized Domain" et "Colocated Domain", les développeurs ne sauront plus où placer leurs fichiers. Cela mènera à des duplications et des cycles de dépendances.

### 🟠 Risque Modéré : Maintenance des Services
Le service `EcoPdfService` risque de devenir une "God Class" ingérable s'il mélange la génération UI (widgets pdf) et le calcul des données (Business Logic). Il doit être découpé.

### 🟢 Risque Faible : Build Android
La configuration est saine. Le seul risque est d'oublier de mettre à jour le `libs.versions.toml`.

---

## 4. Recommandations Stratégiques (Roadmap)

### 🚀 Phase 1 : Consolidation (Immédiat - Avant Features)
1.  **Standardiser la Structure** : Adopter strictement le modèle "Feature-First" complet.
    *   Déplacer `lib/domain/repositories/resident_repository.dart` -> `lib/features/residents/domain/repositories/`.
    *   Déplacer `lib/domain/entities/resident.dart` -> `lib/features/residents/domain/entities/`.
    *   Supprimer les dossiers `lib/domain` et `lib/data` racines s'ils ne contiennent que des éléments spécifiques aux features. Garder `lib/core` pour le vraiment partagé.
2.  **Refactorer EcoPdfService** : Séparer la logique de calcul (UseCase) de la génération de PDF (Infrastructure/Service).

### 🛠️ Phase 2 : Développement Features (Ordre Prioritaire)
1.  **Module Résidents (Source de Vérité)** : Finaliser le CRUD complet et la synchro Supabase/Drift.
2.  **Module Comptabilité (Cœur du Système)** : Implémenter la logique de calcul (Soldes, Dettes) dans des UseCases purs, testés à 100%.
3.  **Module PDF (Sortie)** : Brancher le générateur de PDF uniquement sur les données validées par le module Comptabilité.

### ✅ Décision Finale
**GO pour le développement**, SOUS RÉSERVE de la normalisation immédiate de la structure des dossiers (Action Phase 1). L'infrastructure est solide, mais l'architecture logicielle demande un dernier tour de vis.
