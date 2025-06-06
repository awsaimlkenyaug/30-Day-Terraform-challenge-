#!/usr/bin/env python3
"""
File Layout Isolation Infrastructure Diagram Generator
Creates a visual representation of the file layout-based state isolation architecture
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2, AutoScaling
from diagrams.aws.network import (
    VPC,
    PublicSubnet,
    PrivateSubnet,
    InternetGateway,
    RouteTable,
    ELB,
)
from diagrams.aws.security import IAM
from diagrams.aws.storage import S3
from diagrams.aws.database import Dynamodb
from diagrams.generic.storage import Storage
from diagrams.generic.network import Firewall
from diagrams.onprem.client import Users
from diagrams.programming.framework import React


def create_file_layout_isolation_diagram():
    """Generate file layout isolation infrastructure diagram"""

    with Diagram(
        "Day 7 - File Layout Isolation Architecture",
        filename="../diagrams/file_layout_isolation_infrastructure",
        show=False,
        direction="TB",
        graph_attr={"fontsize": "45", "bgcolor": "white", "pad": "1.0"},
    ):

        # Users
        users = Users("Users")

        # State Management Backend (Separate per environment)
        with Cluster("Terraform State Backend\n(Environment-Specific)"):
            with Cluster("Dev State"):
                s3_dev = S3("Dev State\nkey: dev/terraform.tfstate")
            with Cluster("Staging State"):
                s3_staging = S3("Staging State\nkey: staging/terraform.tfstate")
            with Cluster("Prod State"):
                s3_prod = S3("Prod State\nkey: prod/terraform.tfstate")

            dynamodb_lock = Dynamodb("Shared DynamoDB Lock\nterraform-state-lock")

        # Modular Architecture
        with Cluster("Modular Architecture"):
            with Cluster("Reusable Modules"):
                vpc_module = React("VPC Module\nvpc/")
                sg_module = React("Security Groups Module\nsecurity-groups/")
                compute_module = React("Compute Module\ncompute/")
                lb_module = React("Load Balancer Module\nload-balancer/")

        # Environment-Specific Deployments
        with Cluster("Environment Isolation\n(Separate Configurations)"):

            # Dev Environment
            with Cluster("Development Environment\nenvironments/dev/"):
                with Cluster("Dev VPC (10.0.0.0/16)"):
                    dev_igw = InternetGateway("Internet Gateway")
                    dev_rt = RouteTable("Public Route Table")

                    with Cluster("Public Subnets (Multi-AZ)"):
                        dev_pub_subnet1 = PublicSubnet(
                            "Public Subnet 1\n10.0.1.0/24\nus-west-2a"
                        )
                        dev_pub_subnet2 = PublicSubnet(
                            "Public Subnet 2\n10.0.2.0/24\nus-west-2b"
                        )

                    with Cluster("Private Subnets (Multi-AZ)"):
                        dev_priv_subnet1 = PrivateSubnet(
                            "Private Subnet 1\n10.0.10.0/24\nus-west-2a"
                        )
                        dev_priv_subnet2 = PrivateSubnet(
                            "Private Subnet 2\n10.0.11.0/24\nus-west-2b"
                        )

                    dev_sg = Firewall("Web Security Group")
                    dev_alb = ELB("ALB\ndev-terraform-file-layout-isolation-alb")
                    dev_asg = AutoScaling("ASG\nt2.micro\n1-3 capacity")
                    dev_instances = [EC2("Web Server 1")]

            # Staging Environment
            with Cluster("Staging Environment\nenvironments/staging/"):
                with Cluster("Staging VPC (10.1.0.0/16)"):
                    staging_igw = InternetGateway("Internet Gateway")
                    staging_rt = RouteTable("Public Route Table")

                    with Cluster("Public Subnets (Multi-AZ)"):
                        staging_pub_subnet1 = PublicSubnet(
                            "Public Subnet 1\n10.1.1.0/24\nus-west-2a"
                        )
                        staging_pub_subnet2 = PublicSubnet(
                            "Public Subnet 2\n10.1.2.0/24\nus-west-2b"
                        )

                    staging_sg = Firewall("Web Security Group")
                    staging_alb = ELB(
                        "ALB\nstaging-terraform-file-layout-isolation-alb"
                    )
                    staging_asg = AutoScaling("ASG\nt3.small\n1-5 capacity")
                    staging_instances = [EC2("Web Server 1"), EC2("Web Server 2")]

            # Production Environment
            with Cluster("Production Environment\nenvironments/prod/"):
                with Cluster("Production VPC (10.2.0.0/16)"):
                    prod_igw = InternetGateway("Internet Gateway")
                    prod_rt = RouteTable("Public Route Table")

                    with Cluster("Public Subnets (Multi-AZ)"):
                        prod_pub_subnet1 = PublicSubnet(
                            "Public Subnet 1\n10.2.1.0/24\nus-west-2a"
                        )
                        prod_pub_subnet2 = PublicSubnet(
                            "Public Subnet 2\n10.2.2.0/24\nus-west-2b"
                        )

                    prod_sg = Firewall("Web Security Group")
                    prod_alb = ELB("ALB\nprod-terraform-file-layout-isolation-alb")
                    prod_asg = AutoScaling("ASG\nt3.medium\n2-10 capacity")
                    prod_instances = [
                        EC2("Web Server 1"),
                        EC2("Web Server 2"),
                        EC2("Web Server 3"),
                    ]

        # Connections
        users >> Edge(label="HTTP/HTTPS") >> dev_alb
        users >> Edge(label="HTTP/HTTPS") >> staging_alb
        users >> Edge(label="HTTP/HTTPS") >> prod_alb

        # Module relationships (conceptual)
        vpc_module >> Edge(label="provides VPC\nresources", style="dashed") >> dev_igw
        sg_module >> Edge(label="provides security\ngroups", style="dashed") >> dev_sg
        (
            compute_module
            >> Edge(label="provides ASG\nand instances", style="dashed")
            >> dev_asg
        )
        lb_module >> Edge(label="provides load\nbalancer", style="dashed") >> dev_alb

        # State connections
        dev_alb >> Edge(label="stores state", style="dotted") >> s3_dev
        staging_alb >> Edge(label="stores state", style="dotted") >> s3_staging
        prod_alb >> Edge(label="stores state", style="dotted") >> s3_prod

        s3_dev >> Edge(label="uses lock", style="dotted") >> dynamodb_lock
        s3_staging >> Edge(label="uses lock", style="dotted") >> dynamodb_lock
        s3_prod >> Edge(label="uses lock", style="dotted") >> dynamodb_lock

        # Internal connections (simplified)
        dev_alb >> dev_asg >> dev_instances
        staging_alb >> staging_asg >> staging_instances
        prod_alb >> prod_asg >> prod_instances


if __name__ == "__main__":
    create_file_layout_isolation_diagram()
    print("File layout isolation diagram generated successfully!")
