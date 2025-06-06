
---

# 🐇 RabbitMQ Setup for RoboShop

RabbitMQ is a messaging queue used by some components of the RoboShop application.

---

## 📌 Version Info

* Developer has shared RabbitMQ version: **3.x**

---

## ⚙️ Step-by-Step Installation & Configuration

### 1. Setup RabbitMQ Repository

Create the repo file at `/etc/yum.repos.d/rabbitmq.repo`:

```bash
vim /etc/yum.repos.d/rabbitmq.repo
```

Paste the following content:

```ini
[modern-erlang]
name=modern-erlang-el9
baseurl=https://yum1.novemberain.com/erlang/el/9/$basearch
        https://yum2.novemberain.com/erlang/el/9/$basearch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/rpm/el/9/$basearch
enabled=1
gpgcheck=0

[modern-erlang-noarch]
name=modern-erlang-el9-noarch
baseurl=https://yum1.novemberain.com/erlang/el/9/noarch
        https://yum2.novemberain.com/erlang/el/9/noarch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/rpm/el/9/noarch
enabled=1
gpgcheck=0

[modern-erlang-source]
name=modern-erlang-el9-source
baseurl=https://yum1.novemberain.com/erlang/el/9/SRPMS
        https://yum2.novemberain.com/erlang/el/9/SRPMS
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/rpm/el/9/SRPMS
enabled=1
gpgcheck=0

[rabbitmq-el9]
name=rabbitmq-el9
baseurl=https://yum2.novemberain.com/rabbitmq/el/9/$basearch
        https://yum1.novemberain.com/rabbitmq/el/9/$basearch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/rpm/el/9/$basearch
enabled=1
gpgcheck=0

[rabbitmq-el9-noarch]
name=rabbitmq-el9-noarch
baseurl=https://yum2.novemberain.com/rabbitmq/el/9/noarch
        https://yum1.novemberain.com/rabbitmq/el/9/noarch
        https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/rpm/el/9/noarch
enabled=1
gpgcheck=0
```

---

### 2. Install RabbitMQ Server

```bash
dnf install rabbitmq-server -y
```

---

### 3. Enable and Start RabbitMQ Service

```bash
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
```

---

### 4. Configure RabbitMQ User

The default user `guest/guest` cannot be used for external connections. Create a new user for RoboShop:

```bash
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
```

---

## ✅ Important Notes

* Always create a dedicated user for your applications instead of using the default `guest`.
* Replace username and password as per your security policies.

---