#!/bin/bash
sudo amazon-linux-extras install nginx1
sudo systemctl enable nginx
sudo service nginx start
cd /usr/share/nginx/html
sudo chmod 777 index.html
echo "<html>
<body>
<p>hostname is: $(hostname)</p>
</body>
</html>" > index.html