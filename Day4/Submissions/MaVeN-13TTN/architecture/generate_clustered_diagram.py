#!/usr/bin/env python3
"""
Architecture Diagram for Day 4 - Clustered Web Server
Based on actual Terraform infrastructure provisioned
"""

import os
from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2, AutoScaling
from diagrams.aws.network import ELB, InternetGateway
from diagrams.aws.security import IAM
from diagrams.aws.management import Cloudwatch
from diagrams.aws.general import Users


def create_clustered_webserver_architecture():
    """
    Create architecture diagram based on actual clustered web server infrastructure:
    - Application Load Balancer (ALB)
    - Auto Scaling Group (2-6 instances across multiple AZs)
    - Launch Template with t3.micro instances
    - Target Group with health checks
    - CloudWatch alarms for CPU-based scaling
    - Security Groups for ALB and web servers
    """

    print("Creating clustered architecture diagram...")

    with Diagram(
        "Clustered Web Server Architecture",
        filename="clustered_webserver_architecture",
        direction="TB",
        show=False,
    ):

        # External users
        users = Users("Users")

        with Cluster("AWS Cloud"):
            with Cluster("Default VPC"):
                # Internet Gateway
                igw = InternetGateway("Internet Gateway")

                # Application Load Balancer layer
                with Cluster("Public Subnets"):
                    alb_sg = IAM("ALB Security Group\nHTTP (80)")
                    alb = ELB("Application\nLoad Balancer\nTarget Group")

                # Auto Scaling Group across multiple AZs
                with Cluster("Auto Scaling Group"):
                    # Web servers in different AZs
                    with Cluster("us-east-1a"):
                        web1 = EC2("Web Server 1\nt3.micro")

                    with Cluster("us-east-1b"):
                        web2 = EC2("Web Server 2\nt3.micro")

                    with Cluster("us-east-1c"):
                        web3 = EC2("Web Server 3\nt3.micro")

                    # Auto Scaling and Security
                    asg = AutoScaling("Auto Scaling Group\nMin: 2, Max: 6\nDesired: 3")
                    web_sg = IAM("Web Security Group\nHTTP from ALB")

                # Monitoring and Auto Scaling
                with Cluster("CloudWatch"):
                    cpu_high = Cloudwatch("CPU High Alarm\n>70%")
                    cpu_low = Cloudwatch("CPU Low Alarm\n<30%")

        # Connection flows
        users >> Edge(label="HTTP") >> igw >> alb_sg >> alb
        alb >> Edge(label="Load Balance") >> web1
        alb >> Edge(label="Load Balance") >> web2
        alb >> Edge(label="Load Balance") >> web3

        # Auto Scaling Group management
        asg >> Edge(style="dashed", label="Manages") >> web1
        asg >> Edge(style="dashed", label="Manages") >> web2
        asg >> Edge(style="dashed", label="Manages") >> web3
        web_sg >> web1
        web_sg >> web2
        web_sg >> web3

        # Monitoring and scaling
        web1 >> Edge(style="dashed", label="CPU Metrics") >> cpu_high
        web2 >> Edge(style="dashed", label="CPU Metrics") >> cpu_high
        web3 >> Edge(style="dashed", label="CPU Metrics") >> cpu_low
        cpu_high >> Edge(style="dashed", label="Scale Out") >> asg
        cpu_low >> Edge(style="dashed", label="Scale In") >> asg

    print("Clustered diagram creation completed!")


def main():
    """Generate clustered web server architecture diagram"""
    print("🎨 Generating Clustered Web Server Architecture Diagram...")
    print("=" * 60)

    # Create diagrams directory
    os.makedirs("diagrams", exist_ok=True)
    print(f"Current directory: {os.getcwd()}")
    os.chdir("diagrams")
    print(f"Changed to directory: {os.getcwd()}")

    try:
        print("📊 Creating Clustered Web Server Architecture...")
        create_clustered_webserver_architecture()
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
