# Infrastructure Inspection - Vultr Deployment

Terraform configuration to deploy infrastructure on Vultr with Docker Compose and Nginx.

## Architecture

- Provider: Vultr
- OS: Ubuntu 22.04 (Linux)
- Containerization: Docker + Docker Compose
- Web Server: Nginx
- Applications: NextJS (Frontend) + Spring Boot (Backend)

## Requirements

- Terraform >= 1.0
- Vultr API Key

## Deployment

1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd infra-inspection
   ```

2. Copy and configure variables:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Apply the configuration:
   ```bash
   terraform plan
   terraform apply
   ```

## Post-Deployment

After execution:

1. Server state:
   - Docker and Docker Compose are installed.
   - The directory `/srv/app/` is initialized with:
     - `/srv/app/nginx/` - Nginx configuration.
     - `/srv/app/logs/` - Log storage.

2. Transfer configuration files to the server:
   - `nginx.conf` - Nginx proxy rules for NextJS and Spring Boot.
   - `docker-compose.yml` - Container stack definition.

   ```bash
   scp nginx.conf root@<SERVER_IP>:/srv/app/nginx/nginx.conf
   scp docker-compose.yml root@<SERVER_IP>:/srv/app/docker-compose.yml
   ```

3. Transfer application source code:
   ```bash
   scp -r ./frontend root@<SERVER_IP>:/srv/app/
   scp -r ./backend root@<SERVER_IP>:/srv/app/
   ```

4. Connect to the server and execute the application:
   ```bash
   ssh root@<SERVER_IP>
   cd /srv/app
   docker compose up -d
   ```

## Target Directory Structure

```
/srv/app/
├── nginx/
│   └── default.conf
├── logs/
├── frontend/          # NextJS application
├── backend/           # Spring Boot application
└── docker-compose.yml
```

## System Configurations

- Firewall rules (UFW) permit traffic on ports 22, 80, and 443.
- Fail2ban is installed to secure SSH.

## Troubleshooting

### Verify Installation Status
```bash
docker --version
docker compose version
```

### Inspect Cloud-Init Log
```bash
cat /var/log/cloud-init-output.log
```

### Access Nginx Logs
```bash
cat /var/log/nginx/access.log
cat /var/log/nginx/error.log
```

### Monitor Container Status
```bash
cd /srv/app
docker compose ps
docker compose logs <container-name>
```
