#!/usr/bin/python

############################################################################
# Copyright (c) 2009   unohu <unohu0@gmail.com>                            #
#                                                                          #
# Permission to use, copy, modify, and/or distribute this software for any #
# purpose with or without fee is hereby granted, provided that the above   #
# copyright notice and this permission notice appear in all copies.        #
#                                                                          #
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES #
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF         #
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR  #
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   #
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN    #
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF  #
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.           #
#                                                                          #
############################################################################

import commands
import ConfigParser
import math
import os
import pickle
import sys


def initconfig():
    rcfile = os.getenv('HOME') + "/.stilerrc"
    if not os.path.exists(rcfile):
        cfg = open(rcfile, 'w')
        cfg.write(
            """#Tweak these values
[default]
BottomPadding = 0
TopPadding = 0
LeftPadding = 0
RightPadding = 0
WinTitle = 21
WinBorder = 1
MwFactor = 0.65
TempFile = /tmp/tile_winlist
"""
        )
        cfg.close()

    config = ConfigParser.RawConfigParser()
    config.read(rcfile)
    return config


def get_screen_size():
    s = commands.getoutput(
        '''xdpyinfo | grep 'dimension' | awk -F: '{ print $2 }' | awk '{ print $1 }' '''
    )
    (x, y) = s.split('x')
    return (int(x), int(y))


(resx, resy) = get_screen_size()


def initialize():
    desk_output = commands.getoutput("wmctrl -d").split("\n")
    desk_list = [line.split()[0] for line in desk_output]
    current = filter(lambda x: x.split()[1] == "*", desk_output)[0].split()
    desktop = current[0]
    width = current[8].split("x")[0]
    height = current[8].split("x")[1]
    orig_x = current[7].split(",")[0]
    orig_y = current[7].split(",")[1]
    (resx, resy) = get_screen_size()

    win_output = commands.getoutput("wmctrl -lG").split("\n")
    win_list = {}

    win_filtered = []
    for win in win_output:
        w = win.split()
        x = int(w[2])
        y = int(w[3])
        if x < 0 or x >= resx:
            continue

        if y < 0 or y >= resy:
            continue

        if w[7] == '<unknown>':
            continue

        if w[6] == 'N/A':
            continue

        if w[7] == 'x-nautilus-desktop':
            continue

        win_filtered.append(win)

    for desk in desk_list:
        win_list[desk] = map(
            lambda y: hex(int(y.split()[0], 16)),
            filter(lambda x: x.split()[1] == desk, win_filtered),
        )

    return (desktop, orig_x, orig_y, width, height, win_list)


def get_active_window():
    return str(
        hex(int(commands.getoutput("xdotool getactivewindow 2>/dev/null").split()[0]))
    )


def store(object, file):
    with open(file, 'w') as f:
        pickle.dump(object, f)
    f.close()


def retrieve(file):
    try:
        with open(file, 'r+') as f:
            obj = pickle.load(f)
        f.close()
        return obj
    except:
        f = open(file, 'w')
        f.close
        dict = {}
        return dict


# Get all global variables
Config = initconfig()
BottomPadding = Config.getint("default", "BottomPadding")
TopPadding = Config.getint("default", "TopPadding")
LeftPadding = Config.getint("default", "LeftPadding")
RightPadding = Config.getint("default", "RightPadding")
WinTitle = Config.getint("default", "WinTitle")
WinBorder = Config.getint("default", "WinBorder")
MwFactor = Config.getfloat("default", "MwFactor")
TempFile = Config.get("default", "TempFile")
(Desktop, OrigXstr, OrigYstr, MaxWidthStr, MaxHeightStr, WinList) = initialize()
MaxWidth = int(MaxWidthStr) - LeftPadding - RightPadding
MaxHeight = int(MaxHeightStr) - TopPadding - BottomPadding
OrigX = int(OrigXstr) + LeftPadding
OrigY = int(OrigYstr) + TopPadding
OldWinList = retrieve(TempFile)


def get_simple_tile(wincount):
    rows = wincount - 1
    layout = []
    if rows == 0:
        layout.append((OrigX, OrigY, MaxWidth, MaxHeight - WinTitle - WinBorder))
        return layout
    else:
        layout.append(
            (OrigX, OrigY, int(MaxWidth * MwFactor), MaxHeight - WinTitle - WinBorder)
        )

    x = OrigX + int((MaxWidth * MwFactor) + (2 * WinBorder))
    width = int((MaxWidth * (1 - MwFactor)) - 2 * WinBorder)
    height = int(MaxHeight / rows - WinTitle - WinBorder)

    for n in range(0, rows):
        y = OrigY + int((MaxHeight / rows) * (n))
        layout.append((x, y, width, height))

    return layout


def get_vertical_tile(wincount):
    layout = []
    y = OrigY
    width = int(MaxWidth / wincount)
    height = MaxHeight - WinTitle - WinBorder
    for n in range(0, wincount):
        x = OrigX + n * width
        layout.append((x, y, width, height))

    return layout


def get_horiz_tile(wincount):
    layout = []
    x = OrigX
    height = int(MaxHeight / wincount - WinTitle - WinBorder)
    width = MaxWidth
    for n in range(0, wincount):
        y = OrigY + int((MaxHeight / wincount) * (n))
        layout.append((x, y, width, height))

    return layout


def get_max_all(wincount):
    layout = []
    x = OrigX
    y = OrigY
    height = MaxHeight - WinTitle - WinBorder
    width = MaxWidth
    for n in range(0, wincount):
        layout.append((x, y, width, height))

    return layout


def move_active(PosX, PosY, Width, Height):
    command = (
        " wmctrl -r :ACTIVE: -e 0,"
        + str(PosX)
        + ","
        + str(PosY)
        + ","
        + str(Width)
        + ","
        + str(Height)
    )
    os.system(command)


