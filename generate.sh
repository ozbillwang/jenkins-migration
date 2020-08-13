#!/usr/bin/bash

#set -ex

if [ $# -lt 1 ]; then
    echo "Usage: $0 [FQDN]"
    exit 1
fi

FQDN=$1

KEYDIR=CERT-$(date +%Y-%m%d-%H%M%S)
mkdir -p "$KEYDIR"

CONFIG=$KEYDIR/$FQDN.cnf
ALTNAME=${FQDN%%.*}

cat > $CONFIG << EOF
oid_section = OIDs

[ OIDs ]
certificateTemplateName = 1.3.6.1.4.1.311.20.2

[ req ]
default_bits = 4096
prompt = no
default_md = sha512
distinguished_name = req_dn
req_extensions = req_ext

[ req_dn ]
CN=$FQDN
O=fake
OU=IT
L=Sdyney
ST=NSW
C=AU

[ req_ext ]
certificateTemplateName = ASN1:PRINTABLESTRING:MutualSSL
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $FQDN
DNS.2 = $ALTNAME

EOF

if [ -f $CONFIG ]; then
  echo "Generating CSR for $FQDN"
  openssl req -newkey rsa:4096 -nodes -days 3650 -keyout $KEYDIR/$FQDN.key -out $KEYDIR/$FQDN.csr -config $CONFIG
else
  echo "ERROR: Not a file - $CONFIG"
fi
