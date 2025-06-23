#!/usr/bin/env python3
"""
Infrastructure Diagram Generator for Day 5: Enhanced Load Balancer
30-Day Terraform Challenge

This script creates a visual representation of the deployed AWS infrastructure
including Application Load Balancer, Auto Scaling Group, CloudWatch monitoring,
and security groups.
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2, AutoScaling
from diagrams.aws.network import ALB, InternetGateway
from diagrams.aws.management import Cloudwatch
from diagrams.onprem.client import Users
from diagrams.generic.network import Firewall


def create_infrastructure_diagram():
    """Create a comprehensive infrastructure diagram"""

    # Configuration from Terraform outputs
    config = {
        "cluster_name": "learning-day5-enhanced-cluster",
        "region": "us-east-1",
        "availability_zones": [
            "us-east-1a",
            "us-east-1b",
            "us-east-1c",
            "us-east-1d",
            "us-east-1f",
        ],
        "instance_type": "t3.micro",
        "min_size": 2,
        "max_size": 8,
        "desired_capacity": 2,
        "alb_dns": "learning-day5-enhanced-cluster-a-1051928647.us-east-1.elb.amazonaws.com",
    }

    with Diagram(
        "Day 5: Enhanced Load Balancer Infrastructure\n30-Day Terraform Challenge",
        filename="day5_enhanced_load_balancer_architecture",
        direction="TB",
        show=False,
        graph_attr={
            "fontsize": "16",
            "fontcolor": "#2D72A3",
            "bgcolor": "#F8F9FA",
            "rankdir": "TB",
            "nodesep": "1.0",
            "ranksep": "1.5",
        },
    ):

        # External users
        users = Users("Internet Users")

        with Cluster("AWS Region: us-east-1"):

            # Internet Gateway
            igw = InternetGateway("Internet Gateway")

            with Cluster("VPC (Default)"):

                # Application Load Balancer
                with Cluster("Load Balancer Layer"):
                    alb = ALB("Application Load Balancer\n" + config["alb_dns"])
                    alb_sg = Firewall("ALB Security Group\nHTTP:80 from 0.0.0.0/0")

                # Availability Zones with Subnets
                with Cluster("Multi-AZ Deployment (5 AZs)"):

                    # Auto Scaling Group
                    with Cluster(
                        f"Auto Scaling Group\nMin: {config['min_size']}, Max: {config['max_size']}, Desired: {config['desired_capacity']}"
                    ):

                        # EC2 Instances
                        instances = []
                        for i, az in enumerate(
                            config["availability_zones"][:3]
                        ):  # Show 3 AZs for clarity
                            with Cluster(f"Availability Zone: {az}"):
                                if i < config["desired_capacity"]:
                                    instance = EC2(
                                        f"Web Server {i+1}\n{config['instance_type']}"
                                    )
                                    instances.append(instance)
                                else:
                                    instance = EC2(
                                        f"Auto Scale Instance\n{config['instance_type']}"
                                    )
                                    instances.append(instance)

                # Security Group for instances
                instances_sg = Firewall(
                    "Instances Security Group\nHTTP:80 from ALB only"
                )

                # Auto Scaling components
                asg = AutoScaling(
                    "Auto Scaling Group\nTarget Tracking: 70% CPU\nStep Scaling Policies"
                )

                # CloudWatch Monitoring
                with Cluster("Monitoring & Alarms"):
                    cloudwatch = Cloudwatch("CloudWatch Metrics")
                    high_cpu_alarm = Cloudwatch("High CPU Alarm\n>85% for 2 periods")
                    low_cpu_alarm = Cloudwatch("Low CPU Alarm\n<25% for 3 periods")
                    unhealthy_alarm = Cloudwatch(
                        "Unhealthy Hosts Alarm\n>0 unhealthy targets"
                    )
                    logs = Cloudwatch("Apache Access/Error Logs")

        # Data flow connections
        users >> Edge(label="HTTPS/HTTP Requests", style="bold", color="blue") >> igw
        igw >> Edge(label="Route to ALB", color="blue") >> alb

        # ALB to instances
        for instance in instances:
            alb >> Edge(label="HTTP:80\nHealth Checks", color="green") >> instance

        # Security group relationships
        alb_sg >> Edge(label="Protects", style="dashed", color="orange") >> alb
        (
            instances_sg
            >> Edge(label="Protects", style="dashed", color="orange")
            >> instances[0]
        )

        # Auto Scaling relationships
        asg >> Edge(label="Manages", color="purple") >> instances[0]

        # CloudWatch monitoring
        instances[0] >> Edge(label="CPU/Memory Metrics", color="red") >> cloudwatch
        cloudwatch >> Edge(label="Triggers", color="red") >> high_cpu_alarm
        cloudwatch >> Edge(label="Triggers", color="red") >> low_cpu_alarm
        alb >> Edge(label="Health Metrics", color="red") >> unhealthy_alarm
        instances[0] >> Edge(label="Application Logs", color="gray") >> logs

        # Scaling triggers
        high_cpu_alarm >> Edge(label="Scale Up (+2)", color="red", style="bold") >> asg
        (
            low_cpu_alarm
            >> Edge(label="Scale Down (-1)", color="blue", style="bold")
            >> asg
        )


def create_simplified_diagram():
    """Create a simplified architecture overview"""

    with Diagram(
        "Day 5: Load Balancer Architecture Overview",
        filename="day5_simplified_architecture",
        direction="LR",
        show=False,
        graph_attr={"fontsize": "14", "bgcolor": "#FFFFFF", "rankdir": "LR"},
    ):

        users = Users("Users")

        with Cluster("AWS Infrastructure"):
            alb = ALB("Application\nLoad Balancer")

            with Cluster("Auto Scaling Group (2-8 instances)"):
                web1 = EC2("Web Server 1")
                web2 = EC2("Web Server 2")
                web3 = EC2("Web Server N\n(Auto Scale)", style="dashed")

            monitoring = Cloudwatch("CloudWatch\nMonitoring")

        # Connections
        users >> alb
        alb >> web1
        alb >> web2
        alb >> web3

        web1 >> monitoring
        web2 >> monitoring
        monitoring >> Edge(label="Auto Scale", style="bold") >> web3


def main():
    """Generate infrastructure diagrams"""
    print("🎨 Generating infrastructure diagrams...")
    print("📊 Creating detailed architecture diagram...")
    create_infrastructure_diagram()
    print("✅ Detailed diagram saved as: day5_enhanced_load_balancer_architecture.png")

    print("📊 Creating simplified overview diagram...")
    create_simplified_diagram()
    print("✅ Simplified diagram saved as: day5_simplified_architecture.png")

    print("\n🎯 Infrastructure Diagram Summary:")
    print("=" * 50)
    print("• Application Load Balancer across 5 Availability Zones")
    print("• Auto Scaling Group: 2-8 EC2 instances (t3.micro)")
    print("• Target Tracking Scaling: 70% CPU utilization")
    print("• Step Scaling: Scale up at 85% CPU, down at 25% CPU")
    print("• CloudWatch monitoring with custom alarms")
    print("• Security groups for ALB and EC2 instances")
    print("• Health checks and automated scaling")
    print("=" * 50)


if __name__ == "__main__":
    main()
