#!/bin/sh
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# Toggle the keylogger script

SCRIPT="[p]ython /bin/custom-scripts/keylogger.py"
OUTPUT=$(pgrep -af "keylogger.py" | cut -d" " -f1)
if [ -z "$OUTPUT" ]; then
    setsid -f $HOME/.local/share/python-suchi-envs/keylogger/bin/python \
        $HOME/.local/bin/custom-scripts/keylogger.py
else
    kill $OUTPUT
fi
