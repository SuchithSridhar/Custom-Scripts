#!/bin/bash

# This is created to move files from the guest directory
# to the suchi directory for when people upload files to
# the guest directory.

# This should only happen once the upload is complete and shouldn't
# happen when an upload is in progress.

# The best way to ensure this is to just have a file count and only
# move when the file count is the same across 2 consecutive checks.
# (A check may happen once a day so if someone uploads file today)
# then it'll be move tomorrow.

# We can always change the interval and make it shorter to have the
# files moved faster.


LOG_FILE='/home/suchi/.cache/filecount.txt'
DESTINATION='/home/suchi/mounted2/guest-copied/'
IGNORE_FOLDER='/home/guest/local'

if [ -f "$LOG_FILE" ]; then
    previous_count=`cat $LOG_FILE`
else
    previous_count="0"
fi
current_count=`ls -R /home/guest | wc -l`

if [ "$current_count" == "$previous_count" ]; then
    # No changes since last recorded, move files.
    files=`find /home/guest/ -mindepth 1 -maxdepth 1 ! -iwholename $IGNORE_FOLDER ! -iname ".*"`
    if [ "$files" != "" ]; then
        echo "INFO: Moving files. - `date`"
        echo "$files" | xargs mv -t $DESTINATION
        chown -R suchi $DESTINATION
        chgrp -R suchi $DESTINATION
    fi
fi

echo "$current_count" > $LOG_FILE
