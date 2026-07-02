# Hướng dẫn Setup Multi-Environment (Dev, Staging, Prod) - Terraform Version 2

Tài liệu này hướng dẫn cách nâng cấp dự án `todo` hiện tại lên cấu trúc đa môi trường (Multi-Environment) một cách chuyên nghiệp, an toàn, không lộ key và dễ dàng quản lý.

---

## 1. Phương pháp: Tách biệt bằng Thư mục (Directory-based Segregation)

Đây là phương pháp chuẩn chỉnh nhất trong doanh nghiệp vì nó đảm bảo tính **cô lập hoàn toàn (Isolation)**. Mỗi môi trường (Dev, Staging, Prod) sẽ có một thư mục riêng, chạy một file State riêng, thậm chí deploy lên các GCP Project hoàn toàn độc lập để tránh thao tác nhầm lẫn gây sập hệ thống Production.

### Cấu trúc thư mục mới đề xuất:

```text
todo/
├── environments/
│   ├── dev/
│   │   ├── main.tf             # Gọi các module gcp, truyền biến cho dev
│   │   ├── variables.tf        # Khai báo biến đầu vào cho dev
│   │   ├── terraform.tfvars    # Cấu hình giá trị cụ thể cho dev (Bị gitignore)
│   │   └── providers.tf        # Định nghĩa GCP provider cho dev
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── providers.tf
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── providers.tf
├── modules/                    # Nơi lưu trữ các module dùng chung (Đã viết ở ver 1)
│   └── gcp/
│       ├── vpc/
│       ├── gke/
│       ├── iam/
│       ├── artifact-registry/
│       └── secrets/
└── MULTI_ENVIRONMENT_GUIDE.md  # File hướng dẫn này
```

---

## 2. Quy tắc thiết kế An toàn & Sạch sẽ (Clean & Secure IaC)

Để đảm bảo dự án không bị nguy hiểm, bạn cần tuân thủ nghiêm ngặt 3 nguyên tắc sau:

### Nguyên tắc 1: Tách biệt Project GCP (Khuyên dùng)
* **Tuyệt đối không** dùng chung 1 GCP Project cho cả Dev và Prod. Nếu bạn nhỡ tay chạy `terraform destroy` ở môi trường Dev, nó có thể xóa sạch cơ sở dữ liệu và cluster của Production.
* Mỗi môi trường nên trỏ vào một `project_id` riêng biệt trong file `terraform.tfvars`:
  * Dev: `todo-dev-12345`
  * Staging: `todo-staging-12345`
  * Prod: `todo-prod-12345`

### Nguyên tắc 2: Đặt tên tài nguyên động theo Môi trường (Resource Naming)
* Mọi tài nguyên như VPC, GKE Cluster, Service Account cần được gắn hậu tố môi trường để dễ phân biệt và tránh trùng lặp.
* Ví dụ:
  * VPC: `todo-vpc-dev`, `todo-vpc-staging`, `todo-vpc-prod`.
  * Cluster: `todo-cluster-dev`, `todo-cluster-staging`, `todo-cluster-prod`.

### Nguyên tắc 3: Bảo mật trạng thái (State File Security)
* Dù chạy ở local, file `terraform.tfstate` của từng môi trường phải nằm riêng trong thư mục của môi trường đó (Ví dụ: `environments/dev/terraform.tfstate`).
* Đảm bảo file `.gitignore` ở gốc dự án luôn chặn `*.tfstate` và `*.tfvars` để tránh đẩy thông tin nhạy cảm lên Github.

---

## 3. Cấu trúc Code mẫu cho môi trường DEV

Dưới đây là cách viết code cho thư mục `environments/dev/`:

### A. File `environments/dev/main.tf`
Bạn gọi các module từ thư mục chung `/modules/gcp/` bằng đường dẫn tương đối (`../../modules/gcp/...`).

```terraform
# Cấu hình môi trường dev gọi các module dùng chung
module "vpc" {
  source      = "../../modules/gcp/vpc"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = "todo-vpc-dev"
  subnet_name = "todo-subnet-dev"
}

module "gke" {
  source             = "../../modules/gcp/gke"
  project_id         = var.project_id
  region             = var.region
  zone               = var.zone
  cluster_name       = "todo-cluster-dev"
  network            = module.vpc.network_self_link
  subnetwork         = module.vpc.subnet_self_link
  pods_cidr_name     = module.vpc.pods_cidr_name
  services_cidr_name = module.vpc.services_cidr_name
  machine_type       = var.gke_machine_type
  node_count         = var.gke_node_count
}

module "iam" {
  source     = "../../modules/gcp/iam"
  project_id = var.project_id
  gsa_name   = "todo-sa-dev"
}

module "artifact_registry" {
  source     = "../../modules/gcp/artifact-registry"
  project_id = var.project_id
  region     = var.region
  repo_name  = "todo-repo-dev"
}

module "secrets" {
  source                    = "../../modules/gcp/secrets"
  project_id                = var.project_id
  external_secrets_sa_email = module.iam.external_secrets_sa_email
}
```

### B. File `environments/dev/terraform.tfvars`
Nơi bạn thiết lập cấu hình nhỏ gọn, tiết kiệm chi phí cho môi trường Dev:

```terraform
project_id       = "todo-dev-12345"
region           = "asia-southeast1"
zone             = "asia-southeast1-a"
gke_machine_type = "e2-medium"  # Sử dụng máy nhỏ vừa đủ cho dev
gke_node_count   = 2           # Giảm số lượng node xuống 2 để tiết kiệm chi phí
```

### C. File `environments/prod/terraform.tfvars` (So sánh với Dev)
Nơi bạn cấu hình mạnh mẽ, sẵn sàng chịu tải cao cho Production:

```terraform
project_id       = "todo-prod-99999"
region           = "asia-southeast1"
zone             = "asia-southeast1-a"
gke_machine_type = "e2-standard-2" # Sử dụng loại VM mạnh hơn cho Prod
gke_node_count   = 3              # Tối thiểu 3 node để đảm bảo High Availability (HA)
```

---

## 4. Hướng dẫn các bước vận hành thực tế

Khi muốn thao tác trên bất kỳ môi trường nào, bạn bắt buộc phải truy cập vào thư mục của môi trường đó để thực thi lệnh.

### Thao tác trên môi trường Dev:
```bash
# 1. Di chuyển vào thư mục dev
cd environments/dev

# 2. Khởi tạo Terraform để load các module chung
terraform init

# 3. Xem trước các tài nguyên sẽ được tạo
terraform plan

# 4. Triển khai hạ tầng
terraform apply
```

### Thao tác trên môi trường Prod:
```bash
# 1. Di chuyển vào thư mục prod
cd ../prod

# 2. Khởi tạo
terraform init

# 3. Triển khai
terraform apply
```

Cách thiết kế này giúp bạn có thể phát triển tính năng mới ở môi trường `dev` (ví dụ: sửa đổi code module VPC hoặc GKE), kiểm thử ổn định rồi mới cập nhật vào môi trường `prod` một cách an toàn tuyệt đối.
