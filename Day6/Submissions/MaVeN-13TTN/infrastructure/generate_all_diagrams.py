#!/usr/bin/env python3
"""
Master diagram generator for Day 6 Terraform State Challenge
Generates all infrastructure diagrams based on the Terraform configurations
"""

import os
import sys
from pathlib import Path

# Import all diagram modules
from basic_infrastructure_diagram import create_basic_infrastructure_diagram
from remote_state_diagram import (
    create_remote_state_diagram,
    create_state_workflow_diagram,
)
from complete_overview_diagram import (
    create_complete_overview_diagram,
    create_terraform_lifecycle_diagram,
)


def main():
    """Generate all infrastructure diagrams"""

    print("🚀 Generating Day 6 Terraform Infrastructure Diagrams...")
    print("=" * 60)

    try:
        # Basic Infrastructure
        print("📊 Generating basic infrastructure diagram...")
        create_basic_infrastructure_diagram()
        print("✅ Basic infrastructure diagram created: basic_infrastructure.png")

        # Remote State Infrastructure
        print("📊 Generating remote state diagrams...")
        create_remote_state_diagram()
        create_state_workflow_diagram()
        print("✅ Remote state diagrams created:")
        print("   - remote_state_infrastructure.png")
        print("   - terraform_state_workflow.png")

        # Complete Overview
        print("📊 Generating complete overview diagrams...")
        create_complete_overview_diagram()
        create_terraform_lifecycle_diagram()
        print("✅ Complete overview diagrams created:")
        print("   - complete_infrastructure_overview.png")
        print("   - terraform_lifecycle.png")

        print("\n" + "=" * 60)
        print("🎉 All diagrams generated successfully!")
        print("\nGenerated files:")

        # List all generated PNG files
        current_dir = Path(".")
        png_files = list(current_dir.glob("*.png"))

        for png_file in sorted(png_files):
            print(f"   📷 {png_file.name}")

        print(f"\nTotal diagrams: {len(png_files)}")

    except ImportError as e:
        print(f"❌ Import error: {e}")
        print("Make sure the 'diagrams' library is installed:")
        print("pip install diagrams")
        sys.exit(1)

    except Exception as e:
        print(f"❌ Error generating diagrams: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
