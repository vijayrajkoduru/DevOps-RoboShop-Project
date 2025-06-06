
---

# 🧑‍💻 User Service Setup for RoboShop

This microservice handles User Logins and Registrations.

---

## 🔍 Technology & Version Info

* Language: **NodeJS**
* Required NodeJS Version: **> 20** (default on system is 16)

---

## 🛠 Install NodeJS 20

Check available modules:

```bash
dnf module list
```

Disable default NodeJS module and enable version 20:

```bash
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
```

Install NodeJS:

```bash
dnf install nodejs -y
```

---

## 👤 Create Application User

Run app as non-root:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

> **Note:**
> User `roboshop` is a daemon user and not used for login.

---

## 📂 Setup Application Directory

```bash
mkdir /app
```

---

## 📥 Download & Extract Application Code

```bash
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip
```

---

## 📦 Install Dependencies

```bash
cd /app
npm install
```

---

## ⚙️ Setup systemd Service

Create `/etc/systemd/system/user.service` with:

```ini
[Unit]
Description=User Service

[Service]
User=roboshop
Environment=MONGO=true
Environment=REDIS_URL='redis://<REDIS-IP-ADDRESS>:6379'
Environment=MONGO_URL="mongodb://<MONGODB-SERVER-IP-ADDRESS>:27017/users"
ExecStart=/bin/node /app/server.js
SyslogIdentifier=user

[Install]
WantedBy=multi-user.target
```

> Replace `<REDIS-IP-ADDRESS>` and `<MONGODB-SERVER-IP-ADDRESS>` with actual IP addresses.

Create file with:

```bash
vim /etc/systemd/system/user.service
```

---

## 🔄 Reload systemd & Start Service

```bash
systemctl daemon-reload
systemctl enable user
systemctl start user
```

---