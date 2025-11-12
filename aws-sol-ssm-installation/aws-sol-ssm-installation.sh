#!/bin/bash
#Date: 12/11/2025
#The following solution can be used to connect to any Amazon linux instance and install SSM automatically.

#!/bin/bash


# Function to send help, because everyone needs help
send_help() {
    echo "Usage:"
    echo "./$0 --ip <IP_EC2> --pem <RUTA_CLAVE_PEM>"
    echo
    echo "Parameters:"
    echo "  1.ip    EC2 instance IP (public or private)"
    echo "  2.pem   path to .pem file"
    echo
    echo "Example:"
    echo "  $0 54.123.45.67 /path/to/pem/file"
    exit 1
}

# Parameter validation
if [[ "$1" == "--help" ]]; then
    send_help
fi

if [[ $# -lt 2 ]]; then
    echo "try to pass --help as parameter to get more information" 
    exit 1
fi

#ssh connection and commands
ssh -i $1 ec2-user@$2 /bin/bash << EOF
#install ssh agent
sudo yum install -y amazon-ssm-agent
#enable service, so when machine is rebooted service goes up automatically
sudo systemctl enable amazon-ssm-agent
#start service now
sudo systemctl start amazon-ssm-agent
EOF
