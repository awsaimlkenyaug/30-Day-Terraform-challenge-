#!/usr/bin/env python3
"""
Complete Infrastructure Overview Diagram
Combines both basic infrastructure and remote state components
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, PublicSubnet, InternetGateway, RouteTable
from diagrams.aws.security import IAM
from diagrams.aws.storage import S3
from diagrams.aws.database import DynamodbTable
from diagrams.aws.general import General
from diagrams.onprem.client import Client


def create_complete_overview_diagram():
    """Generate complete infrastructure overview including state management"""

    with Diagram(
        "Day 6 - Complete Infrastructure Overview",
        filename="complete_infrastructure_overview",
        show=False,
        direction="TB",
        graph_attr={"fontsize": "45", "bgcolor": "white"},
    ):

        # Developer/Terraform Client
        terraform_dev = Client("Terraform Developer")

        # State Management Layer
        with Cluster("Terraform State Management"):
            s3_bucket = S3(
                "S3 State Bucket\n- terraform-state-*\n- Versioning\n- Encryption"
            )
            dynamodb_table = DynamodbTable(
                "DynamoDB Lock Table\n- terraform-locks\n- State coordination"
            )

        # Application Infrastructure
        with Cluster("Application Infrastructure\n(Managed by Terraform)"):
            internet = General("Internet")

            with Cluster("AWS VPC (10.0.0.0/16)"):
                igw = InternetGateway("Internet Gateway")
                route_table = RouteTable("Public Route Table")

                with Cluster("Public Subnet (10.0.1.0/24)"):
                    web_sg = IAM("Web Security Group")
                    web_server = EC2("Web Server\n(Future)")

        # State management connections
        (
            terraform_dev
            >> Edge(label="terraform init/plan/apply", color="blue")
            >> s3_bucket
        )
        (
            terraform_dev
            >> Edge(label="State locking", color="red", style="dashed")
            >> dynamodb_table
        )

        # Infrastructure management
        terraform_dev >> Edge(label="Manages Infrastructure", color="green") >> igw

        # Infrastructure connections
        internet >> igw >> route_table >> web_sg >> web_server


def create_terraform_lifecycle_diagram():
    """Generate Terraform lifecycle and state interaction diagram"""

    with Diagram(
        "Day 6 - Terraform Lifecycle with State",
        filename="terraform_lifecycle",
        show=False,
        direction="LR",
        graph_attr={"fontsize": "45", "bgcolor": "white"},
    ):

        # Terraform Commands
        with Cluster("Terraform Commands"):
            init_cmd = General("terraform init\n- Backend config\n- Provider download")
            plan_cmd = General("terraform plan\n- State comparison\n- Change planning")
            apply_cmd = General("terraform apply\n- Resource creation\n- State update")
            destroy_cmd = General(
                "terraform destroy\n- Resource cleanup\n- State cleanup"
            )

        # State Storage
        with Cluster("Remote State"):
            current_state = S3("Current State\n.tfstate file")
            state_versions = S3("State Versions\n- Backup\n- History")
            state_lock = DynamodbTable("State Lock\n- Concurrency control")

        # AWS Resources
        with Cluster("AWS Resources"):
            aws_resources = General(
                "AWS Infrastructure\n- VPC\n- Subnets\n- Security Groups"
            )

        # Command flow
        init_cmd >> plan_cmd >> apply_cmd
        apply_cmd >> destroy_cmd

        # State interactions
        plan_cmd >> Edge(label="Read", style="dashed") >> current_state
        apply_cmd >> Edge(label="Update", color="green") >> current_state
        current_state >> Edge(label="Backup", color="blue") >> state_versions

        # Locking
        plan_cmd >> Edge(label="Lock", color="red") >> state_lock
        apply_cmd >> Edge(label="Lock", color="red") >> state_lock

        # Resource management
        apply_cmd >> Edge(label="Create/Update", color="green") >> aws_resources
        destroy_cmd >> Edge(label="Delete", color="red") >> aws_resources


if __name__ == "__main__":
    create_complete_overview_diagram()
    create_terraform_lifecycle_diagram()
    print("Complete infrastructure diagrams generated:")
    print("- complete_infrastructure_overview.png")
    print("- terraform_lifecycle.png")
