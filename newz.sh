cachedir="$HOME/testing/news"
menu="fzf --reverse"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#f77e7e,bg:#292323,hl:#4cdb85 --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json?limit=100 | jq '.' > $cachedir/tmp.html
title=$(curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/news/.json?limit=100 | jq '.' | grep  '"title"'| cut -d' ' -f12- |cut -b 2-| rev | cut -b 3-| rev | tail -n +2 | $menu)
echo $title
if [[ $title ]];then
url=$(cat $cachedir/tmp.html | grep "${title}" -A 70 | grep 'url_overridden_by_dest'| awk '{print $2}' |cut -b 2-| rev | cut -b 4- | rev)  
firefox $url
else
	echo "Goodbye then"
fi
