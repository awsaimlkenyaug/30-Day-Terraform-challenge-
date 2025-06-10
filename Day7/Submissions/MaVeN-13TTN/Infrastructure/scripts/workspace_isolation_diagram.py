#!/usr/bin/env python3
"""
Workspace Isolation Infrastructure Diagram Generator
Creates a visual representation of the workspace-based state isolation architecture
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


def create_workspace_isolation_diagram():
    """Generate workspace isolation infrastructure diagram"""

    with Diagram(
        "Day 7 - Workspace Isolation Architecture",
        filename="../diagrams/workspace_isolation_infrastructure",
        show=False,
        direction="TB",
        graph_attr={"fontsize": "45", "bgcolor": "white", "pad": "1.0"},
    ):

        # Users
        users = Users("Users")

        # State Management Backend
        with Cluster("Terraform State Backend\n(Shared)"):
            s3_state = S3("S3 State Bucket\nmaven-13ttn-terraform-state-bucket")
            dynamodb_lock = Dynamodb("DynamoDB Lock Table\nterraform-state-lock")

        # Workspace Environments
        with Cluster("Workspace Isolation\n(Single Configuration)"):

            # Dev Workspace
            with Cluster("Dev Workspace\n(terraform workspace select dev)"):
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

                    dev_sg = Firewall("Web Security Group\nHTTP/HTTPS/SSH")
                    dev_alb = ELB("Application Load Balancer\ndev-web-lb")
                    dev_asg = AutoScaling(
                        "Auto Scaling Group\nt2.micro instances\n1-2 capacity"
                    )
                    dev_instances = [EC2("Web Server 1"), EC2("Web Server 2")]

            # Staging Workspace
            with Cluster("Staging Workspace\n(terraform workspace select staging)"):
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

                    staging_sg = Firewall("Web Security Group\nHTTP/HTTPS/SSH")
                    staging_alb = ELB("Application Load Balancer\nstaging-web-lb")
                    staging_asg = AutoScaling(
                        "Auto Scaling Group\nt3.small instances\n2-4 capacity"
                    )
                    staging_instances = [EC2("Web Server 1"), EC2("Web Server 2")]

            # Production Workspace
            with Cluster("Production Workspace\n(terraform workspace select prod)"):
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

                    prod_sg = Firewall("Web Security Group\nHTTP/HTTPS/SSH")
                    prod_alb = ELB("Application Load Balancer\nprod-web-lb")
                    prod_asg = AutoScaling(
                        "Auto Scaling Group\nt3.medium instances\n3-10 capacity"
                    )
                    prod_instances = [
                        EC2("Web Server 1"),
                        EC2("Web Server 2"),
                        EC2("Web Server 3"),
                    ]

        # Terraform Configuration
        terraform_config = Storage(
            "Single Terraform Configuration\nWorkspace-aware conditionals"
        )

        # Connections
        users >> Edge(label="HTTP/HTTPS") >> dev_alb
        users >> Edge(label="HTTP/HTTPS") >> staging_alb
        users >> Edge(label="HTTP/HTTPS") >> prod_alb

        # State connections
        terraform_config >> Edge(label="Stores state\n(workspace-specific)") >> s3_state
        terraform_config >> Edge(label="State locking") >> dynamodb_lock

        # Internal connections (simplified for clarity)
        dev_alb >> dev_asg
        dev_asg >> dev_instances
        staging_alb >> staging_asg
        staging_asg >> staging_instances
        prod_alb >> prod_asg
        prod_asg >> prod_instances


if __name__ == "__main__":
    create_workspace_isolation_diagram()
    print("Workspace isolation diagram generated successfully!")
