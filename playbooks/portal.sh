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
									servernaam="$klant-$omgeving-wbsrv0$id"
									echo "---------------------------"
									echo "$servernaam"
									echo "----------------------------"
									
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									;;
									
								2 )	echo -e '\0033\0143'
									id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam:"
									
									servernaam="$klant-$omgeving-wbsrv0$id"
									echo "---------------------------"
									echo "$servernaam"
									
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									printf "\n"
									servernaam="$klant-$omgeving-db0$id"
									
									echo "$servernaam"
									echo "----------------------------"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									;;
									
								3 )	
									echo -e '\0033\0143' 
									id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam:"
									echo "----------------------------"
									servernaam="$klant-$omgeving-wbsrv0$id"
									echo "$servernaam"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									printf "\n"
									id="2"
									servernaam="$klant-$omgeving-wbsrv0$id"
									echo "$servernaam"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									printf "\n"
									id="1"
									servernaam="$klant-$omgeving-lb0$id"
									echo "$servernaam"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									printf "\n"
									servernaam="$klant-$omgeving-db0$id"
									echo "$servernaam"
									mysql --login-path=local skylab<< EOF
									insert into customer (klant,omgeving,servernaam) values ('$klant' , 
									'$omgeving', '$servernaam');
EOF
									echo "----------------------------"
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