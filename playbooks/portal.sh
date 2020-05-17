#!/bin/bash
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
echo "2)  Verwijder je omgeving"
echo "3)  Beëindig de sessie"

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
					mkdir ~/HDD/VM2/klant/low/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/low/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
					
					;;
			 	2 )	
					echo -e '\0033\0143'
					echo "Voer uw naam in"
					read klant
					mkdir ~/HDD/VM2/klant/mid/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/mid/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
					;;
				3 )
					echo -e '\0033\0143'
					echo "Voer uw naam in"
					read klant
					mkdir ~/HDD/VM2/klant/high/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					cd ~/HDD/VM2/klant/high/$klant/
					vagrant init
					cp /home/vagrant/HDD/VM2/klant/low/klant1/productie/Vagrantfile Vagrantfile
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
									echo "----------------------------"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$wbsrv1');
EOF
									
									echo "Uw server wordt gestart, moment alsublieft"
									echo "----------------------------"
									if [ -d "/home/vagrant/HDD/VM2/klant/low/$klant" ]; then
										cd ~/HDD/VM2/klant/low/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|192.168.20.5|' Vagrantfile
										vagrant up
									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|172.16.20.5|' Vagrantfile
										vagrant up
									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|0|0|' Vagrantfile
										sed -i '7s|1|0|' Vagrantfile
										sed -i '8s|1|0|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|10.1.20.5|' Vagrantfile
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
									dbsrv1="$klant-$omgeving-db0$id"
									
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
										sed -i '6s|1|0|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|192.168.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.7|g' Vagrantfile
										vagrant up
									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|1|0|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|172.16.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.7|g' Vagrantfile
										vagrant up
									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|1|0|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|10.1.20.5|g' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.7|g' Vagrantfile
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
										sed -i '6s|1|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|192.168.20.5|g' Vagrantfile
										sed -i 's|192.168.20.3|192.168.20.6|g' Vagrantfile
										sed -i 's|192.168.20.4|192.168.20.7|g' Vagrantfile
										vagrant up
										sed -i "s|klant1-productie-web0#{i}|$wbsrv2|g" Vagrantfile
										sed -i 's|192.168.20.5#{i}|192.168.20.52|g' Vagrantfile
										vagrant up --provision

									elif [ -d "/home/vagrant/HDD/VM2/klant/mid/$klant" ]; then
										cd ~/HDD/VM2/klant/mid/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|1|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|172.16.20.5|g' Vagrantfile
										sed -i 's|192.168.20.3|172.16.20.6|g' Vagrantfile
										sed -i 's|192.168.20.4|172.16.20.7|g' Vagrantfile
										vagrant up
										sed -i "s|klant1-productie-web0#{i}|$wbsrv2|g" Vagrantfile
										sed -i 's|192.168.20.5#{i}|172.16.20.52|g' Vagrantfile
										vagrant up --provision
									else 
										cd ~/HDD/VM2/klant/high/$klant/
										sed -i '5s|2|1|' Vagrantfile
										sed -i '6s|1|1|' Vagrantfile
										sed -i '7s|1|1|' Vagrantfile
										sed -i "s|klant1-productie-web0#{i}|$wbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-lb0#{y}|$lbsrv1|g" Vagrantfile
										sed -i "s|klant1-productie-db0#{x}|$dbsrv1|g" Vagrantfile
										sed -i 's|192.168.20.2|10.1.20.5|g' Vagrantfile
										sed -i 's|192.168.20.3|10.1.20.6|g' Vagrantfile
										sed -i 's|192.168.20.4|10.1.20.7|g' Vagrantfile
										vagrant up
										sed -i "s|$wbsrv1|$wbsrv2|g" Vagrantfile
										sed -i 's|192.168.20.5#{i}|10.1.20.52|g' Vagrantfile
										vagrant up --provision
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
						
			2) 	echo -e '\0033\0143'
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
												echo "uw omgeving is verwijderd"
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
												sed -i "s|$wbsrv2|$wbsrv1|g" Vagrantfile
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
												sed -i "s|$wbsrv2|$wbsrv1|g" Vagrantfile
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

			3 )	
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