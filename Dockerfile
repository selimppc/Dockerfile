# ─────────────────────────────────────────────────────────────────────────────
# PHP 8.4 CI image — ultra-light, lint + test only
#
# Build:  docker build -t selimppc/php84-ci:v1 -f docker/ci/Dockerfile .
# Size:   ~65MB (vs ~400MB+ production image)
# ─────────────────────────────────────────────────────────────────────────────
FROM php:8.4-cli-alpine3.22

LABEL maintainer="selimppc@gmail.com"
LABEL description="Minimal PHP 8.4 CI — lint + test (no FPM, no imagick, no wkhtmltopdf)"

# Minimal system deps: only what Composer and tests need
RUN apk add --no-cache git unzip bash

# install-php-extensions: handles build deps automatically, keeps image clean
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        pdo_sqlite \
        pdo_pgsql \
        mbstring \
        bcmath \
        intl \
        zip \
        xml \
        dom \
        pcntl \
        opcache \
        gd \
        exif \
        pcov \
    && rm -rf /tmp/* /var/cache/apk/*

# Composer (smallest footprint via multi-stage copy)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_NO_INTERACTION=1 \
    COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /app
