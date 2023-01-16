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

time = "11pm"
priority = "high"
start = 1
couse = "cs34"
dates = [
]
string = "Assign {} {} {} {} !{}"

for index, item in enumerate(dates):
    print(string.format(
        start + index,
        couse,
        time,
        item,
        priority
    ))
