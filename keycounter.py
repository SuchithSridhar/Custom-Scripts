#!/usr/bin/python3

from pynput.keyboard import Listener
import signal

COUNT_FILE = '/home/suchi/.config/custom-config/keystrokes_counter.txt'
BUFFER_COUNT=1000
global_count = 0

def handle_exit(*_, **__):
    increment_count()
    exit()

def increment_count(*_, **__):
    global global_count
    print(f"Incrementing count into file {global_count}.")
    with open(COUNT_FILE) as f:
        curcount = int(f.read())
    with open(COUNT_FILE, 'w') as f:
        f.write(str(curcount + global_count))


def on_press(key):
    global global_count

    global_count+=1
    if global_count == BUFFER_COUNT:
        increment_count()
        global_count = 0


def main():
    with Listener(on_press=on_press) as listener:
        listener.join()

if __name__ == "__main__":
    signal.signal(signal.SIGTERM, handle_exit)
    signal.signal(signal.SIGINT, handle_exit)
    main()

