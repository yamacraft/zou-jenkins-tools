#!/bin/bash -e

PROGNAME=$(basename $0)

usage() {
    echo "Usage: $PROGNAME [OPTIONS] WORKSPACE"
    echo "Options:"
    echo "  --help : help"
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

export LANG=en_US.UTF-8

echo "job start"
cd $WORKSPACE_PATH

echo "run build"
./gradlew clean build

echo "run magicpod"
${MAGIC_POD_DIR}Magic\ Pod\ Desktop.app/Contents/MacOS/command.sh run --magic_pod_config=jenkins-tools/magicpod/magic_pod_config.json

echo "job end"
