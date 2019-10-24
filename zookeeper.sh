sudo yum install java wget -y
export JAVA_HOME=/opt/jdk1.8.0_232
export JRE_HOME=/opt/jdk1.8.0_232/jre
export PATH=$PATH:/opt/jdk1.8.0_232/bin:/opt/jdk1.8.0_232/jre/bin
cd /opt
sudo wget http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz
sudo tar -zxf zookeeper-3.4.14.tar.gz 
cd zookeeper-3.4.14
sudo mkdir data
cd conf/
sudo mv zoo_sample.cfg zoo.cfg
sudo export ip=/path/to/zookeeper/data
sudo export id=/tmp/zookeeper
sudo sed -i 's/dataDir='$id'/dataDir='$ip'/' zoo.cfg
sudo sed -i 's/initLimit=10/initLimit=5' zoo.cfg
sudo sed -i 's/syncLimit=5/syncLimit=2' zoo.cfg
cd /opt/zookeeper-3.4.14
sudo bin/zkServer.sh start
sudo bin/zkCli.sh
