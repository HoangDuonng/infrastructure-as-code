# Infrastructure Inspection - Vultr Deployment

Terraform configuration để deploy infrastructure trên Vultr với Docker Compose và Nginx.

## Kiến trúc

- **Provider**: Vultr
- **OS**: Ubuntu 22.04 (Linux)
- **Container**: Docker + Docker Compose
- **Web Server**: Nginx
- **Applications**: NextJS (Frontend) + Spring Boot (Backend)

## Yêu cầu

- Terraform >= 1.0
- Vultr API Key

## Setup

1. **Clone repository**
   ```bash
   git clone <repo-url>
   cd infra-inspection
   ```

2. **Copy và config variables**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Init Terraform**
   ```bash
   terraform init
   ```

4. **Review và apply**
   ```bash
   terraform plan
   terraform apply
   ```

## Sau khi deploy

Sau khi `terraform apply` thành công:

1. **Server đã được setup với:**
   - Docker và Docker Compose đã được cài đặt
   - Thư mục `/srv/app/` đã được tạo với cấu trúc:
     - `/srv/app/nginx/` - Nginx config
     - `/srv/app/logs/` - Log files

2. **Tạo và copy config files lên server:**
   
   - `nginx.conf` - Cấu hình Nginx (proxy NextJS và Spring Boot)
   - `docker-compose.yml` - Cấu hình Docker Compose
   
   ```bash
   # Copy nginx.conf
   scp nginx.conf root@<SERVER_IP>:/srv/app/nginx/nginx.conf
   
   # Copy docker-compose.yml
   scp docker-compose.yml root@<SERVER_IP>:/srv/app/docker-compose.yml
   ```

3. **Copy application code:**
   ```bash
   # Copy NextJS frontend
   scp -r ./frontend root@<SERVER_IP>:/srv/app/
   
   # Copy Spring Boot backend
   scp -r ./backend root@<SERVER_IP>:/srv/app/
   ```

4. **SSH vào server và chạy:**
   ```bash
   ssh root@<SERVER_IP>
   cd /srv/app
   docker compose up -d
   ```

## Cấu trúc thư mục trên server

```
/srv/app/
├── nginx/
│   └── default.conf
├── logs/
├── frontend/          # NextJS code
├── backend/           # Spring Boot code
└── docker-compose.yml
```

## Lưu ý

- Firewall rules (UFW) sẽ tự động được config (ports: 22, 80, 443)
- Fail2ban được cài đặt để bảo vệ SSH

## Troubleshooting

### Kiểm tra Docker đã cài chưa
```bash
docker --version
docker compose version
```

### Xem logs của user-data script khi khởi tạo server để debug khi install tools
```bash
cat /var/log/cloud-init-output.log
```
### Xem logs của nginx 
```bash
access_log cat /var/log/nginx/access.log;
error_log cat /var/log/nginx/error.log warn;
```

### Kiểm tra services
```bash
cd /srv/app
docker compose ps
docker compose logs <name-container>
```
