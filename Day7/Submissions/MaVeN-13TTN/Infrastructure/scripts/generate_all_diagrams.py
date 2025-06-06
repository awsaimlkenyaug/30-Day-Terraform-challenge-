#!/usr/bin/env python3
"""
Generate All Day 7 Infrastructure Diagrams
Generates both workspace isolation and file layout isolation architecture diagrams
"""

import sys
import os
from workspace_isolation_diagram import create_workspace_isolation_diagram
from file_layout_isolation_diagram import create_file_layout_isolation_diagram


def main():
    """Generate all Day 7 infrastructure diagrams"""

    print("🚀 Generating Day 7 Infrastructure Diagrams...")
    print("=" * 50)

    try:
        # Generate workspace isolation diagram
        print("📊 Creating workspace isolation diagram...")
        create_workspace_isolation_diagram()
        print("✅ Workspace isolation diagram created successfully!")

        # Generate file layout isolation diagram
        print("📊 Creating file layout isolation diagram...")
        create_file_layout_isolation_diagram()
        print("✅ File layout isolation diagram created successfully!")

        print("=" * 50)
        print("🎉 All diagrams generated successfully!")
        print("📁 Check the '../diagrams/' folder for the generated PNG files:")
        print("   - workspace_isolation_infrastructure.png")
        print("   - file_layout_isolation_infrastructure.png")

    except Exception as e:
        print(f"❌ Error generating diagrams: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
