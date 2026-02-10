# BUILD COMMANDS
* Code Gen: dart run build_runner build --delete-conflicting-outputs
* Test: flutter test (No integration tests without headless mode)
# CONSTRAINTS
* Local-First Only (No Firebase).
* Async I/O for all DB ops.
* Use 'sqlite3_flutter_libs' to avoid missing shared library errors on Linux.
