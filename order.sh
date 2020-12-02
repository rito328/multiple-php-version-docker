#!/usr/bin/env bash

PHP_VERSIONS=(8.0 7.4)

SCRIPT_DIR=$(cd $(dirname $0); pwd)

function start () {
    echo "Docker starting..."

    START_URLS=()

    for VERSION in ${PHP_VERSIONS[@]}; do
        VERSION_NUMBER=${VERSION/./}

        CONTAINER_NAME=php_${VERSION_NUMBER}_web_container

        CONTAINER_EXISTS=$(docker ps -f name=$CONTAINER_NAME --format '{{.Names}}')

        if [ "$CONTAINER_EXISTS" = '' ]; then
            SCRIPT_DIR=$(cd $(dirname $0); pwd)

            ERROR_LOG_DIR=${SCRIPT_DIR}/logs/${VERSION}
            ERROR_LOG_FILE=${ERROR_LOG_DIR}/php_error.log

            if [[ -f $ERROR_LOG_FILE ]]; then
              rm -f $ERROR_LOG_FILE
            fi

            mkdir $ERROR_LOG_DIR
            touch $ERROR_LOG_FILE

            docker run \
            -v $SCRIPT_DIR/src:/var/www/html \
            -v $SCRIPT_DIR/settings/php.ini:/usr/local/etc/php/php.ini \
            -v $ERROR_LOG_FILE:/var/log/php_error.log \
            -p 80${VERSION_NUMBER}:80 \
            -d \
            --name ${CONTAINER_NAME} php:${VERSION}-apache

            echo "Started PHP ${VERSION} Container"

            START_URLS+=("http://localhost:80${VERSION_NUMBER}")
        else
            echo ${CONTAINER_NAME} ' is already started.'
        fi
    done

    printf "\n+-----------------------------------+\n"
    echo "      PHP Containers is Started."
    i=0
    for URL in ${START_URLS[@]}; do
        echo "  [PHP ${PHP_VERSIONS[$i]}]  $URL"
        let i++
    done
    printf "+-----------------------------------+\n"
}
function stop () {
    for VERSION in ${PHP_VERSIONS[@]}; do
        VERSION_NUMBER=${VERSION/./}

        CONTAINER_NAME=php_${VERSION_NUMBER}_web_container

        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    done
}
function restart () {
    stop
    start
}
function destroy() {
    stop
    for VERSION in ${PHP_VERSIONS[@]}; do
        docker rmi -f php:${VERSION}-apache
    done
}
function connect () {
    CONTAINER_NAME="php_${1}_web_container"
    docker exec -it $CONTAINER_NAME /bin/bash
}
function help () {
  echo "
  +------------------------------------------------------------------------+
   +-+- PHP execution environment with multiple PHP versions by Docker -+-+

      start   : Starting Image & Container
      stop    : Stop the container.
      restart : Reboot the container.
      destroy : Delete containers and images.
      conn    : Connect to app container.
           args : PHP version number of the container to connect.
                  exp.) PHP7.4 => 74
      help    : Display help.
  +------------------------------------------------------------------------+
  "
}
function error_msg () {
    echo "Argument is missing. Please display help and check the argument.
    exp.) sh order.sh help
    "
}

case "$1" in
    "start"   ) start       ;;
    "stop"    ) stop        ;;
    "restart" ) restart     ;;
    "destroy" ) destroy     ;;
    "conn"    ) connect $2  ;;
    "help"    ) help        ;;
    ""        ) error_msg   ;;
esac
