#!/bin/bash
git clone --quiet https://github.com/sgtpep/pmenu
mkdir cache

cachedir="./cache"
menu="./pmenu/pmenu"
curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json | jq '.' > $cachedir/tmp.html
title=$(curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json?limit=100 | jq '.' | grep  '"title"'| cut -d' ' -f12- |cut -b 2-| rev | cut -b 3-| rev | tail -n +2 | $menu)
echo $title
if [[ $title ]];then
url=$(cat $cachedir/tmp.html | grep "${title}" -A 70 | grep 'url_overridden_by_dest'| awk '{print $2}' |cut -b 2-| rev | cut -b 4- | rev)  
termux-open-url $url
else
	echo "Goodbye then"
fi
