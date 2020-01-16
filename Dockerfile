ARG PHP_IMAGE_TAG
FROM php:${PHP_IMAGE_TAG}

ARG ALPINE_MIRROR
ARG PHPUNIT_VERSION
ARG XDEBUG_VERSION

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL maintainer="James Zhu <168262+fatindeed@users.noreply.github.com>" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="fatindeed/phpunit" \
      org.label-schema.description="PHPUnit with Xdebug" \
      org.label-schema.url="https://hub.docker.com/r/fatindeed/phpunit" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/fatindeed/docker-phpunit" \
      org.label-schema.vendor="James Zhu" \
      org.label-schema.version="${VERSION}" \
      org.label-schema.schema-version="1.0"

ENV GPG_KEYS 0x4AA394086372C20A

RUN set -e; \
# Switch to mirror if variable exists
    if [ -n "${ALPINE_MIRROR}" ]; then \
        sed -i 's!http://dl-cdn.alpinelinux.org!'"${ALPINE_MIRROR}"'!g' /etc/apk/repositories; \
    fi; \
# Install build depends
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS gnupg; \
# Install PHPUnit
    curl -sSL -o phpunit "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar"; \
    curl -sSL -o phpunit.asc "https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GPG_KEYS}" || \
    gpg --keyserver pgp.mit.edu --recv-keys "${GPG_KEYS}" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "${GPG_KEYS}"; \
    gpg --verify phpunit.asc phpunit; \
    command -v gpgconf > /dev/null && gpgconf --kill all; \
    rm -rf "${GNUPGHOME}" phpunit.asc; \
    chmod a+x phpunit; \
    mv phpunit /usr/local/bin/; \
    phpunit --version; \
# Install extensions
    docker-php-ext-install bcmath hash iconv; \
    pecl install "${XDEBUG_VERSION}"; \
    docker-php-ext-enable bcmath hash iconv xdebug; \
# Remove build depends
    docker-php-source delete; \
    apk del .build-deps; \
# Install run depends
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-cache $runDeps tzdata; \
# Clean build cache
    rm -rf /tmp/pear /usr/local/include /var/cache/apk/*; \
# Rewrite entrypoint
    sed -i 's!set -- php!set -- phpunit!g' /usr/local/bin/docker-php-entrypoint;

VOLUME ["/app"]

WORKDIR /app
