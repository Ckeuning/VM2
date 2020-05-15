#!/bin/bash
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@                                                       @"
echo "@ | SELF-SERVICE PORTAL | COENRAAD KEUNING | S1132172 | @"
echo "@                                                       @"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
printf "\n"
printf "\n"
printf "\n"

echo "      Maak een keuze"
echo "---------------------------"
echo "1)  Maak een omgeving"
echo "2)  Verwijder je omgeving"
echo "3)  Beëindig de sessie"

while :
do
	read INPUT_STRING
	case $INPUT_STRING in
		1)
			echo "In welke tier wilt u uw omgeving plaatsen?"
			echo "Maak een keuze"
			echo "---------------------------"
			echo "1) low"
			echo "2) mid"
			echo "3) high"
			read tier
			case $tier in
				1 ) 
					echo "Voer uw naam in"
					read klant
					#mkdir ~/HDD/VM2/klant/low/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					#cd ~/HDD/VM2/klant/low/$klant/
					#vagrant init
					;;
			 	2 )
					echo "Voer uw naam in"
					read klant
					#mkdir ~/HDD/VM2/klant/mid/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					#cd ~/HDD/VM2/klant/mid/$klant/
					#vagrant init
					;;
				3 )
					echo "Voer uw naam in"
					read klant
					#mkdir ~/HDD/VM2/klant/high/$klant
					printf "\n"
					echo "Uw directory is aangemaakt"
					printf "\n"
					#cd ~/HDD/VM2/klant/high/$klant/
					#vagrant init
					;;
				* )	echo "----------------------------------------------------------------"
					echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
					echo "----------------------------------------------------------------"
					break
					;;
			esac

					printf "\n"
					printf "\n"
					printf "\n"
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
							echo "U heeft een test omgeving gekozen"
							printf "\n"
							printf "\n"
							;;
						test )	
							echo "U heeft een productie omgeving gekozen"
							printf "\n"
							printf "\n"
							;;
						* )	echo "----------------------------------------------------------------"
							echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
							echo "----------------------------------------------------------------"
							break
							;;	
					esac
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
						    	1 )	printf "\n"
									echo "U heeft server pakket $id gekozen"
									echo "Uw server heeft de naam: "
									printf "\n"
									echo "$klant-$omgeving-wbsrv0$id"
									echo "----------------------------"
									;;
									
								2 )	printf "\n"	
									id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam:"
									echo "----------------------------"
									echo "$klant-$omgeving-wbsrv0$id"
									printf "\n"
									echo "$klant-$omgeving-db0$id"
									echo "----------------------------"
									;;
									
								3 )	id="1"
									echo "U heeft server pakket $id gekozen"
									echo "Uw servers hebben de naam: "
									echo "----------------------------"
									echo "$klant-$omgeving-wbsrv0$id "
									printf "\n"
									id="2"
									echo "$klant-$omgeving-wbsrv0$id "
									printf "\n"
									id="1"
									echo "$klant-$omgeving-lb0$id "
									printf "\n"
									echo "$klant-$omgeving-db0$id "
									echo "----------------------------"
									;;



								* )	echo "----------------------------------------------------------------"
									echo " U heeft de verkeerde optie gekozen, het portaal wordt gesloten"
									echo "----------------------------------------------------------------"
									break
									;;
									
									
						    esac

					esac
	


done

printf "\n"
printf "\n"
printf "\n"

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@                                                       @"
echo "@           WE HOPEN U SNEL WEER TE ZIEN                @"
echo "@                                                       @"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
