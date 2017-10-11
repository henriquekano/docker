FROM inblank/php5.4

RUN a2enmod rewrite

RUN set -xe \
    && apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev libmcrypt-dev unzip rsync\
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mcrypt mbstring mysqli mysql zip

WORKDIR /var/www/html

 # Download opencart
ENV OPENCART_VER 1.5.6.4
ENV OPENCART_URL https://github.com/opencart/opencart/archive/${OPENCART_VER}.tar.gz
ENV OPENCART_FILE opencart.tar.gz

RUN set -xe \
    && curl -sSL ${OPENCART_URL} -o ${OPENCART_FILE} \
    && echo "${OPENCART_MD5}  ${OPENCART_FILE}" \
    && tar xzf ${OPENCART_FILE} --strip 2 --wildcards '*/upload/' \
    && mv config-dist.php config.php \
    && mv admin/config-dist.php admin/config.php \
    && rm ${OPENCART_FILE} \
    && chown -R www-data:www-data .

 # Download pagarme code
ENV PAGARME_MODULE_URL https://github.com/pagarme/pagarme-opencart/archive/master.zip
RUN set -xe \
    && curl -sSL ${PAGARME_MODULE_URL} -o master.zip \
    && unzip master.zip \
    && rm ./master.zip \
    && cp -r pagarme-opencart-master/API/1.5.x/upload/* ./ && cp -r pagarme-opencart-master/Checkout\ Pagar.Me/1.5.x/upload/* ./ \
    && rm -rf pagarme-opencart-master

RUN set -xe \
    && mv config-dist.php config.php
    && mv admin/config-dist.php admin/config.php
