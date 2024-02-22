#!/bin/bash
sudo -i
yum install httpd -y
systemctl start  httpd
systemctl enable httpd
echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
</head>
<body >
    <div><h1>Hello !!</h1></div>
    <div><h2>This is Home Page</h2></div>
    <div>
        <a href="/mobile/index.html"><button>Mobile</button></a>
    </div>
</body>
</html>" > /var/www/html/index.html

systemctl restart httpd