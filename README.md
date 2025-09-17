# 06016423 INFRASTRUCTURE PROGRAMMABILITY AND AUTOMATION (1/2025)

## ข้อมูลสถานศึกษา
**สถานศึกษา:** สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง  
**คณะ:** เทคโนโลยีสารสนเทศ  
**สาขา:** เทคโนโลยีสารสนเทศ  
**แขนง:** โครงสร้างพื้นฐานเทคโนโลยีสารสนเทศ

## ข้อมูลนักศึกษา
**ชื่อ-นามสกุล:** นายธันยา วรมงคล  
**รหัสนักศึกษา:** 66070091

## การติดตั้ง Terraform

### สำหรับ Windows
1. ดาวน์โหลด Terraform จาก [https://www.terraform.io/downloads](https://www.terraform.io/downloads)
2. แตกไฟล์ zip และย้าย `terraform.exe` ไปยังโฟลเดอร์ที่อยู่ใน PATH (เช่น `C:\terraform`)
3. เข้าไปที่ `Edit system environment variables` (คลิกขวาที่ Start Menu เลือก System > Advanced system settings) เลือก `Environment Variables` เลือก Variable `Path` ในส่วนของ `System variables` จากนั้นกด `Edit` แล้วกด `New` และใส่ PATH ของ Terraform ลงไป (เช่น `C:\terraform`)
4. เปิด Command Prompt หรือ PowerShell และตรวจสอบการติดตั้งด้วยคำสั่ง:
   ```bash
   terraform --version
   ```

### สำหรับ macOS
```bash
# ใช้ Homebrew
brew install terraform

# หรือดาวน์โหลดไฟล์ binary จาก official website
```

### สำหรับ Linux (Ubuntu/Debian)
```bash
# เพิ่ม HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# เพิ่ม repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# ติดตั้ง Terraform
sudo apt-get update && sudo apt-get install terraform
```

## การตั้งค่า AWS Credentials

1. **Copy ไฟล์ตัวอย่าง:**
   ```bash
   copy terraform.tfvars.example terraform.tfvars
   ```
   หรือใน Linux/macOS:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **แก้ไขไฟล์ `terraform.tfvars`** และใส่ข้อมูล AWS credentials ของคุณ:
   ```hcl
   access_key = "your-aws-access-key"
   secret_key = "your-aws-secret-key"
   token      = "your-aws-session-token"  # ถ้ามี
   ```

   > **⚠️ คำเตือน:** ไม่ควร commit ไฟล์ `terraform.tfvars` ที่มี credentials จริงลง Git repository

## คำสั่งในการรัน Terraform

ใช้คำสั่งต่อไปนี้ตามลำดับ:

### 1. เริ่มต้น Terraform
```bash
terraform init
```
คำสั่งนี้จะดาวน์โหลด provider และ module ที่จำเป็น

### 2. ตรวจสอบ syntax
```bash
terraform validate
```
ตรวจสอบว่า configuration files มี syntax ที่ถูกต้อง

### 3. จัดรูปแบบโค้ด
```bash
terraform fmt
```
จัดรูปแบบโค้ดให้เป็นมาตรฐาน

### 4. ดูแผนการเปลี่ยนแปลง
```bash
terraform plan
```
แสดงรายการ resources ที่จะถูกสร้าง แก้ไข หรือลบ

### 5. ประยุกต์ใช้การเปลี่ยนแปลง
```bash
terraform apply
```
สร้าง/แก้ไข infrastructure ตามที่กำหนดไว้

### 6. ลบ resources (เมื่อต้องการ)
```bash
terraform destroy
```
ลบ resources ทั้งหมดที่ถูกสร้างโดย Terraform

## โครงสร้างโปรเจกต์

```
Assignment-1/
├── terraform.tfvars.example    # ตัวอย่างไฟล์ variables
├── terraform.tfvars           # ไฟล์ variables จริง (ไม่ควร commit)
├── week-11-terraform.tf       # Main configuration file
├── terraform.tfstate          # State file (สร้างหลังจาก apply)
└── terraform.tfstate.backup   # Backup ของ state file
```

## หมายเหตุ

- ตรวจสอบว่าได้ติดตั้ง AWS CLI และตั้งค่า credentials แล้ว
- ใช้คำสั่ง `terraform plan` ก่อน `terraform apply` เสมอ เพื่อตรวจสอบการเปลี่ยนแปลง
- เก็บไฟล์ `.tfstate` ไว้อย่างปลอดภัย เนื่องจากเป็นไฟล์สำคัญในการจัดการ infrastructure