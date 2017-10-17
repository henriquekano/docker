#!/bin/bash
OPENCART_VER=$1

echo $OPENCART_VER

PAGARME_API_CHECKOUT_VERSION=""
PAGARME_PG_CHECKOUT_VERSION=""
if [${OPENCART_VER:0:3} = "2.2"]; then
    echo "1"
    PAGARME_API_CHECKOUT_VERSION="2.2"
    PAGARME_PG_CHECKOUT_VERSION="2.x"
else if [${OPENCART_VER:0:3} = '1.5'] ; then
    echo "2"
    PAGARME_API_CHECKOUT_VERSION="1.5.x"
    PAGARME_PG_CHECKOUT_VERSION="1.5.x"
else
    echo "3"
    PAGARME_API_CHECKOUT_VERSION="2.x"
    PAGARME_PG_CHECKOUT_VERSION="2.x"
fi
fi

echo $PAGARME_API_CHECKOUT_VERSION
echo $PAGARME_PG_CHECKOUT_VERSION
PAGARME_MODULE_URL="https://github.com/pagarme/pagarme-opencart/archive/master.zip"
set -xe \
    && curl -sSL ${PAGARME_MODULE_URL} -o master.zip \
    && unzip master.zip \
    && rm ./master.zip \
    && cp -r pagarme-opencart-master/API/${PAGARME_API_CHECKOUT_VERSION}/upload/* ./ && cp -r pagarme-opencart-master/Checkout\ Pagar.Me/${PAGARME_PG_CHECKOUT_VERSION}/upload/* ./ \
    && rm -rf pagarme-opencart-master

