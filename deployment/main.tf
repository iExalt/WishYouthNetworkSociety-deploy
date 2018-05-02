resource "digitalocean_droplet" "django" {
  image = "ubuntu-16-04-x64"
  name = "website-test"
  region = "tor1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = "${var.ssh_fingerprint}"
  
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "echo lol"
    ]
  }
  
  provisioner "file" {
    source = "${path.root}/payload/hyperlink"
    destination = "/root/website"
  }
  
  provisioner "salt-masterless" {
    local_state_tree = "${path.module}/salt"
    remote_state_tree = "/srv/salt"
    no_exit_on_failure = "true"
  }
    

  provisioner "remote-exec" {
    inline = [
      "ufw allow 'Nginx Full'",
      "chmod +x /root",
      "chown www-data /root/website",
      "chmod 664 /root/website/db.sqlite3",
      "chown :www-data /root/website/db.sqlite3",
      "chmod +x /root/website/hyperlink",
      "chmod +x /root/website/hyperlink/wsgi.py",
    ]
  }
  
}

output "instance_IP" {
  value ="${digitalocean_droplet.django.ipv4_address}"
}
 
