#!/bin/bash
echo -e '\0033\0143'
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@                                                       @"
echo "@ | SELF-SERVICE PORTAL | COENRAAD KEUNING | S1132172 | @"
echo "@                                                       @"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
printf "\n"
printf "\n"
printf "\n"
i=true;
while [[ $i == true ]]; do


	
printf "\n"
echo "      Maak een keuze"
echo "---------------------------"
echo "1)  Maak een omgeving"
echo "2)  Pas je omgeving aan"
echo "3)  Verwijder je omgeving"
echo "4)  Beëindig de sessie"

	read INPUT_STRING
	case $INPUT_STRING in
		1)	
			echo -e '\0033\0143'
			echo "In welke tier wilt u uw omgeving plaatsen?"
			echo "Maak een keuze"
			echo "---------------------------"
			echo "1) low"
			echo "2) mid"
			echo "3) high"

			read tier
			case $tier in

				
				
				1 )	
					echo -e '\0033\0143'
					echo "Voer uw naam in"
					read klant
					if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
						echo "-----------------------------------------------"
						printf "Uw omgeving bestaat al.\nStart de portal opnieuw en kies voor optie 3\n"
						echo "-----------------------------------------------"
						break
					else

					mkdir ~/HDD/VM2/klant/low/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/low/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
					touch ansible.cfg
					touch inventory
					printf "[defaults]\ninventory = inventory\nhost_key_checking = false" >> ansible.cfg
					printf "[all:vars]\nansible_python_interpreter=/usr/bin/python3\n\n" >> inventory
					printf "[webserver]\n\n\n\n[loadbalancer]\n\n\n\n[database]\n\n\n\n" >> inventory
					fi
					;;
			 	2 )	
					echo -e '\0033\0143'
					echo "Voer uw naam in"
					read klant
					if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
					
						echo "-----------------------------------------------"
						printf "Uw omgeving bestaat al.\nStart de portal opnieuw en kies voor optie 3\n"
						echo "-----------------------------------------------"
						break
					else
					mkdir ~/HDD/VM2/klant/mid/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/mid/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
					touch ansible.cfg
					touch inventory
					printf "[defaults]\ninventory = inventory\nhost_key_checking = false" >> ansible.cfg
					printf "[all:vars]\nansible_python_interpreter=/usr/bin/python3\n\n" >> inventory
					printf "[webserver]\n\n\n\n[loadbalancer]\n\n\n\n[database]\n\n\n\n" >> inventory
					fi
					;;
				3 )
					echo -e '\0033\0143'
					echo "Voer uw naam in"
					read klant
					if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
					
						echo "-----------------------------------------------"
						printf "Uw omgeving bestaat al.\nStart de portal opnieuw en kies voor optie 3\n"
						echo "-----------------------------------------------"
						break
					else
					mkdir ~/HDD/VM2/klant/high/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/high/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
					touch ansible.cfg
					touch inventory
					printf "[defaults]\ninventory = inventory\nhost_key_checking = false" >> ansible.cfg
					printf "[all:vars]\nansible_python_interpreter=/usr/bin/python3\n\n" >> inventory
					printf "[webserver]\n\n\n\n[loadbalancer]\n\n\n\n[database]\n\n\n\n" >> inventory
					fi
					;;
				* )	
					echo -e '\0033\0143'
					echo "----------------------------------------------------------------"
					echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
					echo "----------------------------------------------------------------"
					break
					;;
			esac

					
					echo "In wat voor omgeving wilt u uw omgeving plaatsen?"
					printf "\n"
					echo "Maak een keuze"
					echo "---------------------------"
					echo "Typ in : Productie"
					echo "Typ in : Test"

		      		  
					printf "\n"
					read omgeving
					case $omgeving in
						
					productie ) 
								echo -e '\0033\0143'
								echo "U heeft een test omgeving gekozen"
								printf "\n"
								printf "\n"
								;;
							
						test )	
								echo -e '\0033\0143'
								echo "U heeft een productie omgeving gekozen"
								printf "\n"
								printf "\n"
								;;

							* )	
								echo -e '\0033\0143'
								echo "----------------------------------------------------------------"
								echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
								echo "----------------------------------------------------------------"
								break
								;;
					esac
							echo -e '\0033\0143'
							echo "Kies het serverpakket"
							printf "\n"
							echo  "Maak een keuze"
							echo "-------------------------"
							echo "1)  Webserver"
							echo "2)  Webserver / Database"
							echo "3)  Webserver x2 / Loadbalancer / Database"
						    printf "\n"
						    read id 
						    case $id in
						    	1 )	
									echo -e '\0033\0143'
									echo "U heeft server pakket $id gekozen"
									echo "Uw server heeft de naam: "
									printf "\n"
									wbsrv1="$klant-$omgeving-wbsrv0$id"
									echo "---------------------------"
									echo "$wbsrv1"
									echo "---------------------------------------------"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$wbsrv1');
