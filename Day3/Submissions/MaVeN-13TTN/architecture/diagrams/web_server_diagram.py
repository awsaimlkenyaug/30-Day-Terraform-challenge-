#!/usr/bin/env python3
"""
Day 3 - Web Server Architecture Diagram
Creates a visual representation of the web server deployment using diagrams as code.
"""

from diagrams import Diagram, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway
from diagrams.onprem.client import Users
from diagrams.generic.network import Firewall

# Create the web server architecture diagram
with Diagram(
    "Web Server Architecture - Day 3",
    show=False,
    filename="../web-server",
    direction="TB",
    graph_attr={"fontsize": "16", "fontname": "Helvetica"},
):

    # External users
    users = Users("Internet Users\n(HTTP Access)")

    # Internet Gateway
    igw = InternetGateway("Internet Gateway")

    # VPC
    vpc = VPC("Default VPC\n(172.31.0.0/16)")

    # Public subnet
    subnet = PublicSubnet("Public Subnet\n(172.31.32.0/20)\nus-east-1a")

    # Security group (represented by firewall)
    sg = Firewall("Security Group\nHTTP (80)\nSSH (22)")

    # EC2 instance with web server
    web_server = EC2("Web Server\nt3.micro\nAmazon Linux 2\nApache HTTP Server")

    # Define connections with labels
    users >> Edge(label="HTTP (80)", style="bold", color="green") >> igw
    igw >> vpc >> subnet >> sg >> web_server

print("✅ Web server architecture diagram generated successfully!")
print("📁 Saved as: ../web-server.png")
