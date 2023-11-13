# Use Alpine as base image
FROM alpine:3.15

LABEL description="fbcallrouter - An extended call routing for AVM FRITZ!Box."

# Install PHP and Composer
RUN apk --update add wget \ 
    curl \
    git \
    gettext \
    php7 \
    php7-curl \
    php7-openssl \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-phar \
    php7-xml \
    php7-simplexml \
    php7-xmlwriter \
    php7-tokenizer \
    php7-soap \
    php7-sockets \
    php7-dom --repository http://nl.alpinelinux.org/alpine/edge/testing/ && rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

# Clone the repository and install dependencies
# RUN git clone https://github.com/blacksenator/fbcallrouter.git /fbcallrouter
WORKDIR /fbcallrouter
COPY . /fbcallrouter
RUN composer install

ENV FRITZ_URL='fritz.box' \
    FRITZ_USER='admin' \
    FRITZ_PASS='changeme' \
    PHONEBOOK_WHITELIST='0' \
    PHONEBOOK_BLACKLIST='1' \
    PHONEBOOK_NEWLIST='0' \
    PHONEBOOK_REFRESH='1' \
    CONTACT_CALLER='blocked caller' \
    CONTACT_TIMESTAMP='true' \
    CONTACT_TYPE='other' \
    FILTER_MSN='' \
    FILTER_BLOCKFOREIGN='true' \
    FILTER_SCORE='6' \
    FILTER_COMMENTS='3' \
    LOGGING_LOG='true' \
    LOGGING_LOGPATH='/var/log/'

VOLUME fbcallrouter

# Run the application as entrypoint
ENTRYPOINT [ "sh", "/fbcallrouter/build/docker/docker-entrypoint.sh" ] 

CMD [ "start" ]
