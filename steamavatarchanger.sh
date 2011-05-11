#!/bin/bash
# Steam Avatar Changer by Harry Strongburg < h -a- harry dot lu >
# Changes Steamcommunity profile avatar every $howOften seconds.
#
# How to use: put valid jpgs (between 100x100 and 1280x1280 pixels
# width*heigh, and less than 200k filesize) in current script directory.
# Then fill in the required cookie information below (fetch it via
# Firefox - if you don't know how to do this part, then tough luck), and
# finally run the script though bash.
#
# Notes: Do not run this too often or with a really short delay; I am
# sure it is not polite on Valve's servers to do so.
#
# ToDo: make more "smart" with cookie handling / form passing.

MACHAUTH="steamMachineAuthNUMBERS=MORENUMBERS" # steamMachineAuth cookie name and contents (INCLUDE steamMachineAuth= part when copying!)
STEAMLOGIN="TONSOFNUMBERS" # steamLogin cookie contents.
STEAMLANG="english" # Steam_Language cookie, default works.
sID="7656119numbers" # steamcommunity ID (steamcommunity/profiles/7656119.....).
howOften="30" # How long to wait between changing avatar (in seconds)
yourAgent="Mozilla/5.0 (X11; Linux i686; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" # browser useragent

while true
do
IMAGE=$(ls . | grep jpg | shuf -n1);
echo $IMAGE;
curl -H "Cookie: $MACHAUTH; Steam_Language=$STEAMLANG; steamLogin=$STEAMLOGIN" -vvv -A "$yourAgent" --max-time 30 --max-filesize 204800 -F "type=player_avatar_image" -F "sId=$sID" -F "doSub=1" -F "avatar=@$IMAGE" -F "submitBTN=Upload" "http://steamcommunity.com/actions/FileUploader?type=player_avatar_image&sId=$sID&bgColor=262627"
sleep $howOften;
done;
