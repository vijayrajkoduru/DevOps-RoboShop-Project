
---

# 💳 Payment Service – RoboShop Project

The **Payment** service handles all payment-related operations in the RoboShop e-commerce platform. This service is developed in **Python 3.x**, and needs to be manually configured as it is not shipped as an RPM.

---

## 🔧 Step-by-Step Setup

### 🐍 1. Install Python 3 and Dependencies

Install Python 3, along with development headers and GCC for building Python packages:

```bash
dnf install python3 gcc python3-devel -y
```

---

### 👤 2. Create Application User

Create a system user named `roboshop` to run the application securely:

```bash
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
```

> 🛑 **Note:** This user will not have login access. It is strictly used for running services.

---

### 📁 3. Set Up Application Directory

Create the standard application directory:

```bash
mkdir /app
```

---

### 📥 4. Download and Extract Payment Service Code

Fetch the source code and extract it into `/app`:

```bash
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip
```

---

### 📦 5. Install Python Dependencies

Move to the app directory and install all required Python libraries:

```bash
cd /app
pip3 install -r requirements.txt
```

---

### ⚙️ 6. Configure systemd Service

Create a new systemd service file at `/etc/systemd/system/payment.service`:

```ini
[Unit]
Description=Payment Service

[Service]
User=root
WorkingDirectory=/app
Environment=CART_HOST=<CART-SERVER-IPADDRESS>
Environment=CART_PORT=8080
Environment=USER_HOST=<USER-SERVER-IPADDRESS>
Environment=USER_PORT=8080
Environment=AMQP_HOST=<RABBITMQ-SERVER-IPADDRESS>
Environment=AMQP_USER=roboshop
Environment=AMQP_PASS=roboshop123
ExecStart=/usr/local/bin/uwsgi --ini payment.ini
ExecStop=/bin/kill -9 $MAINPID
SyslogIdentifier=payment

[Install]
WantedBy=multi-user.target
```

> 🧠 **Reminder:** Replace `<CART-SERVER-IPADDRESS>`, `<USER-SERVER-IPADDRESS>`, and `<RABBITMQ-SERVER-IPADDRESS>` with actual IPs.

---

### 🔄 7. Start & Enable the Service

Reload systemd to recognize the new service, then enable and start it:

```bash
systemctl daemon-reload
systemctl enable payment
systemctl start payment
```

---