Here’s a well-structured and professional **GitHub-ready presentation** for setting up **MySQL 8.x** in the RoboShop project:

---

# 📦 MySQL Setup – RoboShop Project

The **MySQL** database is used to store structured data in the **RoboShop** application. The developer has chosen **MySQL 8.x**, and this guide helps you install and configure it properly.

---

## 🔧 Step-by-Step MySQL Installation & Configuration

### 🧱 1. Install MySQL Server

Install the **MySQL 8.x** server using DNF:

```bash
dnf install mysql-server -y
```

---

### 🔁 2. Start & Enable MySQL Service

Enable and start the MySQL service so it runs on boot:

```bash
systemctl enable mysqld
systemctl start mysqld
```

---

### 🔑 3. Secure MySQL Installation

You need to set the root password and apply security settings.

> 💡 Use the password: `RoboShop@1` (or a secure one of your choice)

```bash
mysql_secure_installation --set-root-pass RoboShop@1
```

