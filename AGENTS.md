# AMANDIER MANAGER - PROTOCOLE MAÎTRE (ANDROID PRODUCTION)

## 1. IDENTITÉ & ARCHITECTURE
- **Rôle :** Senior Flutter Engineer spécialisé en architecture Mobile Offline-First.
- **Cible :** Android Natif (Min SDK 21).
- **Priorité Absolue :** Stabilité, Gestion Mémoire, et Persistance des Données.
- **Pattern :** MVVM avec `Riverpod` (State Management) et `Drift` (SQLite ORM).

## 2. CONTRAINTES TECHNIQUES (CRITIQUES)
- **Responsive UI :** NE JAMAIS utiliser de hauteurs fixes en pixels (ex: `height: 50`). Utiliser `Flex`, `Expanded`, ou `MediaQuery` pour s'adapter à toutes les tailles d'écran Android.
- **Gestion Mémoire :**
  - Pour toute liste de plus de 10 éléments, utiliser OBLIGATOIREMENT `ListView.builder`.
  - Disposer correctement les contrôleurs (`TextEditingController`, `Streams`) dans la méthode `dispose()`.
- **Permissions Android :**
  - Gérer `manage_external_storage` ou `WRITE_EXTERNAL_STORAGE` selon la version Android.
  - Utiliser le package `permission_handler` de manière défensive (Vérifier -> Demander -> Agir).

## 3. WORKFLOW PDF & FICHIERS
- **Moteur :** Utiliser les packages `pdf` (création) et `printing` (visualisation/impression).
- **Logique "Dossier Racine" :**
  - Au démarrage (Splash Screen), vérifier si un `default_save_path` existe dans `SharedPreferences`.
  - Si NON -> Ouvrir une modale bloquante forçant l'utilisateur à choisir un dossier via `file_picker`.
  - Sauvegarder ce chemin.
- **Choix Final :** Après génération, proposer systématiquement : "Enregistrer dans [Dossier]" OU "Imprimer/Partager".

## 4. COMMANDES DE BUILD & TEST (HEADLESS)
- **Installation :** `flutter pub get`
- **Build Android :** `flutter build apk --release`
- **Tests :** `flutter test` (Ne JAMAIS lancer d'émulateur. Vérifier la logique BDD et PDF via tests unitaires).

## 5. CONTRAINTES NÉGATIVES (LIGNES ROUGES)
- NE JAMAIS coder en dur les chaînes de caractères (Préparer l'i18n).
- NE JAMAIS bloquer le "Main Thread" avec la génération PDF (Utiliser `compute` ou `Isolate` si le PDF est gros).
- NE JAMAIS stocker le Logo en Base64 dans la BDD. Stocker le chemin du fichier (Path) uniquement.
