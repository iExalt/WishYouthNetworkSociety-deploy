Create self-signed certificate:
    cmd.run:
        - name: openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
        - stateful: True
        
Create DH group:
    cmd.run
        - name: openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
        - stateful: True
        
nginx SSL service file:
  file.managed:
    - name: /etc/nginx/sites-available/website
    - source: salt://ssl/website
    - template: jinja
    - defaults:
      VAR_SERVER_NAME: {{ grains['ip_interfaces']['eth0'][0] }}

start nginx service:
  service.running:
    - name: nginx
