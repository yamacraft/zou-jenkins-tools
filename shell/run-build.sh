#!/bin/bash -e

PROGNAME=$(basename $0)

usage() {
    echo "Usage: $PROGNAME [OPTIONS] WORKSPACE"
    echo "Options:"
    echo "  --help : help"
    echo "  --dev      : dev build and beta upload"
    echo "  --release  : release build and beta upload"
    echo " "
    echo " "
    exit 1
}
shell_session_update() { :; }

for OPT in "$@"
do
    case "$OPT" in
        '--help' )
            usage
            exit 1
            ;;
        '--dev')
            BETA_DEV=true
            ;;
        '--release')
            BETA_RELEASE=true
            ;;
        -*)
            ;;
        *)
            WORKSPACE_PATH=$OPT
            shift 1
            ;;
    esac
done

if [ ! "$WORKSPACE_PATH" ]; then
    echo "No Set WORKSPACE_PATH"
    usage
    exit 1
fi

if [ ! "$BETA_DEV" ] && [ ! "$BETA_RELEASE" ]; then
    echo "No Set Options"
    usage
    exit 1
fi

export LANG=en_US.UTF-8

echo "build start"
cd $WORKSPACE_PATH

if [ "$BETA_DEV" ]; then
    echo "start dev"
    ./gradlew clean check build
fi

if [ "$BETA_RELEASE" ]; then
    echo "start release"
    ./gradlew clean check build
fi

echo "build end"
