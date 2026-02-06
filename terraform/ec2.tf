resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0fc5d935ebf8bc3bc"   # Ubuntu 22.04
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[count.index].id
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.id]
 
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
 
    # Install Ansible + Web stack
    apt install -y ansible apache2 php git
 
    # Create Ansible playbook locally
    mkdir -p /opt/ansible
    cat <<PLAYBOOK > /opt/ansible/web.yml
    - hosts: localhost
      become: yes
      tasks:
        - name: Copy app
          copy:
            src: /opt/app/
            dest: /var/www/html/
    PLAYBOOK
 
    # Create application
    mkdir -p /opt/app
    cat <<APP > /opt/app/index.php
<?php
    echo "<h1>Welcome to Streamline - v1</h1>";
    echo "<p>Server IP: " . $_SERVER['SERVER_ADDR'] . "</p>";
    ?>
    APP
 
    # Run Ansible locally
    ansible-playbook /opt/ansible/web.yml
  EOF
}
