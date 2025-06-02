#!/usr/bin/env python3
"""
Basic Infrastructure Diagram Generator
Creates a visual representation of the basic AWS infrastructure from Terraform configuration
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway, RouteTable
from diagrams.aws.security import IAM
from diagrams.aws.general import General


def create_basic_infrastructure_diagram():
    """Generate basic infrastructure diagram based on Terraform configuration"""

    with Diagram(
        "Day 6 - Basic Infrastructure",
        filename="basic_infrastructure",
        show=False,
        direction="TB",
        graph_attr={"fontsize": "45", "bgcolor": "white"},
    ):

        # Internet
        internet = General("Internet")

        # AWS VPC Cluster
        with Cluster("AWS VPC\n10.0.0.0/16"):
            # Internet Gateway
            igw = InternetGateway("Internet Gateway")

            # Route Table
            route_table = RouteTable("Public Route Table")

            # Public Subnet
            with Cluster("Public Subnet\n10.0.1.0/24\nus-east-1a"):
                # Security Group (using IAM as placeholder for security)
                web_sg = IAM("Web Security Group\n- HTTP (80)\n- SSH (22)")

                # EC2 Instance (implied from security group configuration)
                web_server = EC2("Web Server\n(Future deployment)")

        # Connections
        internet >> Edge(label="Internet Traffic") >> igw
        igw >> Edge(label="Route 0.0.0.0/0") >> route_table
        route_table >> Edge(label="Associated") >> web_sg
        web_sg >> web_server


if __name__ == "__main__":
    create_basic_infrastructure_diagram()
    print("Basic infrastructure diagram generated: basic_infrastructure.png")
