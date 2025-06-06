
Dispatch Microservice – RoboShop

The **Dispatch** microservice is responsible for dispatching products after a successful purchase in the RoboShop e-commerce platform.

---

## 🚀 Tech Stack

* 🛠️ Language: GoLang
* 🕹️ Message Queue: RabbitMQ
* 🧑‍💻 SystemD Service Management

---

## 📌 Prerequisites

Ensure your system has:

* RHEL / CentOS / Rocky Linux 9+
* `dnf` package manager
* RabbitMQ server IP

---

## 🔧 Install GoLang

```bash
dnf install golang -y
```

> ✅ Confirm the version with your developer. Default `dnf` usually installs the latest stable available.

---

## 👤 Add Roboshop Application User

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

---

## 📂 Application Setup

```bash
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip
```

---

## 📦 Build the Application (GoLang)

```bash
cd /app
go mod init dispatch
go get
go build
```

---

## ⚙️ SystemD Service Configuration

> Create the systemd service file:

```bash
vim /etc/systemd/system/dispatch.service
```

Paste the following:

```ini
[Unit]
Description = Dispatch Service

[Service]
User=roboshop
Environment=AMQP_HOST=RABBITMQ-IP
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=roboshop123
ExecStart=/app/dispatch
SyslogIdentifier=dispatch

[Install]
WantedBy=multi-user.target
```

> 🔁 Replace `RABBITMQ-IP` with your actual RabbitMQ server IP.

---

## ✅ Start & Enable the Service

```bash
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
```

---