#adapted from the default file
server {
    listen 80;
    listen [::]:80;

    root /home/emily/www/hw01;

    index index.html;

    server_name hw01.daaaamndaniel.coffee;

    location / {
        try_files $uri $uri/ =404;

    }
}
