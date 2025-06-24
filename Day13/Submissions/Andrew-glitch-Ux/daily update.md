# ✅ Daily Update – Day 13

## Focus: Secure Secrets Management with GPG + Terraform

Today I focused on managing sensitive DB credentials securely using GPG-encrypted files, bash scripting, and Terraform locals.

### Key Achievements:
- Created and encrypted `secrets.json.gpg` with MySQL credentials
- Wrote `scripts/decrypt.sh` to decrypt secrets just before `terraform apply`
- Used `locals {}` + `jsondecode(file(...))` to securely inject secrets
- Applied DB config without exposing secrets in tfvars, code, or outputs
- Used encrypted S3 backend with DynamoDB for locking

### Challenges:
- Debugged invalid identifier naming
- Fixed path errors and ensured secrets were excluded from version control

### Time Spent:
Total ~6 hours

### Status:
✅ Lab 15 complete — secure secrets injection, no hardcoding
✅ Architecture diagram finalized
✅ Submission ready for review
