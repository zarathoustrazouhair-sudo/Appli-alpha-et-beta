# AGENTS.md - La Constitution Technique

> **WARNING**: Ce fichier est la mémoire persistante et la constitution du projet.
> NE PAS modifier ce fichier sans instruction explicite "Mise à jour Gouvernance".

## @Role
Tu agis en tant qu'**Expert Flutter Senior** spécialisé en **Clean Architecture** et **Domain-Driven Design**.
Ta priorité absolue est la maintenabilité, la testabilité et la séparation des responsabilités.

## @ProjectContext (Monorepo Logique)
Ce dépôt est un **Monorepo Logique** unique. Il contient un SEUL projet Flutter (`pubspec.yaml`) mais **DEUX applications distinctes** partageant le même code métier (`lib/`) :
1.  **Amandier Manager** (`lib/main.dart`) : Application de gestion pour le Syndic (Onyx & Gold).
2.  **Amandier Life** (`lib/main_resident.dart`) : Application pour les Résidents (Atlas Zen).

> **Important** : Ne jamais confondre les contextes. Le code partagé vit dans `lib/core/`, `lib/features/`, `lib/domain/`.

## @TechStack
*   **Langage** : Dart 3.x (Flutter >= 3.0.0)
*   **State Management** : `riverpod_generator` (v2.4+) UNIQUEMENT. Pas de `ChangeNotifier`, `GetX`, ou `Bloc`.
*   **Backend** : Supabase (Auth, Realtime, Storage).
*   **Local Database** : Drift (SQLite) pour le mode Offline-First.
*   **PDF** : `pdf` & `printing` packages.
*   **Utils** : `fpdart` (Functional Programming), `freezed` (Immutability), `flutter_dotenv` (Secrets).

## @Architecture (Clean Architecture + MVI)
L'application suit strictement la Clean Architecture avec un flux unidirectionnel (MVI) et une structure de dossiers **"Feature-First"**.

### Règle d'Or : Tout code métier appartient à une feature nommée.
*   **Structure Obligatoire** :
    *   `lib/features/<nom>/domain/` : Entités, UseCases, Interfaces Repository. (Pur Dart, zéro dépendance Flutter/Drift idéalement).
    *   `lib/features/<nom>/data/` : Implémentations Repository, DataSources, DTOs.
    *   `lib/features/<nom>/presentation/` : Widgets, Controllers (Riverpod).

### Couches
1.  **Presentation (UI)** :
    *   **Widgets** : "Dumb Components". Ils ne font qu'afficher des données et émettre des événements. AUCUNE logique métier.
    *   **ViewModels** : Classes annotées `@riverpod`. Utilisent `AsyncNotifier` pour exposer un état immuable (`AsyncValue<State>`).
2.  **Domain (Business Logic)** :
    *   **Entities** : Objets purs (`@freezed`).
    *   **UseCases** : Fonctions pures encapsulant la logique métier. Retournent `Either<Failure, Success>` (via `fpdart` ou équivalent).
    *   **Repositories (Interface)** : Contrats abstraits définissant l'accès aux données.
3.  **Data (Infrastructure)** :
    *   **Repositories (Implementation)** : Implémentent les interfaces du Domain. Gèrent l'arbitrage entre le Cloud (Supabase) et le Local (Drift).
    *   **Data Sources** : Accès direct aux APIs ou DB.

## @Style & Conventions
*   **Fichiers** : `snake_case.dart` (ex: `auth_repository.dart`).
*   **Classes** : `PascalCase` (ex: `AuthRepository`).
*   **Dossiers** : Structure "Feature-First" stricte.
    *   `lib/features/auth/`
    *   `lib/features/dashboard/`
    *   `lib/core/` (Theme, Utils, Constants partagés par >1 feature)
    *   ⛔️ **INTERDIT** : Créer des dossiers `domain` ou `data` à la racine de `lib/` (sauf pour la DB globale existante).
*   **Riverpod Example** ("Show, Don't Tell") :
    ```dart
    @riverpod
    class UserProfile extends _$UserProfile {
      @override
      FutureOr<UserEntity> build() async {
        return _fetchUser();
      }

      Future<void> updateName(String newName) async {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() async {
          await ref.read(userRepositoryProvider).updateName(newName);
          return _fetchUser();
        });
      }
    }
    ```

## @Workflows
1.  **TDD (Test-Driven Development)** :
    *   Écrire le test (rouge) -> Écrire le code (vert) -> Refactoriser.
    *   Prioriser les tests unitaires sur le Domain et les Repositories.
2.  **Dépendances** :
    *   Toujours exécuter `flutter pub get` après avoir modifié `pubspec.yaml`.
    *   Toujours exécuter `dart run build_runner build --delete-conflicting-outputs` après avoir modifié des modèles annotés.

## @Forbidden (Interdits)
1.  **NE PAS** utiliser `GetX`, `Provider` classique, ou `setState` pour la logique métier complexe.
2.  **NE PAS** mettre de clés API (Supabase, etc.) en dur dans le code. Utiliser `.env` et `flutter_dotenv`.
3.  **NE PAS** créer de logique métier dans les Widgets UI (pas de calculs, pas d'appels API directs).
4.  **NE PAS** modifier ce fichier `AGENTS.md` sans instruction explicite.
