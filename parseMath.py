#!/bin/python3
# Author: Suchith Sridhar
# Website: https://suchicodes.com/

# Parse a file and replace all the characters sequences specified
# with the unicode characters. This is based on the character file:
# ~/.config/custom-config/math-characters.csv

import sys
import csv


SOURCE_FILE = "/home/suchi/.config/custom-config/math-characters.csv"

source = {}

if len(sys.argv) < 2:
    print("Please provide file as argument.")
    exit(1)

with open(SOURCE_FILE, newline='') as file:
    reader = csv.reader(file, delimiter=',')
    for item in reader:
        item[0] = item[0].strip()
        item[1] = item[1].strip()
        source[item[0]] = item[1]

'''
Wrap a particular string in html tags.
Example: !!v13!! would result in <sub>13</sub>
'''

html_source = {
    "^"          : "sup",
    "v"          : "sub",
}


file = sys.argv[1]
with open(file, 'r') as f:
    data = f.read()

for item, sign in source.items():
    data = data.replace("!!"+item, sign)
    data = data.replace(("!!"+item).lower(), sign)

for item, html in html_source.items():
    term = "!!" + item
    while(data.find(term) != -1):
        start = data.find(term)
        end = data.find('!!', start + 3)
        data = data[:start] + f"<{html}>{data[start+len(item)+2: end]}</{html}>" + data[end + 2:]

with open(file, 'w') as f:
    f.write(data)