EOF
									
									echo "Uw server wordt gestart, moment alsublieft"
									echo "---------------------------------------------"
									if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
										cd ~/HDD/VM2/klant/low/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|192.168.20.5|' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
										vagrant up
									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|172.16.20.5|' Vagrantfile
										sed -i '5i\web01 ansible_host=172.1620.51' inventory
										vagrant up
									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|10.1.20.5|' Vagrantfile
										sed -i '5i|10.1.20.51' inventory
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
										vagrant up
									fi
									break
									;;
									
								2 )	echo -e '\0033\0143'
									id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam:"
									
									echo "---------------------------"
									wbsrv1="$klant-$omgeving-wbsrv0$id"
									echo "$wbsrv1"
									
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$wbsrv1');
EOF
									printf "\n"
									dbsrv1="$klant-$omgeving-dbsrv0$id"
									
									echo "$dbsrv1"
									echo "----------------------------"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$dbsrv1');
EOF
									
									echo "Uw server wordt gestart, moment alsublieft"
									echo "----------------------------"
									if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
										cd ~/HDD/VM2/klant/low/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|192.168.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
										sed -i '14i\db01 ansible_host=192.168.20.81' inventory
										vagrant up
									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|172.16.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=172.16.20.51' inventory
										sed -i '14i\db01 ansible_host=172.16.20.81' inventory
										vagrant up
									
									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|10.1.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
										sed -i '14i\db01 ansible_host=10.1.20.81' inventory
										vagrant up
									fi
									;;
									
								3 )	
									echo -e '\0033\0143' 
									id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam:"
									echo "----------------------------"
									wbsrv1="$klant-$omgeving-wbsrv0$id"
									echo "$wbsrv1"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$wbsrv1');
EOF
									printf "\n"
									id="2"
									wbsrv2="$klant-$omgeving-wbsrv0$id"
									echo "$wbsrv2"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$wbsrv2');
EOF
									printf "\n"
									id="1"
									lbsrv1="$klant-$omgeving-lb0$id"
									echo "$lbsrv1"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$lbsrv1');
EOF
									printf "\n"
									dbsrv1="$klant-$omgeving-db0$id"
									echo "$dbsrv1"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$dbsrv1');
