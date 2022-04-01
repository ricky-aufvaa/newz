cachedir="$HOME/news"
city=$(printf "%s" "$*")
menu="fzf --reverse"
url=$(curl -s https://www.hindustantimes.com/cities/$city-news > $cachedir/tmp.html)
title=$(cat $cachedir/tmp.html | grep -n '"name":' |tail -n 30| sed 's/":"/ /' | cut -b 11-| rev | cut -b 3-| rev | $menu)
#cat $cachedir/tmp.txt
if [[ $title ]];then
final=$(cat $cachedir/tmp.html | grep "${title}" -B 2 | grep 'url":'| sed 's/":"/ /' | cut -b 6-| rev | cut -b 3- | rev)
#echo $final
firefox $final
else 
	echo "Goodbye then"
fi
