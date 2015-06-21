me=`basename "$0"`

function log {
    echo "[$(date)] [$me]: $*"
}

##
# Correct way to check Java version from BASH script
# http://stackoverflow.com/a/7335524
##

if type -p java; then
    log found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    log found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    log "no java found"
    exit 1 # terminate and indicate error
fi

if [[ "$_java" ]]; then

    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    vendor="$(echo "$(java -XshowSettings:properties -version 2>&1)" | grep "java.vendor = " | awk '{ print $3; }')"

    log java version: "$version", vendor: "$vendor"

    if [[ "$version" > "1.8" ]] && [[ $vendor == *"Oracle"* ]]; then
        log version is more than 1.8 and vendor is Oracle
    else
        log version is less than 1.8 or vendor is not Oracle, please configure Oracle JDK 1.8
        log Option 1: by setting JAVA_HOME variable to existing setup
        log Option 2: by installing java from existing repo: https://help.ubuntu.com/community/Java
        exit 1 # terminate and indicate error
    fi
else
    log "no java found"
    exit 1 # terminate and indicate error
fi

echo "﻿$(readlink -f $(which java))" > /tmp/java_path.txt

##
# A Shell Script to Find and Remove the BOM Marker
# http://thegreyblog.blogspot.com/2010/09/shell-script-to-find-and-remove-bom.html
##

sed -i '1 s/^\xef\xbb\xbf//' /tmp/java_path.txt