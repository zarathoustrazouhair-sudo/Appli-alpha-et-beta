import os
import shutil
import datetime
import subprocess
import sys

# CONFIGURATION
VERSION = "3.0.0"
TOKEN = "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"
GITHUB_REPO = "github.com/zarathoustrazouhair-sudo/Appli-alpha-et-beta.git"
REMOTE_URL = f"https://{TOKEN}@{GITHUB_REPO}"

def run_command(command, cwd=None, check=True):
    print(f"🔄 Executing: {command}")
    try:
        subprocess.run(command, shell=True, check=check, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"❌ Error executing command: {command}")
        sys.exit(1)

def main():
    # 1. SETUP WORKING DIRECTORY
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = script_dir

    # Verify we are in the correct directory (Manger_Life or similar)
    if not os.path.exists(os.path.join(project_root, "pubspec.yaml")):
        print(f"❌ Error: pubspec.yaml not found in {project_root}. Please run this script from the project root.")
        sys.exit(1)

    print(f"📂 Working Directory: {project_root}")
    os.chdir(project_root)

    # 2. PREPARE BUILD
    print("\n🧹 Cleaning and fetching dependencies...")
    run_command("flutter clean")
    run_command("flutter pub get")

    # Ensure output directory exists
    apk_release_dir = os.path.join(project_root, "APK_RELEASES")
    if not os.path.exists(apk_release_dir):
        os.makedirs(apk_release_dir)
        print(f"📂 Created directory: {apk_release_dir}")

    # Generate timestamp once for both builds
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M")

    # 3. BUILD MANAGER
    print("\n🔨 Building MANAGER APK...")
    run_command("flutter build apk --release -t lib/main.dart")

    source_apk = os.path.join(project_root, "build", "app", "outputs", "flutter-apk", "app-release.apk")
    manager_apk_name = f"Amandier_Manager_v{VERSION}_{timestamp}.apk"
    manager_dest = os.path.join(apk_release_dir, manager_apk_name)

    if os.path.exists(source_apk):
        shutil.move(source_apk, manager_dest)
        print(f"✅ Manager APK moved to: {manager_dest}")
    else:
        print("❌ Error: Manager APK build failed (file not found).")
        sys.exit(1)

    # 4. BUILD LIFE (RESIDENT)
    print("\n🔨 Building LIFE (RESIDENT) APK...")
    # Note: flutter build overwrites app-release.apk, so we must have moved the first one.
    run_command("flutter build apk --release -t lib/main_resident.dart")

    # Source is recreated at the same path
    life_apk_name = f"Amandier_Life_v{VERSION}_{timestamp}.apk"
    life_dest = os.path.join(apk_release_dir, life_apk_name)

    if os.path.exists(source_apk):
        shutil.move(source_apk, life_dest)
        print(f"✅ Life APK moved to: {life_dest}")
    else:
        print("❌ Error: Life APK build failed (file not found).")
        sys.exit(1)

    # 5. GIT DEPLOYMENT
    print("\n🚀 Starting Git Deployment...")

    # Configure remote if needed (optional since environment usually has it, but good practice for CI)
    # checking current remote
    try:
        run_command(f"git remote set-url origin {REMOTE_URL}", check=False)
    except:
        pass # Ignore if it fails, fallback to existing configuration

    run_command("git add APK_RELEASES/")

    commit_msg = f"🚀 DUAL-DEPLOY: Manager & Life v{VERSION} [{timestamp}]"
    run_command(f"git commit -m \"{commit_msg}\"")

    print("Pushing to remote...")
    run_command("git push origin HEAD") # Push current branch

    print("\n✅✅ DEPLOYMENT COMPLETE! Both APKs are on GitHub.")

if __name__ == "__main__":
    main()
