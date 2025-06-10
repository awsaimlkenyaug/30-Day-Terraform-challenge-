#!/usr/bin/env python3
"""
Architecture Diagram for Day 4 - Configurable Web Server
Based on actual Terraform infrastructure provisioned
"""

import os
from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import InternetGateway
from diagrams.aws.security import IAM
from diagrams.aws.management import Cloudwatch
from diagrams.aws.general import Users


def create_configurable_webserver_architecture():
    """
    Create architecture diagram based on actual configurable web server infrastructure:
    - Single EC2 instance (t3.micro)
    - Security Group with HTTP(80) and SSH(22) access
    - Elastic IP (conditional)
    - CloudWatch monitoring (optional)
    - SSH Key Pair (conditional)
    """

    print("Creating diagram...")

    with Diagram(
        "Configurable Web Server Architecture",
        filename="configurable_webserver_architecture",
        direction="TB",
        show=False,
    ):

        # External users
        users = Users("Users")

        with Cluster("AWS Cloud"):
            with Cluster("Default VPC"):
                # Internet Gateway
                igw = InternetGateway("Internet Gateway")

                with Cluster("Public Subnet (us-east-1a)"):
                    # Security Group
                    sg = IAM("Security Group\nHTTP (80)\nSSH (22)")

                    # Main web server instance
                    web_server = EC2("Web Server\nt3.micro\nApache HTTP")

                    # Optional monitoring
                    monitoring = Cloudwatch("CloudWatch\nMonitoring")

        # Connection flows
        users >> Edge(label="HTTP/SSH") >> igw >> sg >> web_server
        web_server >> Edge(style="dashed", label="metrics") >> monitoring

    print("Diagram creation completed!")


def main():
    """Generate configurable web server architecture diagram"""
    print("🎨 Generating Configurable Web Server Architecture Diagram...")
    print("=" * 60)

    # Create diagrams directory
    os.makedirs("diagrams", exist_ok=True)
    print(f"Current directory: {os.getcwd()}")
    os.chdir("diagrams")
    print(f"Changed to directory: {os.getcwd()}")

    try:
        print("📊 Creating Configurable Web Server Architecture...")
        create_configurable_webserver_architecture()
        print("✅ Architecture diagram function completed!")

        # List all files
        print("\n📁 All files in directory:")
        all_files = os.listdir(".")
        for file in all_files:
            print(f"  - {file}")

        # List PNG files specifically
        png_files = [f for f in all_files if f.endswith(".png")]
        if png_files:
            print("\n🖼️ Generated PNG files:")
            for file in png_files:
                print(f"  - {file}")
        else:
            print("\n⚠️ No PNG files found!")

    except Exception as e:
        print(f"❌ Error generating diagram: {e}")
        import traceback

        traceback.print_exc()
        return False

    return True


if __name__ == "__main__":
    main()
