#!/usr/bin/env python3
"""
Master Architecture Diagram Generator
Day 4 - Advanced Terraform Features
Generates all diagrams for both infrastructures
"""

import os
import subprocess
import sys


def run_script(script_name):
    """Run a Python script and return success status"""
    try:
        result = subprocess.run(
            [sys.executable, script_name], capture_output=True, text=True, check=True
        )
        print(result.stdout)
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Error running {script_name}:")
        print(e.stdout)
        print(e.stderr)
        return False


def main():
    """Generate all architecture diagrams"""
    print("🎨 Master Architecture Diagram Generator")
    print("=" * 50)
    print("Day 4 - Advanced Terraform Features")
    print("Generating diagrams for both infrastructures...")
    print()

    success_count = 0
    total_scripts = 2

    # Run configurable web server diagrams
    print("🔧 Generating Configurable Web Server Diagrams...")
    if run_script("generate_configurable_diagram.py"):
        success_count += 1

    print()

    # Run clustered web server diagrams
    print("⚡ Generating Clustered Web Server Diagrams...")
    if run_script("generate_clustered_diagram.py"):
        success_count += 1

    print()
    print("=" * 50)

    if success_count == total_scripts:
        print("🎉 All diagrams generated successfully!")
        print(f"✅ {success_count}/{total_scripts} scripts completed")

        # List all generated diagrams
        if os.path.exists("diagrams"):
            diagrams = [f for f in os.listdir("diagrams") if f.endswith(".png")]
            print(f"\n📊 Generated {len(diagrams)} diagrams:")
            for diagram in sorted(diagrams):
                print(f"  - {diagram}")

        print("\n📁 All diagrams saved in: ./diagrams/")
        return True
    else:
        print(f"⚠️  Some scripts failed: {success_count}/{total_scripts} completed")
        return False


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