EOF
									echo "----------------------------"
									if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
										cd ~/HDD/VM2/klant/low/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-web0#{q}|$wbsrv2|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|192.168.20.5|g' Vagrantfile
										sed -i 's|192.168.20.2|192.168.20.6|g' Vagrantfile
										sed -i 's|192.168.20.3|192.168.20.7|g' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
										sed -i '6i\web02 ansible_host=192.168.20.61' inventory
										sed -i '12i\lb01 ansible_host=192.168.20.71' inventory
										sed -i '17i\db01 ansible_host=192.168.20.81' inventory
										vagrant up

									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-web0#{q}|$wbsrv2|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|172.16.20.5|g' Vagrantfile
										sed -i 's|192.168.20.2|172.16.20.6|g' Vagrantfile
										sed -i 's|192.168.20.3|172.16.20.7|g' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=172.16.20.51' inventory
										sed -i '6i\web02 ansible_host=172.16.20.61' inventory
										sed -i '12i\lb01 ansible_host=172.16.20.71' inventory
										sed -i '17i\db01 ansible_host=172.16.20.81' inventory
										vagrant up

									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-web0#{q}|$wbsrv2|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.1|10.1.20.5|g' Vagrantfile
										sed -i 's|192.168.20.2|10.1.20.6|g' Vagrantfile
										sed -i 's|192.168.20.3|10.1.20.7|g' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.8|g' Vagrantfile
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
										sed -i '6i\web02 ansible_host=10.1.20.61' inventory
										sed -i '12i\lb01 ansible_host=10.1.20.71' inventory
										sed -i '17i\db01 ansible_host=10.1.20.81' inventory
										vagrant up

									fi
									;;
								* )	
									echo -e '\0033\0143'
									echo "----------------------------------------------------------------"
									echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
									echo "----------------------------------------------------------------"
									break
							esac
							;;
			2  )	echo -e '\0033\0143'
					echo "Typ uw naam in om je omgeving aan te passen!"
					read definitief1
					printf "\n"
					echo "----------------------------"
					echo "Typ uw tier in"
					read definitief2
					printf "\n"

					if [ -d "/home/vagrant/HDD/VM2/klant/$definitief2/$definitief1" ]; then
						echo -e '\0033\0143'
							echo "Kies het serverpakket"
							printf "\n"
							echo  "Maak een keuze"
							echo "-------------------------"
							echo "1)  Webserver"
							echo "2)  Webserver / Database"
							echo "3)  Webserver x2 / Loadbalancer / Database"
						    printf "\n"
						   	read id
						  	echo "----------------------------"
							echo "In wat voor omgeving wilt u uw omgeving plaatsen?"
							printf "\n"
							echo "Maak een keuze"
							echo "---------------------------"
							echo "Typ in : Productie"
							echo "Typ in : Test"
							read omgeving
							printf "\n"
							echo "Kies uit de volgende opties"
							printf "\n"
							echo  "Maak een keuze"
							echo "--------------------"
							echo "1)  1024 MB RAM"
							echo "2)  1536 MB RAM"
							echo "3)  2048 MB RAM"
							echo "--------------------"
							printf "\n"
							read ram



						cd ~/HDD/VM2/klant/$definitief2/$definitief1/
						echo "----------------------------"
						echo "uw omgeving wordt aangepast."
						echo "----------------------------"
						vagrant destroy --force
						rm -rf /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1
						mysql --login-path=local skylab<< EOF
						DELETE from customer where servernaam like '%$definitief1%';
