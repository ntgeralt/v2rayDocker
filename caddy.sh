#!/bin/bash
# FILE="/etc/Caddy"
domain="$1"
psname="$2"
#uuid=$(uuidgen)
cat > /etc/Caddyfile <<'EOF'
domain
{
  log ./caddy.log
  proxy /a98aa :61234 {
    websocket
    header_upstream -Origin
  }
}

EOF
sed -i "s/domain/${domain}/" /etc/Caddyfile

# v2ray
cat > /etc/v2ray/config.json <<'EOF'
{
  "inbounds": [
    {
      "port": 61234,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "6f0a2e13-2d0d-4382-8618-a98aaa06290e",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/a98aa"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}

EOF

#sed -i "s/uuid/${uuid}/" /etc/v2ray/config.json

cat > /srv/sebs.js <<'EOF'
 {
    "add":"domain",
    "aid":"0",
    "host":"",
    "id":"6f0a2e13-2d0d-4382-8618-a98aaa06290e",
    "net":"ws",
    "path":"/a98aa",
    "port":"443",
    "ps":"sebsclub",
    "tls":"tls",
    "type":"none",
    "v":"2"
  }
EOF

if [ "$psname" != "" ] && [ "$psname" != "-c" ]; then
  sed -i "s/sebsclub/${psname}/" /srv/sebs.js
  sed -i "s/domain/${domain}/" /srv/sebs.js
  sed -i "s/uuid/${uuid}/" /srv/sebs.js
else
  $*
fi
pwd
cp /etc/Caddyfile .
nohup /bin/parent caddy  --log stdout --agree=false &
cat /etc/v2ray/config.json
node v2ray.js
/usr/bin/v2ray -config /etc/v2ray/config.json
