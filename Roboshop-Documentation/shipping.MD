
---

# 🚚 Shipping Service Setup for RoboShop

Shipping service calculates package distances and shipping prices. It is written in **Java**, so Java and Maven are required.

---

## 📌 Prerequisites

* Java version ≥ 1.8
* Maven version ≥ 3.5

---

## ⚙️ Install Maven (includes Java)

```bash
dnf install maven -y
```

---

## 👤 Create Application User

Run applications as a non-root user:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

---

## 📁 Setup Application Directory

```bash
mkdir /app
```

---

## 📥 Download & Extract Application Code

```bash
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
```

---

## 📦 Build Application and Rename JAR

```bash
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
```

---

## ⚙️ Setup systemd Service

Create the systemd service file `/etc/systemd/system/shipping.service`:

```ini
[Unit]
Description=Shipping Service

[Service]
User=roboshop
Environment=CART_ENDPOINT=<CART-SERVER-IPADDRESS>:8080
Environment=DB_HOST=<MYSQL-SERVER-IPADDRESS>
ExecStart=/bin/java -jar /app/shipping.jar
SyslogIdentifier=shipping

[Install]
WantedBy=multi-user.target
```

*Replace `<CART-SERVER-IPADDRESS>` and `<MYSQL-SERVER-IPADDRESS>` with actual IP addresses.*

Create file using:

```bash
vim /etc/systemd/system/shipping.service
```

---

## 🔄 Reload systemd & Start Service

```bash
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
```

---

## 🗄️ Load Database Schema & Data

1. Install MySQL client:

```bash
dnf install mysql -y
```

2. Load schema:

```bash
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
```

3. Create app user:

```bash
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql
```

4. Load master data (countries, cities, distances):

```bash
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql
```

---

## 🔄 Restart Shipping Service After DB Setup

```bash
systemctl restart shipping
```

---
