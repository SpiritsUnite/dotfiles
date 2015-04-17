#!/bin/sh

    # not using urxvtc here, as we're relying on the process to run
    # until either
    #
    # * it gets detached (eg by ^Ad)
    # * it terminates (because someone killed all windows)
    #
    # in any case, we try to reattach to the session, or, if that fails,
    # create a new one.
    gnome-terminal --role=scratchpad -e "screen -DRS scratchpad -s ${HOME}/.i3/scratchpad/zsh.sh"
