
TGT="gyrotanks.meteor.com"
cd app && meteor deploy $TGT --settings private/config/prod.json

## after cd app we have to cd back?
cd -

# give meteor time to restart
sleep 5
curl "${TGT}/reset"

meteor logs redes.meteor.com
