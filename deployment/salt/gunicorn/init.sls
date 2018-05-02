gunicorn service file:
  file.managed:
    - name: /etc/systemd/system/gunicorn.service
    - source: salt://gunicorn/gunicorn.service
    
start gunicorn service:
  service.running:
    - name: gunicorn
    - watch:
      - file: /etc/systemd/system/gunicorn.service
