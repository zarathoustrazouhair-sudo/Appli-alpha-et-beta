import os
import re

def get_dart_files(root_dir):
    dart_files = []
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

def get_imports(file_path):
    imports = set()
    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
        # Matches: import 'package:...' or import 'relative/path.dart'
        matches = re.findall(r"import\s+['\"]([^'\"]+)['\"]", content)
        for m in matches:
             # Normalize package imports to relative paths if possible (simplified)
             # or just store the filename for basic matching
             if m.startswith('package:syndic_pro/'):
                 m = m.replace('package:syndic_pro/', 'lib/')
             imports.add(m)
    return imports

def analyze_orphans(project_root):
    lib_dir = os.path.join(project_root, 'lib')
    all_files = get_dart_files(lib_dir)
    
    # Map file paths to their simple names or relative paths for matching
    # Ideally we resolve imports properly, but for a quick audit:
    # 1. Collect all import statements from all files.
    # 2. Check if a file is ever imported.
    
    all_imports = set()
    for f in all_files:
        if f.endswith('.g.dart') or f.endswith('.freezed.dart'): continue
        
        file_imports = get_imports(f)
        for imp in file_imports:
            # Resolving relative imports is complex without full context, 
            # but we can try to match filenames.
            all_imports.add(os.path.basename(imp))

    orphans = []
    entry_points = ['main.dart', 'main_resident.dart', 'firebase_options.dart']

    for f in all_files:
        filename = os.path.basename(f)
        if filename in entry_points: continue
        if filename.endswith('.g.dart') or filename.endswith('.freezed.dart'): continue
        
        # If filename is NOT in any import statement (simplified check)
        if filename not in all_imports:
            orphans.append(f)

    print("POTENTIAL ORPHANS (No file imports this filename):")
    for o in orphans:
        print(o)

if __name__ == "__main__":
    analyze_orphans("SYNDIC PRO AMANDIER")
