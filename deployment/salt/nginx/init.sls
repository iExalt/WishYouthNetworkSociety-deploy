nginx service file:
  file.managed:
    - name: /etc/nginx/sites-available/website
    - source: salt://nginx/website
    - template: jinja
    - defaults:
      VAR_SERVER_NAME: {{ grains['ip_interfaces']['eth0'][0] }}
      
symlink available to enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/website
    - target: /etc/nginx/sites-available/website
    - force: True

#delete default file:
#  file.absent:
#    - name: /etc/nginx/sites-available/default
    
change folder ownership:
  file.directory:
    - name: /root/website/hyperlink
    - user: root
    - group: www-data
    - mode: 755
    - recurse:
      - user
      - group
      - mode

change wsgi.py permissions:
  file.managed:
    - name: /root/website/hyperlink/wsgi.py
    - user: root
    - group: root
    - mode: 755
    
start nginx service:
  service.running:
    - name: nginx
    - watch:
      - file: /etc/systemd/system/gunicorn.service

