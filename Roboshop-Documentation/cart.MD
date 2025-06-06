# 🛒 Cart Microservice Deployment Guide

---

## 📦 Step 1: Install Node.js 20+

> By default, Node.js 16 is available. The Cart service requires Node.js **version 20 or later**.

### 🔧 Commands:

```bash
dnf module list nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
```

---

## 👤 Step 2: Create Application User

> Applications should never run as `root`. We'll create a secure, non-login system user.

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

🔐 `roboshop` is a **daemon user**, ideal for managing microservices.

---

## 📂 Step 3: Set Up Application Directory

Create the required directory and download the Cart source code.

```bash
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip
```

Install Node.js dependencies:

```bash
cd /app
npm install
```

---

## ⚙️ Step 4: Create systemd Service File

We use `systemd` to manage the Cart microservice.

### 📄 Create `/etc/systemd/system/cart.service` with the following content:

```ini
[Unit]
Description=Cart Service

[Service]
User=roboshop
Environment=REDIS_HOST=<REDIS-SERVER-IP>
Environment=CATALOGUE_HOST=<CATALOGUE-SERVER-IP>
Environment=CATALOGUE_PORT=8080
ExecStart=/bin/node /app/server.js
SyslogIdentifier=cart

[Install]
WantedBy=multi-user.target
```

📝 **Note**: Replace `<REDIS-SERVER-IP>` and `<CATALOGUE-SERVER-IP>` with actual IP addresses.

---

## 🚀 Step 5: Enable and Start Cart Service

Reload systemd to recognize the new service, then enable and start it:

```bash
systemctl daemon-reload
systemctl enable cart
systemctl start cart
```

---

## ✅ Summary

| Task                    | Description                        |
| ----------------------- | ---------------------------------- |
| Node.js Version         | 20+                                |
| Application User        | `roboshop` (non-login system user) |
| Application Location    | `/app`                             |
| Dependency Installation | `npm install` inside `/app`        |
| Service Manager         | `systemd` using `cart.service`     |

This setup ensures a secure, modular, and production-ready deployment for the Cart microservice, following best DevOps practices.

---

> 💡 For enhancements, integrate centralized logging and monitoring for long-term maintenance.
