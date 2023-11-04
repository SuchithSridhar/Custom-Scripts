import datetime
import atexit
import os
import time
from pynput.keyboard import Listener

# Interval in seconds
INTERVAL = 60 * 10
LOG_BASE_DIR = "/home/suchi/.local/logs/"
EXITCODE = "exkeylog"

key_mapping = {
    'Key.ctrl': '<CTRL>',
    'Key.enter': '<ENTER>',
    'Key.space': '<SPACE>',
    'Key.backspace': '<BS>',
    'Key.shift_r': '<SHIFT>',
    'Key.shift': '<SHIFT>',
    'Key.alt_r': '<ALT>',
    'Key.alt': '<ALT>',
    'Key.caps_lock': '<CL>',
    'Key.tab': '<TAB>',
    'Key.cmd': '<MOD>',
    '<65027>': '',
}


def write_to_log(buffer, start):
    date = datetime.datetime.now().strftime('%y-%m-%d')
    end = datetime.datetime.now().strftime('%y-%m-%d_%H-%M-%S')
    filename = LOG_BASE_DIR + 'keylogger_{}.txt'.format(date)

    if (buffer.strip() == ""):
        return

    buffer = f"{start} - {end}\n\n{buffer}\n\n"

    with open(filename, 'a') as f:
        f.write(buffer)


def key_listener():
    global RUN
    global BUFFER
    global time0
    global start

    BUFFER = ''
    start = datetime.datetime.now().strftime('%y-%m-%d_%H-%M-%S')
    time0 = time.time()

    def key_recorder(key):
        global RUN
        global BUFFER
        global time0

        key = str(key)
        if key in key_mapping:
            BUFFER += key_mapping[key]
        else:
            BUFFER += key.replace("'", "")

        if EXITCODE in BUFFER.lower():
            write_to_log(BUFFER, start)
            print("Exiting key logger.")
            RUN = False
            listener.stop()
            return

        if (time.time() - time0 > INTERVAL):
            time0 = time.time()
            write_to_log(BUFFER, start)
            BUFFER = ''

    with Listener(on_press=key_recorder) as listener:
        listener.join()


def on_exit():
    global BUFFER, start
    write_to_log(BUFFER, start)


# Check if the directory exists, and create it if it doesn't
if not os.path.exists(LOG_BASE_DIR):
    os.makedirs(LOG_BASE_DIR)

atexit.register(on_exit)

RUN = True

while (RUN):
    key_listener()
