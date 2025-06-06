
Frontend Microservice – RoboShop

The **Frontend** microservice provides the web interface for the RoboShop application. It's a static web application served via **Nginx** and acts as the entry point to all backend services.

---

## 🚀 Tech Stack

* Web Server: **Nginx 1.24**
* Static Site Content: **HTML/CSS/JS**
* Reverse Proxy Config: **To Backend APIs**

---

## 📌 Prerequisites

* RHEL / CentOS / Rocky Linux 9+
* `dnf` package manager
* IP addresses of backend services

---

## 📦 Install Nginx

```bash
dnf module list nginx               # View available versions
dnf module disable nginx -y         # Disable default module
dnf module enable nginx:1.24 -y     # Enable required version
dnf install nginx -y                # Install Nginx
```

---

## ⚙️ Start and Enable Nginx

```bash
systemctl enable nginx
systemctl start nginx
```

> ✅ Try accessing the server IP via browser (e.g. `http://<server-ip>`) — you should see the default Nginx welcome page.

---

## 🧹 Remove Default Content

```bash
rm -rf /usr/share/nginx/html/*
```

---

## 📥 Download and Extract Frontend Code

```bash
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
```

> 🔁 Refresh your browser — you should now see the **RoboShop frontend UI**.

---

## 🔄 Nginx Reverse Proxy Configuration

Edit the Nginx main config file:

```bash
vim /etc/nginx/nginx.conf
```

Paste the following configuration:

```nginx
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log notice;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        listen       [::]:80;
        server_name  _;

        root         /usr/share/nginx/html;
        include      /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html { }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html { }

        location /images/ {
            expires 5s;
            root /usr/share/nginx/html;
            try_files $uri /images/placeholder.jpg;
        }

        location /api/catalogue/  { proxy_pass http://<CATALOGUE-IP>:8080/; }
        location /api/user/       { proxy_pass http://<USER-IP>:8080/; }
        location /api/cart/       { proxy_pass http://<CART-IP>:8080/; }
        location /api/shipping/   { proxy_pass http://<SHIPPING-IP>:8080/; }
        location /api/payment/    { proxy_pass http://<PAYMENT-IP>:8080/; }

        location /health {
            stub_status on;
            access_log off;
        }
    }
}
```

> ⚠️ **Important:** Replace `localhost` or placeholder IPs (`<CATALOGUE-IP>`, etc.) with **actual IP addresses** of backend services.

---

## 🔁 Restart Nginx to Apply Configuration

```bash
systemctl restart nginx
```
