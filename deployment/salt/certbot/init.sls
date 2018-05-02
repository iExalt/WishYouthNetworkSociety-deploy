get certbot-auto:
    cmd.run:
        - name: wget https://dl.eff.org/certbot-auto && chmod a+x certbot-auto && mv certbot-auto /usr/local/bin
        - stateful: True
        
run certbot-auto:
    cmd.run:
        - name: certbot-auto --nginx --non-interactive --agree-tos --email cklliaw@uwaterloo.ca
