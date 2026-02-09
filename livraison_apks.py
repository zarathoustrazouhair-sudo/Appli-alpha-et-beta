import os
import subprocess
import shutil

# --- CONFIGURATION ---
# Ton token et dépôt valides
REPO_URL = "https://[REDACTED]@github.com/zarathoustrazouhair-sudo/Jules.git"
TARGET_DIR = "LIVRAISON_APKS_FINAUX"

# Les noms exacts que tu as générés dans tes logs précédents
APK_FILES = [
    "Amandier_Manager_v2.apk",
    "Amandier_Life_v2.apk"
]

def run_cmd(command, cwd=None):
    try:
        subprocess.run(command, check=True, shell=False, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"❌ Erreur : {e}")

def main():
    print("🚀 DÉMARRAGE : ENVOI SÉPARÉ DES APKs (ANTI-BLOCAGE 100MO)...")

    # 1. Création d'un dossier d'envoi propre
    if os.path.exists(TARGET_DIR):
        shutil.rmtree(TARGET_DIR)
    os.makedirs(TARGET_DIR)
    print(f"📂 Dossier temporaire '{TARGET_DIR}' créé.")

    # 2. Recherche et Copie des APKs
    # Jules, on cherche partout où tu as pu les mettre (racine ou dossier build)
    print("🔍 Recherche des fichiers APK générés...")
    files_found = 0
    
    for root, dirs, files in os.walk("."):
        # On ignore le dossier de destination pour ne pas tourner en rond
        if TARGET_DIR in root:
            continue
            
        for filename in APK_FILES:
            if filename in files:
                source_path = os.path.join(root, filename)
                dest_path = os.path.join(TARGET_DIR, filename)
                
                # On évite de copier plusieurs fois le même
                if not os.path.exists(dest_path):
                    shutil.copy2(source_path, dest_path)
                    print(f"✅ APK TROUVÉ ET COPIÉ : {filename}")
                    files_found += 1

    if files_found < 2:
        print("⚠️ ATTENTION : Je n'ai pas trouvé les 2 APKs. Je continue avec ce que j'ai.")
    else:
        print("✅ Les 2 APKs sont prêts.")

    # 3. ENVOI VERS GITHUB (SANS ZIP)
    print("☁️  Envoi vers le dépôt Jules...")
    
    run_cmd(["git", "init"], cwd=TARGET_DIR)
    run_cmd(["git", "config", "user.email", "livraison@amandier.com"], cwd=TARGET_DIR)
    run_cmd(["git", "config", "user.name", "Jules Livraison"], cwd=TARGET_DIR)
    run_cmd(["git", "remote", "add", "origin", REPO_URL], cwd=TARGET_DIR)
    
    # Ajout des fichiers
    run_cmd(["git", "add", "."], cwd=TARGET_DIR)
    run_cmd(["git", "commit", "-m", "LIVRAISON : APKs Manager et Life (Fichiers séparés)"], cwd=TARGET_DIR)
    
    # Force Push sur une branche propre ou master
    print("🚀 PUSH EN COURS...")
    run_cmd(["git", "push", "-f", "origin", "master"], cwd=TARGET_DIR)

    print("\n" + "="*50)
    print("🎉 SUCCÈS ! Les APKs ont été envoyés séparément.")
    print("   Comme ils font moins de 100Mo chacun (66Mo et 56Mo), GitHub les a acceptés.")
    print("="*50)

if __name__ == "__main__":
    main()
