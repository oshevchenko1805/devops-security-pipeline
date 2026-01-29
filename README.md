# DevOps Security Pipeline

CI/CD pipeline with Blue-Green deployment and comprehensive security scanning.

## Security Tools
- Gitleaks - Secret scanning
- Trivy - Container & dependency scanning
- Semgrep - SAST analysis
- Bandit - Python security linter
- Safety - Python dependency checker
- Hadolint - Dockerfile linter

## Tech Stack
- FastAPI application
- Kubernetes (kind)
- GitHub Actions
- Docker

## Deployment Strategy
Blue-Green deployment with automated health checks and traffic switching.
