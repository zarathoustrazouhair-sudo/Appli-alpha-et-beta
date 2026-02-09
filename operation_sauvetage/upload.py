import subprocess
import os

def run_command(command):
    try:
        result = subprocess.run(command, capture_output=True, text=True)
        print(f"CMD: {' '.join(command)}")
        print("STDOUT:", result.stdout)
        if result.stderr:
            print("STDERR:", result.stderr)
        return result.returncode
    except Exception as e:
        print(f"Error running {command}: {e}")
        return -1

def force_push():
    # URL fournie par le client (Token inclus)
    remote_url = "https://[REDACTED]@github.com/zarathoustrazouhair-sudo/Jules.git"
    
    # Check if .git exists, if not init
    if not os.path.exists(".git"):
         run_command(["git", "init"])

    # Setup remote
    run_command(["git", "remote", "remove", "target"])
    run_command(["git", "remote", "add", "target", remote_url])

    # Add specific files for V3
    run_command(["git", "add", "version_test_v3.zip"])
    run_command(["git", "add", "RAPPORT_AUDIT_AMANDIER.md"])
    run_command(["git", "add", "audit_orphans.py"])
    run_command(["git", "add", "SYNDIC PRO AMANDIER/"]) # Add source code too

    # Commit
    run_command(["git", "commit", "-m", "AUDIT & ORPHAN FIX: V3 Delivery"])

    # Push to main
    print("Pushing to main...")
    run_command(["git", "push", "target", "HEAD:main", "--force"])

if __name__ == "__main__":
    force_push()
