
---

# 🟥 Redis Setup for RoboShop

Redis is an open-source, in-memory data store used as a database and cache. Known for ultra-fast performance due to its in-memory RAM architecture. It uses a simple key-value model but supports complex data types.

---

## 📌 Version Info

* Check with developer for the required Redis version.
* By default, Redis 6 is available, but we will enable and install Redis 7.

---

## ⚙️ Installation & Configuration Steps

### 1. Enable Redis 7 Module

```bash
dnf module disable redis -y
dnf module enable redis:7 -y
```

---

### 2. Install Redis

```bash
dnf install redis -y
```

---

### 3. Update Redis Configuration

By default, Redis listens on `127.0.0.1` (localhost), restricting access only to the local server.

To allow remote access, update the following in `/etc/redis/redis.conf`:

* Change the `bind` address from `127.0.0.1` to `0.0.0.0`
* Set `protected-mode` from `yes` to `no`

Edit the file using:

```bash
vim /etc/redis/redis.conf
```

---

### 4. Start & Enable Redis Service

```bash
systemctl enable redis
systemctl start redis
```
