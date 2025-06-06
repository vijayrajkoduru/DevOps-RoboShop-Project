
---

# 🗃️ MongoDB Setup – RoboShop

MongoDB is a popular **NoSQL document-based database** used in the RoboShop microservices architecture to store unstructured or semi-structured data in JSON-like format.

---

## 📌 Why MongoDB?

MongoDB allows flexible schemas, horizontal scaling, and fast development cycles — making it suitable for cloud-native applications like RoboShop.

---

## 🧾 SQL vs NoSQL (MongoDB) Quick Comparison

| Feature            | SQL (Relational DB)   | NoSQL (MongoDB - Document DB)              |
| ------------------ | --------------------- | ------------------------------------------ |
| **Structure**      | Tables (rows/columns) | Documents inside Collections               |
| **Schema**         | Fixed schema          | Schema-less (Flexible)                     |
| **Query Language** | SQL                   | MQL (MongoDB Query Language)               |
| **Use Cases**      | Banking, ERP, CRM     | E-commerce, IoT, Analytics, Real-time apps |
| **Examples**       | MySQL, PostgreSQL     | MongoDB, CouchDB, Amazon DocumentDB        |

---

## 🧪 Sample Document

```json
{
  "_id": "6638fa12345abc",
  "name": "Alice",
  "age": 30,
  "skills": ["Java", "DevOps"],
  "address": {
    "city": "Hyderabad",
    "zip": "500001"
  }
}
```

---

## 📦 Install MongoDB (Version 7.x)

### Step 1: Create MongoDB YUM Repository

Create file:

```bash
vim /etc/yum.repos.d/mongo.repo
```

Paste the following content:

```ini
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
enabled=1
gpgcheck=0
```

---

### Step 2: Install MongoDB

```bash
dnf install mongodb-org -y
```

---

### Step 3: Enable and Start MongoDB

```bash
systemctl enable mongod
systemctl start mongod
```

> ✅ MongoDB service should now be running locally.

---

### Step 4: Enable External Connections

By default, MongoDB binds only to `127.0.0.1` (localhost). To allow access from other services or servers:

```bash
vim /etc/mongod.conf
```

Find and modify this line:

```yaml
bindIp: 127.0.0.1
```

Change it to:

```yaml
bindIp: 0.0.0.0
```

> ⚠️ This allows external services to connect to MongoDB. Ensure appropriate firewall and security rules are applied.

---

### Step 5: Restart MongoDB to Apply Changes

```bash
systemctl restart mongod
```

---
## 📍 Default MongoDB Port

| Component | Port  |
| --------- | ----- |
| MongoDB   | 27017 |

