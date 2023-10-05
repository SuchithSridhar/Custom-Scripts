#!/usr/bin/python3

import sys
import re


def print_help():
    print("Useage: ./cross-h-c.py <header file> <source file>")
    print("Cross-check all function definitions with their declarations.")


def main():
    args = sys.argv
    if (len(args) != 3):
        print_help()
        sys.exit(1)

    header_file = args[1]
    source_fille = args[2]

    try:
        hf = open(header_file)
        sf = open(source_fille)
    except FileNotFoundError:
        print("File was not found.")
        sys.exit(1)

    ht = hf.read()
    sf = sf.read()

    declar = "*\S\s*\S(*\S)*\S;"
    hd = re.findall(declar, ht)
    from pprint import pprint
    pprint(hd)


if __name__ == "__main__":
    main()
