import os
import subprocess
import shutil

# --- CONFIGURATION (TON NOUVEAU TOKEN) ---
# L'URL inclut le token pour forcer l'authentification
NEW_TOKEN = "[REDACTED]"
REPO_URL = f"https://{NEW_TOKEN}@github.com/zarathoustrazouhair-sudo/Appli-alpha-et-beta.git"

COMMIT_MSG = "PREUVE DE MIGRATION - TOKEN VALIDE - SAUVEGARDE FINALE"

def run_cmd(command):
    try:
        # On affiche la commande pour être sûr
        # print(f"🔄 Exécution : {' '.join(command)}") # REDACTED FOR SECURITY IN LOGS
        print(f"🔄 Exécution : {command[0]} ...")
        result = subprocess.run(
            command, 
            capture_output=True, 
            text=True,
            encoding='utf-8'
        )
        if result.returncode == 0:
            print("✅ Succès.")
            return True
        else:
            print(f"❌ Erreur : {result.stderr}")
            return False
    except Exception as e:
        print(f"💥 Exception : {e}")
        return False

def main():
    print("🚀 DÉMARRAGE DE LA MIGRATION AUTHENTIFIÉE...")

    # 1. NETTOYAGE PRÉALABLE (On vire les anciens réglages Git qui bloquent)
    if os.path.exists(".git"):
        print("🧹 Suppression de l'ancienne configuration Git (.git)...")
        # On utilise une commande système pour être sûr de tout supprimer (y compris les fichiers cachés)
        if os.name == 'nt': # Windows
             os.system('rmdir /S /Q .git')
        else: # Linux/Mac (Environnement Jules)
             os.system('rm -rf .git')

    # 2. INIT & CONFIG
    print("⚙️  Initialisation d'un dépôt propre...")
    run_cmd(["git", "init"])
    # On met un nom d'utilisateur générique pour la trace
    run_cmd(["git", "config", "user.email", "admin@amandier.com"])
    run_cmd(["git", "config", "user.name", "Admin Migration"])
    
    # 3. AJOUT DU REMOTE AVEC LE TOKEN DANS L'URL
    print("🔗 Connexion sécurisée au dépôt Appli-alpha-et-beta...")
    run_cmd(["git", "remote", "add", "origin", REPO_URL])

    # 4. PRÉPARATION DES FICHIERS
    print("📦 Ajout des fichiers (Cela peut prendre quelques secondes)...")
    
    # On s'assure d'ignorer les trucs lourds si .gitignore n'est pas là
    if not os.path.exists(".gitignore"):
        with open(".gitignore", "w") as f:
            f.write("build/\n.dart_tool/\n*.zip\n*.apk\n.gradle/")
            
    run_cmd(["git", "add", "."])
    
    # 5. COMMIT DE PREUVE
    print(f"📝 Création du commit : {COMMIT_MSG}")
    run_cmd(["git", "commit", "-m", COMMIT_MSG])

    # 6. ENVOI FINAL (FORCE)
    print("🚀 ENVOI VERS GITHUB (PUSH FORCE)...")
    # On force la branche main
    run_cmd(["git", "branch", "-M", "main"])
    
    success = run_cmd(["git", "push", "-u", "origin", "main", "--force"])

    if success:
        print("\n" + "="*50)
        print("✅ PREUVE ÉTABLIE !")
        print("   Le code a été envoyé avec le NOUVEAU token.")
        print(f"   Vérifie ici : https://github.com/zarathoustrazouhair-sudo/Appli-alpha-et-beta")
        print("="*50)
    else:
        print("\n❌ ÉCHEC. Vérifie le token ou la connexion.")

if __name__ == "__main__":
    main()
