#!/usr/bin/env python3
"""
Remote State Infrastructure Diagram Generator
Creates a visual representation of the Terraform remote state setup
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.storage import S3
from diagrams.aws.database import DynamodbTable
from diagrams.aws.security import IAM
from diagrams.aws.general import General
from diagrams.onprem.client import Client


def create_remote_state_diagram():
    """Generate remote state infrastructure diagram"""

    with Diagram(
        "Day 6 - Remote State Infrastructure",
        filename="remote_state_infrastructure",
        show=False,
        direction="LR",
        graph_attr={"fontsize": "45", "bgcolor": "white"},
    ):

        # Terraform Client
        terraform_client = Client("Terraform Client")

        # AWS Cloud
        with Cluster("AWS Cloud"):
            # S3 Bucket for state storage
            s3_bucket = S3(
                "S3 Bucket\nterraform-state-*\n- Versioning Enabled\n- AES256 Encryption\n- Public Access Blocked"
            )

            # DynamoDB for state locking
            dynamodb_table = DynamodbTable(
                "DynamoDB Table\nterraform-locks\n- Hash Key: LockID\n- Pay per Request"
            )

            # IAM (implied security)
            iam_role = IAM("IAM Permissions\n- S3 Access\n- DynamoDB Access")

        # Connections
        terraform_client >> Edge(label="Read/Write State", style="solid") >> s3_bucket
        (
            terraform_client
            >> Edge(label="Acquire/Release Lock", style="dashed")
            >> dynamodb_table
        )
        terraform_client >> Edge(label="Authentication", style="dotted") >> iam_role

        # Security relationship
        iam_role >> Edge(label="Controls Access", style="dotted") >> s3_bucket
        iam_role >> Edge(label="Controls Access", style="dotted") >> dynamodb_table


def create_state_workflow_diagram():
    """Generate Terraform state workflow diagram"""

    with Diagram(
        "Day 6 - Terraform State Workflow",
        filename="terraform_state_workflow",
        show=False,
        direction="TB",
        graph_attr={"fontsize": "45", "bgcolor": "white"},
    ):

        # Workflow steps
        with Cluster("Terraform State Workflow"):
            terraform_init = General(
                "1. terraform init\n- Configure backend\n- Download providers"
            )
            terraform_plan = General(
                "2. terraform plan\n- Acquire lock\n- Compare state\n- Generate plan"
            )
            terraform_apply = General(
                "3. terraform apply\n- Execute changes\n- Update state\n- Release lock"
            )

            # Remote State Components
            with Cluster("Remote State Backend"):
                s3_state = S3("S3 State File\n- Current state\n- Previous versions")
                dynamodb_lock = DynamodbTable(
                    "DynamoDB Lock\n- Prevents conflicts\n- Team coordination"
                )

        # Workflow connections
        terraform_init >> Edge(label="Initialize") >> terraform_plan
        terraform_plan >> Edge(label="If approved") >> terraform_apply

        # State interactions
        terraform_plan >> Edge(label="Read state", style="dashed") >> s3_state
        terraform_plan >> Edge(label="Acquire lock", style="dotted") >> dynamodb_lock
        terraform_apply >> Edge(label="Update state", style="solid") >> s3_state
        terraform_apply >> Edge(label="Release lock", style="dotted") >> dynamodb_lock


if __name__ == "__main__":
    create_remote_state_diagram()
    create_state_workflow_diagram()
    print("Remote state diagrams generated:")
    print("- remote_state_infrastructure.png")
    print("- terraform_state_workflow.png")
