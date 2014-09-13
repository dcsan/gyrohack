# bin/update-wiki.sh


cd app && meteor deploy --settings private/config/prod.json redes.meteor.com

## after cd app we have to cd back?
cd -

# give meteor time to restart
sleep 5

bin/prod-reload-all.sh

meteor logs redes.meteor.com
