#!/usr/bin/python3

import sys
import os
import subprocess as sp


CONFIG_FILE = "~/.config/custom-config/quick-directory-paths.txt"


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def choose_path():

    config_file = os.path.expanduser(CONFIG_FILE)

    with open(config_file, 'r') as f:
        data = f.read()

    choices = data
    cmd = f"printf '{choices}' | rofi -dmenu -theme themes/nord"

    try:
        chosen = sp.check_output(cmd, shell=True)
    except sp.CalledProcessError:
        eprint("Subprocess 'rofi' exited unexpectedly.")
        exit(1)

    chosen = str(chosen).rstrip("\\n'")

    try:
        chosen = chosen.split(": ", maxsplit=1)[1].strip()
    except IndexError:
        eprint("Unable to split with chosen element.")
        exit(1)

    if (not os.path.isdir(chosen)):
        eprint("Selected path is not a directory.")
        exit(1)

    return chosen


def main():
    if (len(sys.argv) == 1):
        eprint("Invalid call to program.")
        exit(1)

    if (len(sys.argv) == 2):
        if (sys.argv[1] == "menu" or sys.argv[1] == "m"):
            print(choose_path())

        if (sys.argv[1] == "edit" or sys.argv[1] == "e"):
            config_file = os.path.expanduser(CONFIG_FILE)
            sp.run(['nvim', config_file])

        elif (sys.argv[1] == "mt"):
            sys.argv = [sys.argv[0]] + ['menu', 'thunar']

        elif (sys.argv[1] == "mc"):
            sys.argv = [sys.argv[0]] + ['menu', 'copy']

        elif (sys.argv[1] == "mx"):
            sys.argv = [sys.argv[0]] + ['menu', 'term']

    if (len(sys.argv) == 3):
        if (sys.argv[1] == "menu"):
            choice = choose_path()

            if (sys.argv[2] == "thunar"):
                sp.Popen(['thunar', choice],
                         stdout=sp.DEVNULL, stderr=sp.DEVNULL)

            elif (sys.argv[2] == "term"):
                sp.Popen(['kitty', choice],
                         stdout=sp.DEVNULL, stderr=sp.DEVNULL)

            elif (sys.argv[2] == "copy"):
                sp.run(['xclip', '-sel', 'c'], input=choice, encoding='ascii',
                       stdout=sp.DEVNULL, stderr=sp.DEVNULL)


if __name__ == "__main__":
    main()
