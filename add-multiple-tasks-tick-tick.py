#!/bin/usr/python3
# =============================================================
#
#   █████████   █████████
#  ███░░░░░███ ███░░░░░███  Suchith Sridhar
# ░███    ░░░ ░███    ░░░
# ░░█████████ ░░█████████   https://suchicodes.com
#  ░░░░░░░░███ ░░░░░░░░███  https://github.com/suchithsridhar
#  ███    ░███ ███    ░███
# ░░█████████ ░░█████████
#  ░░░░░░░░░   ░░░░░░░░░
#
# =============================================================
# A script to generate tick tick tasks.
# I use this to generate tasks for my assignments.
# =============================================================

import pyperclip


# Note, ensure you are under right tag
# tag cannot be added automatically
time = "5pm"
priority = "high"
start = 3
type = "Lab"
couse = "cs22"
dates = [
        "Feb 3rd", "Feb 25th", "March 3rd", "March 17th", "March 24th", "March 31st"
]
string = "{} {} {} {} {} !{}"

for index, item in enumerate(dates):
    print_string = string.format(
        type,
        start + index,
        couse,
        time,
        item,
        priority
    )
    print(print_string)
    pyperclip.copy(print_string)
    input("Next?")