EOF
						mkdir /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1
						cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
						cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
						vagrant init
						echo -e '\0033\0143'
						touch ansible.cfg
						touch inventory
						printf "[defaults]\ninventory = inventory\nhost_key_checking = false" >> ansible.cfg
						printf "[all:vars]\nansible_python_interpreter=/usr/bin/python3\n\n" >> inventory
						printf "[webserver]\n\n\n\n[loadbalancer]\n\n\n\n[database]\n\n\n\n" >> inventory
						case $id in
								1 )	cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
									id="1"
									wbsrv1="$definitief1-$omgeving-wbsrv0$id"
									sed -i '5s|2|1|' Vagrantfile
									sed -i '6s|0|0|' Vagrantfile
									sed -i '7s|1|0|' Vagrantfile
									sed -i '8s|1|0|' Vagrantfile
									sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
									if [[ $definitief2=="low" ]]; then
										sed -i 's|192.168.20.1|192.168.20.5|' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
									elif [[ $definitief=="mid" ]]; then
										sed -i 's|192.168.20.1|172.16.20.5|' Vagrantfile
										sed -i '5i\web01 ansible_host=172.16.20.51' inventory
									else
										sed -i 's|192.168.20.1|10.1.20.5|' Vagrantfile
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
									fi
									
									case $ram in
										1 ) 
												sed -i '16s|512|1024|' Vagrantfile
												sed -i '29s|512|1024|' Vagrantfile
												sed -i '42s|512|1024|' Vagrantfile
												sed -i '55s|512|1024|' Vagrantfile
												;;
										2 )
												sed -i '16s|512|1536|' Vagrantfile
												sed -i '29s|512|1536|' Vagrantfile
												sed -i '42s|512|1536|' Vagrantfile
												sed -i '55s|512|1536|' Vagrantfile

												;;												
										3 )	
												sed -i '16s|512|2048|' Vagrantfile
												sed -i '29s|512|2048|' Vagrantfile
												sed -i '42s|512|2048|' Vagrantfile
												sed -i '55s|512|2048|' Vagrantfile
										esac
										echo -e '\0033\0143'
										echo "--------------------"
										echo "Moment alstublieft"
										echo "--------------------"
										vagrant up
										;;
								2 ) 
									cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
									id="1"
									wbsrv1="$definitief1-$omgeving-wbsrv0$id"
									dbsrv1="$definitief1-$omgeving-dbsrv0$id"
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										
									if [[ $definitief2=="low" ]]; then
										sed -i 's|192.168.20.1|192.168.20.5|' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
										sed -i '14i\db01 ansible_host=192.168.20.81' inventory
									elif [[ $definitief2=="mid" ]]; then
										sed -i 's|192.168.20.1|172.16.20.5|' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=172.16.20.51' inventory
										sed -i '14i\db01 ansible_host=172.16.20.81' inventory
									else
										sed -i 's|192.168.20.1|10.1.20.5|' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
										sed -i '14i\db01 ansible_host=10.1.20.81' inventory
									fi
									case $ram in
										1 ) 
												sed -i '16s|512|1024|' Vagrantfile
												sed -i '29s|512|1024|' Vagrantfile
												sed -i '42s|512|1024|' Vagrantfile
												sed -i '55s|512|1024|' Vagrantfile
												;;
										2 )
												sed -i '16s|512|1536|' Vagrantfile
												sed -i '29s|512|1536|' Vagrantfile
												sed -i '42s|512|1536|' Vagrantfile
												sed -i '55s|512|1536|' Vagrantfile

												;;												
										3 )	
												sed -i '16s|512|2048|' Vagrantfile
												sed -i '29s|512|2048|' Vagrantfile
												sed -i '42s|512|2048|' Vagrantfile
												sed -i '55s|512|2048|' Vagrantfile
										esac
										echo -e '\0033\0143'
										echo "--------------------"
										echo "Moment alstublieft"
										echo "--------------------"
										vagrant up
										;;
								3 ) 
									cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
									id="1"
									wbsrv1="$definitief1-$omgeving-wbsrv0$id"
									id="2"
									wbsrv2="$definitief1-$omgeving-wbsrv0$id"
									id="1"
									lbsrv1="$definitief1-$omgeving-lbsrv0$id"
									dbsrv1="$definitief1-$omgeving-dbsrv0$id"
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i '8s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-web0#{q}|$wbsrv2|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										
									if [[ $definitief2=="low" ]]; then
										sed -i 's|192.168.20.1|192.168.20.5|' Vagrantfile
										sed -i 's|192.168.20.2|192.168.20.6|' Vagrantfile
										sed -i 's|192.168.20.3|192.168.20.7|' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=192.168.20.51' inventory
										sed -i '6i\web02 ansible_host=192.168.20.61' inventory
										sed -i '12i\lb01 ansible_host=192.168.20.71' inventory
										sed -i '17i\db01 ansible_host=192.168.20.81' inventory
									elif [[ $definitief2=="mid" ]]; then
										sed -i 's|192.168.20.1|172.16.20.5|' Vagrantfile
										sed -i 's|192.168.20.2|172.16.20.6|' Vagrantfile
										sed -i 's|192.168.20.3|172.16.20.7|' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=172.16.20.51' inventory
										sed -i '6i\web02 ansible_host=172.16.20.61' inventory
										sed -i '12i\lb01 ansible_host=172.16.20.71' inventory
										sed -i '17i\db01 ansible_host=172.16.20.81' inventory
									else
										sed -i 's|192.168.20.1|10.1.20.5|' Vagrantfile
										sed -i 's|192.168.20.2|10.1.20.6|' Vagrantfile
										sed -i 's|192.168.20.3|10.1.20.7|' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.8|' Vagrantfile
										sed -i '5i\web01 ansible_host=10.1.20.51' inventory
										sed -i '6i\web02 ansible_host=10.1.20.61' inventory
										sed -i '12i\lb01 ansible_host=10.1.20.71' inventory
										sed -i '17i\db01 ansible_host=10.1.20.81' inventory
									fi
									case $ram in
										1 ) 
												sed -i '16s|512|1024|' Vagrantfile
												sed -i '29s|512|1024|' Vagrantfile
												sed -i '42s|512|1024|' Vagrantfile
												sed -i '55s|512|1024|' Vagrantfile
												;;
										2 )
												sed -i '16s|512|1536|' Vagrantfile
												sed -i '29s|512|1536|' Vagrantfile
												sed -i '42s|512|1536|' Vagrantfile
												sed -i '55s|512|1536|' Vagrantfile

												;;												
										3 )	
												sed -i '16s|512|2048|' Vagrantfile
												sed -i '29s|512|2048|' Vagrantfile
												sed -i '42s|512|2048|' Vagrantfile
												sed -i '55s|512|2048|' Vagrantfile
										esac
										echo -e '\0033\0143'
										echo "--------------------"
										echo "Moment alstublieft"
										echo "--------------------"
										vagrant up
										;;

								* ) 
									echo -e '\0033\0143'
									echo "----------------------------------------------------------------"
									echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
									echo "----------------------------------------------------------------"
									break
								esac
						
						


						else
							echo "----------------------------------------"
							echo "U heeft de verkeerde gegevens in gevuld," 
							echo "of u heeft geen omgeving aangemaakt."
							echo "----------------------------------------"

						
							
						fi
						;;







			
			3) 	echo -e '\0033\0143'
				printf "\n"
				echo "Wilt u uw omgeving verwijderen?"
				printf "\n"
							echo  "Maak een keuze"
							echo "--------------------"
							echo "1)  Jazeker"
							echo "2)  Absoluut niet!"
				printf "\n"
				read delete
				case $delete in
					1 )
						echo -e '\0033\0143'
						echo "Weet u het zeker?"
						printf "\n"
							echo  "Maak een keuze"
							echo "--------------------"
							echo "1)  Nu verwijderen!"
							echo "2)  NOOIT!"
						
						read deleted
						case $deleted in
							1 )	
								echo -e '\0033\0143'
								echo "Typ uw naam in om het verwijderen te bevestigen!"
								read definitief1
								echo "----------------------------"
								printf "\n"
								echo "Typ uw tier in"
								read definitief2
								echo "----------------------------"
							

								case $definitief2 in
									low )	echo -e '\0033\0143'
											if [ -d "/home/vagrant/HDD/VM2/klant/$definitief2/$definitief1" ]; then
												cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
												vagrant destroy --force
												rm -rf /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1
												mysql --login-path=local skylab<< EOF
												DELETE from customer where servernaam like '%$definitief1%';
