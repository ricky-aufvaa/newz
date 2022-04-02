mkdir $HOME/news
cachedir="$HOME/news"
city=$(printf "%s" "$*")
menu="fzf --reverse"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#f77e7e,bg:#292323,hl:#4cdb85 --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
if [ $# -eq 0 ];
then
	curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json?limit=100 | jq '.' > $cachedir/tmp.html
	title=$(curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json?limit=100 | jq '.' | grep  '"title"'| cut -d' ' -f12- |cut -b 2-| rev | cut -b 3-| rev | tail -n +2 | $menu)
	echo $title
	if [[ $title ]];then
		url=$(cat $cachedir/tmp.html | grep "${title}" -A 70 | grep 'url_overridden_by_dest'| awk '{print $2}' |cut -b 2-| rev | cut -b 4- | rev)  
		firefox $url
	#	else
	#		echo "Goodbye then"
		fi
else 
	url=$(curl -s https://www.hindustantimes.com/cities/$city-news > $cachedir/tmp.html)
	title=$(cat $cachedir/tmp.html | grep -n '"name":' |tail -n 30| sed 's/":"/ /' | cut -b 11-| rev | cut -b 3-| rev | $menu)
#	cat $cachedir/tmp.txt
	if [[ $title ]];then
	final=$(cat $cachedir/tmp.html | grep "${title}" -B 2 | grep 'url":'| sed 's/":"/ /' | cut -b 6-| rev | cut -b 3- | rev)
	firefox $final
	else
	echo "Goodbye then"
	fi
fi
