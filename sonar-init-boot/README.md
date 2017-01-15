Substitua a última linha do arquivo sonar com o path do sonar.sh (/sonar/server/sonarqube-5.6/bin/linux-x86-64/sonar.sh start)

Adicione o arquivo sonar ao path /etc/init.d e atualize o rc.d
```shell
sudo cp sonar /etc/init.d/sonar
sudo chmod 755 /etc/init.d/sonar
sudo update-rc.d sonar defaults
```