def unmaximize_one(windowid):
    command = " wmctrl -i -r " + windowid + " -bremove,maximized_vert,maximized_horz"
    os.system(command)


def maximize_one(windowid):
    command = " wmctrl -i -r " + windowid + " -badd,maximized_vert,maximized_horz"
    os.system(command)


def move_window(windowid, PosX, PosY, Width, Height):
    # Unmaximize window
    unmaximize_one(windowid)
    # Now move it
    command = (
        " wmctrl -i -r "
        + windowid
        + " -e 0,"
        + str(PosX)
        + ","
        + str(PosY)
        + ","
        + str(Width)
        + ","
        + str(Height)
    )
    os.system(command)
    command = "wmctrl -i -r " + windowid + " -b remove,hidden,shaded"
    os.system(command)


def raise_window(windowid):
    if windowid == ":ACTIVE:":
        command = "wmctrl -a :ACTIVE: "
    else:
        command = "wmctrl -i -a " + windowid

    os.system(command)


def left():
    Width = MaxWidth / 2 - 100
    Height = MaxHeight - WinTitle - WinBorder
    PosX = LeftPadding
    PosY = TopPadding
    move_active(PosX, PosY, Width, Height)
    raise_window(":ACTIVE:")


def right():
    Width = MaxWidth / 2 + 100
    Height = MaxHeight - WinTitle - WinBorder
    PosX = MaxWidth / 2 + 100
    PosY = TopPadding
    move_active(PosX, PosY, Width, Height)
    raise_window(":ACTIVE:")


def middle():
    Width = MaxWidth / 2 - 1
    Height = MaxHeight - WinTitle - WinBorder
    PosX = int(math.ceil(0.25 * MaxWidth)) + 125
    PosY = TopPadding
    move_active(PosX, PosY, Width, Height)
    raise_window(":ACTIVE:")


def right_three_quarter():
    Width = int(math.ceil(0.75 * MaxWidth)) + 75
    Height = MaxHeight - WinTitle - WinBorder
    PosX = int(math.ceil(0.25 * MaxWidth)) + 125
    PosY = TopPadding
    move_active(PosX, PosY, Width, Height)
    raise_window(":ACTIVE:")


def compare_win_list(newlist, oldlist):
    templist = []
    for window in oldlist:
        if newlist.count(window) != 0:
            templist.append(window)
    for window in newlist:
        if oldlist.count(window) == 0:
            templist.append(window)
    return templist


def create_win_list():
    Windows = WinList[Desktop]

    if OldWinList == {}:
        pass
    else:
        OldWindows = OldWinList[Desktop]
        if Windows == OldWindows:
            pass
        else:
            Windows = compare_win_list(Windows, OldWindows)

    return Windows


def arrange(layout, windows):
    for win, lay in zip(windows, layout):
        move_window(win, lay[0], lay[1], lay[2], lay[3])
    WinList[Desktop] = windows
    store(WinList, TempFile)


def maximize_active():
    os.system("wmctrl -r :ACTIVE: -badd,maximized_vert,maximized_horz")


def maximize():
    Width = MaxWidth
    Height = MaxHeight - WinTitle - WinBorder
    PosX = LeftPadding
    PosY = TopPadding
    move_active(PosX, PosY, Width, Height)
    raise_window(":ACTIVE:")


def bring_app_front(app, command):
    workspace_id = commands.getoutput("wmctrl -d | grep '*' | cut -d ' ' -f1")
    apps_within_workspace = commands.getoutput(
        "wmctrl -l -p | grep '  {} '".format(workspace_id)
    ).split('\n')
    if len(apps_within_workspace) == 0:
        os.system('{} &'.format(command))
    else:
        if app == 'fvim':
            win_id = None
            for workspace_app in apps_within_workspace:
                if workspace_app.split()[-1] == 'FVim':
                    win_id = workspace_app.split()[0]
                    break

            if win_id is None:
                os.system('{} &'.format(command))
            else:
                os.system('wmctrl -i -a "{}"'.format(win_id))
        else:
            pid_to_win_id = {}
            pid_in_workspace = set()
            for workspace_app in apps_within_workspace:
                pid = workspace_app.split()[2]
                win_id = workspace_app.split()[0]
                pid_to_win_id[pid] = win_id
                pid_in_workspace.add(pid)

            pid_for_app = set(commands.getoutput('pidof {}'.format(app)).split(' '))
            common_pid = list(pid_in_workspace.intersection(pid_for_app))
            print(pid_to_win_id)
            print(pid_in_workspace)
            print(pid_for_app)
            print(common_pid)
            if len(common_pid) == 0:
                os.system('{} &'.format(command))
            else:
                win_id = pid_to_win_id[common_pid[0]]
                os.system('wmctrl -i -a "{}"'.format(win_id))


if sys.argv[1] == "left":
    left()
elif sys.argv[1] == "right":
    right()
elif sys.argv[1] == "middle":
    middle()
elif sys.argv[1] == "right_three_quarter":
    right_three_quarter()
elif sys.argv[1] == "maximize":
    maximize()
elif sys.argv[1] == "vim":
    bring_app_front('fvim', 'fvim')
elif sys.argv[1] == "chrome":
    bring_app_front('chrome', 'google-chrome')
elif sys.argv[1] == "terminal":
    bring_app_front('tilix', 'tilix')
elif sys.argv[1] == "zathura":
    bring_app_front('zathura', 'zathura')
elif sys.argv[1] == "texmacs":
    bring_app_front('texmacs.bin', 'texmacs')
elif sys.argv[1] == "files":
    bring_app_front('nautilus', 'nautilus')
