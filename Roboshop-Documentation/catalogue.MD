

# 📦 Catalogue Microservice – RoboShop

The **Catalogue** service is responsible for listing the products on the RoboShop e-commerce platform.

---

## 🚀 Tech Stack

* Node.js (v20+)
* MongoDB (Client + Schema Load)
* SystemD (Linux Service Manager)

---

## 📌 Prerequisites

Ensure you have:

* RHEL / CentOS / Rocky Linux 9+
* `dnf` package manager
* MongoDB server IP address

---

## 🔧 Node.js Installation (v20+)

> Default available version is 16. We need v20+.

```bash
dnf module list nodejs          # List available versions
dnf module disable nodejs -y    # Disable default
dnf module enable nodejs:20 -y  # Enable NodeJS v20
dnf install nodejs -y           # Install NodeJS
```

---

## 👤 Add Roboshop Application User

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

---

## 📂 Application Setup

```bash
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
npm install
```

---

## ⚙️ SystemD Service Setup

> Create and configure systemd unit file:

```bash
vim /etc/systemd/system/catalogue.service
```

Paste the following:

```ini
[Unit]
Description = Catalogue Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IPADDRESS>:27017/catalogue"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=catalogue

[Install]
WantedBy=multi-user.target
```

> Replace `<MONGODB-SERVER-IPADDRESS>` with actual IP.

---

### ✅ Start & Enable Catalogue Service

```bash
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
```

---

## 🧠 Load Master Data into MongoDB

### 🧩 MongoDB Client Installation

```bash
vim /etc/yum.repos.d/mongo.repo
```

Paste:

```ini
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0
```

Then install:

```bash
dnf install mongodb-mongosh -y
```

### 📥 Load Schema

```bash
mongosh --host <MONGODB-SERVER-IPADDRESS> </app/db/master-data.js
```

---

## 🔍 Verify MongoDB Data Load

```bash
mongosh --host <MONGODB-SERVER-IPADDRESS>
```

```mongodb
show dbs
use catalogue
show collections
db.products.find()
```

---

## 🌐 Final Step – Update Frontend Config

Update **catalogue** IP in the following file:

```bash
vim /etc/nginx/nginx.conf
```

---