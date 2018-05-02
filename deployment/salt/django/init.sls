# apache2:               ID declaration
#  pkg:                 state declaration
#    - installed        function declaration

# apcalc
#  pkg:
#    - installed

prereqs:
  pkg.installed:
    - pkgs:
#      - apache2
#      - libapache2-mod-wsgi-py3
      - nginx
      - python3
      - build-essential
      - libssl-dev
      - libffi-dev
      - python3-dev

python-pip:
  pkg.installed:
    - pkgs:
      - python-pip
      - python3-pip

gunicorn:
  pip.installed:
    - bin_env: '/usr/bin/pip3'
    - pkgs:
      - gunicorn

django:
  pip.installed:
    - pkgs:
      - gunicorn
    - requirements: /root/website/requirements.txt
    - bin_env: '/usr/bin/pip3'
#    - pkgs:
#      - django
#      - djangorestframework

#    - require:
#      - pkg: python-pip
      
      
