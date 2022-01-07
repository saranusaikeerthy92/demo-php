sudo yum install docker -y
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo USER=$2 PASS=$3 docker login -u $USER -p $PASS
sudo IMAGE=$1 docker-compose -f docker-compose.yml up -d