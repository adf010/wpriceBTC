#!/bin/bash
########################################
# BTC alert for high and/or low price  #
# 03/10/2024                           #
########################################

read -p "high " b
read -p "low " c

prod_id1="BTC-USD"
prod_id2="ETH-USD"

while true
do
sleep 3s
clear
echo "High =$b"
echo "Low =$c"

outputb=$(curl -L -s "https://api.exchange.coinbase.com/products/${prod_id1}/ticker" -H "Content-Type: application/json" | jq -r ".price" | sed -E 's/(.+)/$\1/' | tr -d '$')

outpute=$(curl -L -s "https://api.exchange.coinbase.com/products/${prod_id2}/ticker" -H "Content-Type: application/json" | jq -r ".price" | sed -E 's/(.+)/$\1/' | tr -d '$')

echo "$outputb" #"  $prod_id1"
echo "$outpute" #"   $prod_id2"
outputbtc="${outputb%.*}"
#echo "$outputbtc"

if [ "$outputbtc" -gt "$b" ]
then
    amixer -q set Master 85%
    mpv /usr/share/korganizer/sounds/alert.wav
    mpv /usr/share/sounds/sound-icons/trumpet-12.wav
    mpv /usr/lib/libreoffice/share/gallery/sounds/explos.wav
    amixer -q set Master 35%
read -p " " n   

elif [ "$outputbtc" -lt "$c" ]
then
    amixer -q set Master 85%
    mpv /usr/share/korganizer/sounds/alert.wav
    mpv /usr/share/sounds/sound-icons/trumpet-12.wav
    mpv /usr/lib/libreoffice/share/gallery/sounds/explos.wav
    amixer -q set Master 35%
read -p " " n
    
else
     echo "fail" > /dev/null
fi
done
