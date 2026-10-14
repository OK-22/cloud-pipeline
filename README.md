# Cloud Pipeline: Terraform, Docker, and GitHub Actions

A small web app with a continuous integration pipeline and the Terraform code to run it on AWS. Every push runs the tests, checks the infrastructure code, builds a container image, and publishes it to the GitHub Container Registry.

## What is in here
- `app/`: a tiny Flask app with two routes (`/` and `/health`) and unit tests
- `Dockerfile`: builds the app image and runs it with gunicorn as a non-root user
- `.github/workflows/ci.yml`: the pipeline (test, Terraform check, build and push image)
- `terraform/`: a VPC, public subnet, internet gateway, route table, security group, and one EC2 instance that runs the container

## The pipeline
| Job | What it does | Runs on |
|---|---|---|
| test | Installs dependencies and runs pytest | every push and pull request |
| terraform | `terraform fmt -check`, `init -backend=false`, and `validate` (no AWS credentials needed) | every push and pull request |
| image | Builds the image and pushes it to `ghcr.io` with a `latest` tag and a tag for the commit | pushes to `main`, after the first two jobs pass |

## Run it locally
```
pip install -r app/requirements.txt pytest
pytest -q app
docker build -t cloud-pipeline .
docker run --rm -p 8080:8080 cloud-pipeline
```
Then open http://localhost:8080 or http://localhost:8080/health.

## Deploy to AWS (manual, costs money if left running)
The Terraform code is written and checked in the pipeline, but deploying it is a separate manual step.
```
cd terraform
terraform init
terraform plan
terraform apply
```
Open the `app_url` output in a browser. When you are done, remove everything:
```
terraform destroy
```
Notes:
- The container image must be public for the instance to pull it.
- No SSH port is open, and HTTP is allowed from anywhere unless you set `allowed_cidr`.
- Set an AWS budget alert before the first apply, and always destroy after a session.

## Status
- Unit tests: 2 passing locally.
- The Terraform files are formatted and parse correctly. `terraform validate` runs in the pipeline.
- Not yet recorded here: the first pipeline run, the image pull, and an AWS apply. Results and screenshots will be added when they happen.

## Limits
- One instance in one subnet, with no load balancer, no HTTPS, and no remote Terraform state. It is a learning project, not a production design.
