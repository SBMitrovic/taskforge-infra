# taskforge-infra

> This repository is part of the **TaskForge** microservices architecture — a project management platform inspired by Jira. Full project coming soon.

## About

`taskforge-infra` contains the infrastructure configuration for the TaskForge platform. This includes the Docker setup and database initialization scripts used across all TaskForge services.

## What's inside

- `docker-compose.yml` — spins up a MySQL 8 instance for local development
- `db/init.sql` — initializes the database schema and seed data (users, projects, tasks)

## Getting Started

**Prerequisites:** Docker & Docker Compose

```bash
git clone https://github.com/SBMitrovic/taskforge-infra.git
cd taskforge-infra
docker-compose up -d
```

MySQL will be available at `localhost:3306` with database `taskforge`.

| Property | Value |
|----------|-------|
| Host | `localhost` |
| Port | `3306` |
| Database | `taskforge` |
| Username | `root` |
| Password | `root` |

## Microservices Architecture — TaskForge

```
taskforge-infra          → Docker, database, infrastructure (this repo)
taskforge-authservice    → Authentication & authorization (coming soon)
taskforge-taskservice    → Projects & tasks (coming soon)
```
