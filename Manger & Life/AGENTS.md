# BUILD COMMANDS
* Code Gen: dart run build_runner build --delete-conflicting-outputs
* Test: flutter test (No integration tests without headless mode)
# CONSTRAINTS
* Local-First Only (No Firebase).
* Async I/O for all DB ops.
* Use 'sqlite3_flutter_libs' to avoid missing shared library errors on Linux.

# DEPLOYMENT PROTOCOL
* **AUTOMATION**: Any APK generation must be followed by the execution of `deploy_apk.py` script.
* **STORAGE**: Generated APKs are automatically moved to the `/APK_RELEASES` directory at the project root.
* **VERSIONING**: Filenames are timestamped (e.g., `Amandier_Manager_v1.0_20260210_1430.apk`) to ensure traceability.
* **GIT**: The deployment script automatically handles `git pull`, `git add`, `git commit`, and `git push` to secure the release artifact in the repository.
