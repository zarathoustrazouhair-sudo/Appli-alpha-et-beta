import subprocess
import os
import sys

# --- CONFIGURATION ---
# Ton Token et URL exacte (basés sur tes instructions précédentes)
REPO_URL = "https://[REDACTED]@github.com/zarathoustrazouhair-sudo/Jules.git"
COMMIT_MESSAGE = "SAUVEGARDE TOTALE - PRÊT POUR APK FINAL (Manager + Life)"

def run_command(command):
    """Exécute une commande shell et affiche le résultat en temps réel."""
    try:
        # On affiche la commande pour le debug
        print(f"🔄 EXÉCUTION : {' '.join(command)}")
        
        result = subprocess.run(
            command, 
            capture_output=True, 
            text=True, 
            encoding='utf-8',
            errors='ignore' # Évite les crashs sur des caractères bizarres
        )
        
        if result.returncode == 0:
            print(f"✅ SUCCÈS : {result.stdout.strip()[:200]}...") # Affiche le début de la sortie
            return True
        else:
            print(f"❌ ERREUR : {result.stderr.strip()}")
            return False
    except Exception as e:
        print(f"💥 EXCEPTION : {e}")
        return False

def force_push_all():
    print("🚀 DÉMARRAGE DE LA SAUVEGARDE INTÉGRALE DU PROJET...")
    
    # 1. Initialisation Git si nécessaire
    if not os.path.exists(".git"):
        print("Ply : Initialisation du dépôt Git...")
        run_command(["git", "init"])
    else:
        print("ℹ️  Dépôt Git détecté.")

    # 2. Configuration du Remote (Cible)
    print("🔗 Configuration de l'URL distante...")
    run_command(["git", "remote", "remove", "target"]) # On nettoie au cas où
    if not run_command(["git", "remote", "add", "target", REPO_URL]):
        print("⚠️  Impossible d'ajouter le remote. Vérifie ta connexion.")
        return

    # 3. Ajout de TOUS les fichiers (Le plus important)
    print("📦 Ajout de tous les fichiers (V1, V2, Assets)...")
    # 'git add .' prend tout le dossier courant
    run_command(["git", "add", "."])

    # 4. Commit (Enregistrement local)
    print("📝 Création du commit de sauvegarde...")
    run_command(["git", "commit", "-m", COMMIT_MESSAGE])

    # 5. Envoi vers GitHub (Force Push)
    print("☁️  ENVOI VERS GITHUB (Cela peut prendre un moment)...")
    success = run_command(["git", "push", "target", "HEAD:main", "--force"])

    if success:
        print("\n" + "="*50)
        print("✅  SAUVEGARDE TERMINÉE AVEC SUCCÈS !")
        print("    Toute l'application est sécurisée sur GitHub.")
        print("    Tu peux maintenant lancer la génération de l'APK.")
        print("="*50)
    else:
        print("\n❌ ÉCHEC DE L'ENVOI. Vérifie ta connexion internet ou le Token.")

if __name__ == "__main__":
    force_push_all()
