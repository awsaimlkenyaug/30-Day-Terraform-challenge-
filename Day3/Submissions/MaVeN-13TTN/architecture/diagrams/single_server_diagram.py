#!/usr/bin/env python3
"""
Day 3 - Single Server Architecture Diagram
Creates a visual representation of the single server deployment using diagrams as code.
"""

from diagrams import Diagram, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import User
from diagrams.generic.network import Firewall

# Create the single server architecture diagram
with Diagram(
    "Single Server Architecture - Day 3",
    show=False,
    filename="../single-server",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External user (administrator)
    admin = User("Administrator\n(SSH Access)")

    # Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Public subnet
    subnet = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")

    # Security group (represented by firewall)
    sg = Firewall("Security Group\nSSH (22)")

    # EC2 instance
    server = EC2("Single Server\nt3.micro\nAmazon Linux 2")

    # Define connections with labels
    admin >> Edge(label="SSH (22)", style="dashed", color="blue") >> igw
    igw >> vpc >> subnet >> sg >> server

print("✅ Single server architecture diagram generated successfully!")
print("📁 Saved as: ../single-server.png")
