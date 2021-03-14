#!/bin/env python

# gen alacritty config for platform
import pathlib
import os
from copy import deepcopy

from deepmerge import always_merger
import yaml

ROOT = os.path.dirname(__file__)
LINUX_DIR = os.path.join(os.path.dirname(ROOT), "platform", "linux")


def linux():
    tpl_file = os.path.join(ROOT, "alacritty.linux.yaml")
    base_tmp = yaml.load(pathlib.Path(tpl_file).read_text(), Loader=yaml.SafeLoader)
    confs = [
        (
            {"env": dict(WINIT_X11_SCALE_FACTOR="1.0"), "font": {"size": 15}},
            os.path.join(LINUX_DIR, ".alacritty.4k.yml"),
        ),
        ({}, os.path.join(LINUX_DIR, ".alacritty.yml")),
        (
            {
                "shell": {
                    "args": [
                        "-l",
                        "-c",
                        "xseticon -id $WINDOWID $HOME/.local/share/icons/qalacritty.png && tmux new-session -A -s qq",
                    ]
                }
            },
            os.path.join(LINUX_DIR, ".alacritty_q.yml"),
        ),
    ]
    for conf, out in confs:
        c = always_merger.merge(deepcopy(base_tmp), conf)
        with open(out, "w") as f:
            print("Update conf to", out)
            f.write(yaml.dump(c, default_flow_style=False, sort_keys=False))


if __name__ == "__main__":
    linux()
