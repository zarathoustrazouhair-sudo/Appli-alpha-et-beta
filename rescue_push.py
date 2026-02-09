import subprocess
import os
import shutil

# --- CONFIGURATION ---
REPO_URL = "https://[REDACTED]@github.com/zarathoustrazouhair-sudo/Appli-alpha-et-beta.git"
COMMIT_MESSAGE = "OPERATION SAUVETAGE: Migration Amandier V2.0 Complete"
TARGET_DIR = "operation_sauvetage"

def run_command(command):
    try:
        print(f"🔄 EXÉCUTION : {' '.join(command)}")
        result = subprocess.run(
            command, 
            capture_output=True, 
            text=True, 
            encoding='utf-8',
            errors='ignore'
        )
        if result.returncode == 0:
            print(f"✅ SUCCÈS : {result.stdout.strip()[:200]}...")
            return True
        else:
            print(f"❌ ERREUR : {result.stderr.strip()}")
            return False
    except Exception as e:
        print(f"💥 EXCEPTION : {e}")
        return False

def restructure_and_push():
    print(f"🚀 PRÉPARATION DU DOSSIER '{TARGET_DIR}'...")

    # 1. Create Target Directory
    if not os.path.exists(TARGET_DIR):
        os.makedirs(TARGET_DIR)

    # 2. Move Items (Avoid moving the target dir into itself or hidden files)
    items_to_move = [
        "SYNDIC PRO AMANDIER", 
        "README.md", 
        "supabase_schema_v2_final.sql", 
        "audit_orphans.py", 
        "RAPPORT_AUDIT_AMANDIER.md",
        "force_push_all.py",
        "upload.py"
    ]

    for item in items_to_move:
        if os.path.exists(item):
            print(f"📦 Déplacement de {item} vers {TARGET_DIR}...")
            shutil.move(item, os.path.join(TARGET_DIR, item))

    # 3. Git Operations
    print("🔧 Configuration Git...")
    if os.path.exists(".git"):
        shutil.rmtree(".git") # Start Fresh for this operation
    
    run_command(["git", "init"])
    run_command(["git", "remote", "add", "origin", REPO_URL])
    
    print("📦 Ajout des fichiers...")
    run_command(["git", "add", "."])
    
    print("📝 Commit...")
    run_command(["git", "commit", "-m", COMMIT_MESSAGE])
    
    print("☁️  PUSH VERS GITHUB...")
    success = run_command(["git", "push", "origin", "HEAD:main", "--force"])

    if success:
        print("\n✅ OPÉRATION SAUVETAGE RÉUSSIE !")
    else:
        print("\n❌ ÉCHEC DU SAUVETAGE.")

if __name__ == "__main__":
    restructure_and_push()
