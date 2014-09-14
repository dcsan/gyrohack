
TGT="gyrotanks.meteor.com"
cd app && meteor deploy $TGT


## after cd app we have to cd back?
cd -

# give meteor time to restart
sleep 10
curl "${TGT}/reset"

meteor logs redes.meteor.com
