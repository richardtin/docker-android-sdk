#!/bin/bash

if [ -z ${HTTP_PROXY+x} ]; then
    echo "HTTP_PROXY is unset"
else
    echo "HTTP_PROXY is set to '$HTTP_PROXY'"

# Get system proxy setting
PROXY_REGEX='http:\/\/(.*):([0-9]+)'

[[ $HTTP_PROXY =~ $PROXY_REGEX ]] && \
proxyHost=${BASH_REMATCH[1]} && \
proxyPort=${BASH_REMATCH[2]}

# Create gradle.properties
mkdir -p ~/.gradle
echo -e "systemProp.http.proxyHost=${proxyHost}\n"\
"systemProp.https.proxyHost=${proxyHost}\n"\
"systemProp.https.proxyPort=${proxyPort}\n"\
"systemProp.http.proxyPort=${proxyPort}\n"\
"systemProp.jdk.http.auth.tunneling.disabledSchemes=\"\"" > ~/.gradle/gradle.properties

fi

exec -- "$@"