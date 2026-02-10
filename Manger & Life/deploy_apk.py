import os
import shutil
import datetime
import subprocess
import sys

def run_command(command, cwd=None):
    try:
        subprocess.check_call(command, shell=True, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {command}")
        sys.exit(1)

def deploy_apk():
    # Configuration
    project_root = os.getcwd()
    apk_source_dir = os.path.join(project_root, "build", "app", "outputs", "flutter-apk")
    apk_release_dir = os.path.join(project_root, "APK_RELEASES")

    # Ensure source APK exists (Prioritize Release, fallback to Debug for testing)
    apk_release_path = os.path.join(apk_source_dir, "app-release.apk")
    apk_debug_path = os.path.join(apk_source_dir, "app-debug.apk")

    source_apk = None
    if os.path.exists(apk_release_path):
        source_apk = apk_release_path
        mode = "Release"
    elif os.path.exists(apk_debug_path):
        source_apk = apk_debug_path
        mode = "Debug"
    else:
        print("❌ No APK found in build directory. Run 'flutter build apk' first.")
        sys.exit(1)

    print(f"✅ Found {mode} APK: {source_apk}")

    # Create destination directory
    if not os.path.exists(apk_release_dir):
        os.makedirs(apk_release_dir)
        print(f"📂 Created directory: {apk_release_dir}")

    # Generate Versioned Filename
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M")
    # For a real CI system, we would parse pubspec.yaml for version.
    # For now, we hardcode v1.0 or extract if possible, but keep it simple as requested.
    version = "v1.0"
    new_filename = f"Amandier_Manager_{version}_{timestamp}_{mode}.apk"
    destination_path = os.path.join(apk_release_dir, new_filename)

    # Move/Copy File
    shutil.copy(source_apk, destination_path)
    print(f"🚀 Deployed APK to: {destination_path}")

    # Git Automation
    print("🔄 Starting Git Sync...")
    try:
        run_command("git pull --rebase")
        run_command(f"git add \"{apk_release_dir}\"")
        run_command(f"git commit -m \"🚀 AUTO-DEPLOY: New APK Generated [{timestamp}]\"")
        run_command("git push")
        print("✅ Successfully pushed to remote repository.")
    except Exception as e:
        print(f"⚠️ Git automation failed: {e}")
        print("Please push manually.")

if __name__ == "__main__":
    deploy_apk()