EOF
												echo "----------------------------"
												echo "Uw omgeving is verwijderd"
												echo "----------------------------"

												else
													echo "----------------------------------------"
													echo "U heeft de verkeerde gegevens in gevuld," 
													echo "of u heeft geen omgeving aangemaakt."
													echo "----------------------------------------"

											fi 
											;;
									mid )		echo -e '\0033\0143'
											if [ -d "/home/vagrant/HDD/VM2/klant/$definitief2/$definitief1" ]; then
												cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
												vagrant destroy --force
												rm -rf /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1
												mysql --login-path=local skylab<< EOF
												DELETE from customer where servernaam like '%$definitief1%';
EOF

												echo "----------------------------"
												echo "uw omgeving is verwijderd"
												echo "----------------------------"

												else
													echo "----------------------------------------"
													echo "U heeft de verkeerde gegevens in gevuld," 
													echo "of u heeft geen omgeving aangemaakt."
													echo "----------------------------------------"

											fi 	
											;;
									high ) 	echo -e '\0033\0143'
											if [ -d "/home/vagrant/HDD/VM2/klant/$definitief2/$definitief1" ]; then
												cd /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1/
												vagrant destroy --force
												rm -rf /home/vagrant/HDD/VM2/klant/$definitief2/$definitief1
												mysql --login-path=local skylab<< EOF
												DELETE from customer where servernaam like '%$definitief1%';
EOF
												echo "----------------------------"
												echo "uw omgeving is verwijderd"
												echo "----------------------------"

												else
													echo "----------------------------------------"
													echo "U heeft de verkeerde gegevens in gevuld," 
													echo "of u heeft geen omgeving aangemaakt."
													echo "----------------------------------------"

											fi 
											;;

									* )		
											echo -e '\0033\0143'
											echo "---------------------------------------------------------------------"
											echo " U heeft de verkeerde gegevens ingetypt, het portaal wordt gesloten"
											echo "---------------------------------------------------------------------"
											printf "\n"
											break
											;;
								esac
								;;
										
							* ) break
								;;
						esac
						;;

					* )	
						echo -e '\0033\0143'
						echo "----------------------------------------------------------------"
						echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
						echo "----------------------------------------------------------------"
						break
						;;

				esac
				;;



			4 )	

				echo -e '\0033\0143'
				;;
				
			
esac
			

printf "\n"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@                                                       @"
echo "@           WE HOPEN U SNEL WEER TE ZIEN                @"
echo "@                                                       @"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
i=false;
done