#!/usr/bin/env python3
"""
Day 3 - Complete Infrastructure Overview
Creates a visual representation of both single server and web server deployments.
"""

from diagrams import Diagram, Edge, Cluster
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import Users, User
from diagrams.generic.network import Firewall

# Create the complete infrastructure diagram
with Diagram(
    "Complete Day 3 Infrastructure",
    show=False,
    filename="../complete-infrastructure",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External access
    users = Users("Internet Users")
    admin = User("Administrator")

    # Shared Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Create clusters for different deployments
    with Cluster("Single Server Deployment"):
        subnet1 = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")
        sg1 = Firewall("SG-SSH\n(Port 22)")
        server1 = EC2("Single Server\nt3.micro\nSSH Only")

        subnet1 >> sg1 >> server1

    with Cluster("Web Server Deployment"):
        subnet2 = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")
        sg2 = Firewall("SG-Web\n(Port 80, 22)")
        server2 = EC2("Web Server\nt3.micro\nApache HTTP")

        subnet2 >> sg2 >> server2

    # Define connections
    admin >> Edge(label="SSH", style="dashed", color="blue") >> igw
    users >> Edge(label="HTTP", style="bold", color="green") >> igw

    igw >> vpc
    vpc >> subnet1
    vpc >> subnet2

print("✅ Complete infrastructure diagram generated successfully!")
print("📁 Saved as: ../complete-infrastructure.png")
