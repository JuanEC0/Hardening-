sys1=$(hostnamectl | sudo grep "CentOS" | wc -c)
sys2=$(hostnamectl | sudo grep "Ubuntu" | wc -c)

echo "El sistema operativo es:"
if [ "$sys1" != "0" ];
        then
                echo "CentOS"
                echo "Instalando repositorio EPEL"
                sudo yum -y install epel-release
                echo "Repositorio EPEL instalado"
                programa1=$(yum list installed | sudo grep "clamav")
                if [ -z "$programa1" ];
                then
                        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                else
                        echo "Se detendra y se desinstalara ClamAV."
                        sudo systemctl stop clamav-freshclam
                        sudo yum -y remove clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                        echo "El programa se ha detenido y removido. Se instalara ClamAV nuevamente."
                        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                        echo "Se ha completado la instalacion de ClamAV."

                sudo yum update
                fi
elif [ "$sys2" != "0" ];
        then
                echo "Ubuntu"
                programa2=$(apt list --installed | sudo grep "clamav")
                if [ -z "$programa2" ];
                then
                        sudo apt-get install clamav clamav-daemon -y
                else
                        echo "Se detendra y se desinstalara ClamAV."
                        sudo systemctl stop clamav-freshclam
                        sudo apt-get remove clamav clamav-daemon -y
                        echo "El programa se ha detenido y removido. Se instalara ClamAV nuevamente."
                        sudo apt-get install clamav clamav-daemon -y
                        echo "Se ha completado la instalacion de ClamAV."
                sudo apt upgrade
        fi
fi
