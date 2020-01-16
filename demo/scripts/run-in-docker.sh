#!/usr/bin/env sh

source "$(dirname $0)/config.sh"

export TIMEZONE

# Enable Xdebug while executing "php -f file.php"
if [ "$1" = "php" ] && [ "$2" = "-f" ]; then
    if [ -z "$DOCKER_MACHINE_NAME" ]; then
        runfile="$3"
    else
        # fix file path for windows
        runfile=$(cygpath -u "$3")
    fi
    if [ -f "$runfile" ]; then
        set -- "${@:1:2}" "${runfile#${PWD}/}"
    fi
    export XDEBUG_CONFIG="remote_enable=1 remote_autostart=1 remote_log=/proc/self/fd/2 remote_host=${LOCALHOST} idekey=${TERM_PROGRAM:=vscode}"
fi

docker run --rm --env TIMEZONE --env XDEBUG_CONFIG -v "/$PWD:/app" "fatindeed/phpunit:${IMAGE_TAG}" "$@"