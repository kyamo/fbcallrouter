FROM php:8.1-cli AS base
WORKDIR /fbcallrouter

RUN apt-get update && \
    apt-get install -y \
      libonig-dev \
      libxml2-dev \
      gettext \
      libcurl4-openssl-dev && \
    apt-get purge -y --autoremove
RUN docker-php-ext-install -j$(nproc)  \
    curl \
    mbstring \
    soap \
    sockets \
    xml

FROM base AS build

RUN apt-get update && \
    apt-get install -y \
      wget \
      unzip

COPY composer.json .
# COPY composer.lock .
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --no-scripts

COPY . .
RUN composer dumpautoload --optimize

RUN wget -O vorwahlen.zip "https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Nummerierung/Rufnummern/ONRufnr/Vorwahlverzeichnis_ONB.zip.zip?__blob=publicationFile&v=298" && \
    unzip vorwahlen.zip && \
    mv *.ONB.csv assets/ONB.csv && \
    rm vorwahlen.zip

FROM base AS final

LABEL description="fbcallrouter - An extended call routing for AVM FRITZ!Box."
COPY --from=build /fbcallrouter /fbcallrouter

ENV DOCKER_CONTAINER=true
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

ENTRYPOINT [ "sh", "/fbcallrouter/build/docker/docker-entrypoint.sh" ] 
CMD [ "start" ]