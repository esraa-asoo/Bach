#!/usr/bin/env bash
#Esraa Arafa Ahmed
#Function to create directory named by the current year
year_dir(){
       mkdir ~/Reports/$(date +%Y)
       for x in {1..12}
do
       mkdir ~/Reports/$(date +%Y) /$x
done
}

#Function to create directores for the month & days in the year

file(){
       if [ ! -e ~/Reports/$(date +%Y)/$(date +%m) /$(date +%d).xls ]
then
       echo >> ~/Reports/$(date +%Y) /$ (date +%m) /$ (date +%d) .xls
fi
}
#check if all directorys & files are exist
      if [ -d ~/Reports ] 
then 
      echo " Reports exist checking year..."

      if [ ! -d ~/Reports/$(date +%Y) ] 
then
      echo " Year is not exist creating year directory... "
      #Calling the function to make directory
      year_dir
      #Calling the function to creat file in the year dir
      file
      echo "The file $(date +⅝d).xls is in ~/Reports/$(date +%Y)/$(date +%m)"

else
     echo "Year is exist..."
     echo "creating File $(date +%d) .xls"
     #Calling the function to creat files in the year dir
     file
     echo "The file $(date +d) .xls is in ~/Reports/$(date +%Y)/$(date +%m)"
fi
else 
     echo "creating Reports directory..."
     mkdir ~/Reports
     echo "Creating backups directory..."
     mkdir ~/backups 
     year dir 
     file
     echo "The file $(date +%d).xls is in ~/Reports/$(date +%Y)/$(date +%m)"
fi

#bonus
if [ $(date +%I) - lt 5 ] || [ $(date +%I) -eq 12 ] && [ $(date +%p) == "AM" ]
then
     echo "backups done..."
     cp -г ~/Reports ~/backups

else 
     echo " You can not backup now...backup start from 12AM to 5AM "
fi
