# The Configs from a Minimalist

It's easy to get lost in the Unix configuration world. So many fancy choices!
After working on Linux and macOS so many years, I converged my configs into a
minimal set, which is just good enough, comprehensive, portable, and may be
inspirational to you. ✨

It includes:

1. A [Makefile](https://github.com/moskytw/mosky-mini-configs/blob/master/Makefile)
   which can configure a local and even a remote machine.
2. My [vimrc](https://github.com/moskytw/mosky-mini-configs/tree/master/configs/vimrc)
   for unadorned requirements of Python development.
3. My [Bash, Git, SSH, and tmux](https://github.com/moskytw/mosky-mini-configs/tree/master/configs)
   configs.
4. My [Karabiner config](https://github.com/moskytw/mosky-mini-configs#the-karabiner-config)
   which ports the Bash keystrokes to the whole macOS.

## The Makefile

The Makefile integrated all of the functionalities including copying and
patching out the correct version of the configs, like tmux 1.x, 2.x, or 3.x,
installing them into system, and installing extra packages, etc.

```bash
$ make config
```

The _config_ is an all-in-one target to configure the local machine, which is
equivalent to:

```bash
$ make clean
$ make
$ make install
$ make install-extra
```

The _install-extra_ target executes
[scripts/install-\*](https://github.com/moskytw/mosky-mini-configs/tree/master/scripts)
to install the extra packages. On Linux, it only executes
[scripts/install-vim-plug\*](https://github.com/moskytw/mosky-mini-configs/tree/master/scripts).

```bash
$ make config HOST=mosky.tw
```

The _config_ target also supports to configure a remote machine.

```bash
$ make config HOST=another.node.mydns REMOTE_SHELL='ssh -J mosky.tw'
```

The _config_ target even supports the remote shell of rsync. I wrote another
private script to configure bunch of servers. Awesome. 😎

The Makefile also has an _uninstall_ target. The target removes, **not
restores**, the configs installed by _install_. Note that it won't uninstall
the packages installed by _install-extra_.

## The Vimrc

The [vimrc](https://github.com/moskytw/mosky-mini-configs/tree/master/configs/vimrc)
has super detailed comments. 📚

## The Karabiner Config

The emacs-style keystrokes – more precisely, some of them are control chars –
in Bash keep your hand in the center of keyboard. It feels so good to minimize
the moving of fingers. The macOS supports partially.  This config ports them
all via [Karabiner](https://pqrs.org/osx/karabiner/)!

Believe me, you will fall in love with it. 😁

| Emacs-Style | Default       | Note                 |
| ----------- | ------------- | -------------------- |
| Ctrl-I      | Tab           |                      |
| Ctrl-J      | Return        |                      |
| Ctrl-M      | Return        |                      |
| Ctrl-\[     | Esc           |                      |
| Ctrl-H      | Delete        | Delete a char        |
| Ctrl-D      | Fn-Delete     |                      |
| Ctrl-W      | Opt-Delete    | Delete a word        |
| Opt-D       | Fn-Opt-Delete |                      |
| Ctrl-U      | Cmd-Delete    | Delete within a line |
| Ctrl-K      | Fn-Cmd-Delete |                      |
| Ctrl-B      | Left          | Move by a char       |
| Ctrl-F      | Right         |                      |
| Opt-B       | Opt-Left      | Move by a word       |
| Opt-F       | Opt-Right     |                      |
| Ctrl-A      | Cmd-Left      | Move within a line   |
| Ctrl-E      | Cmd-Right     |                      |
| Ctrl-P      | Up            | Move by a line       |
| Ctrl-N      | Down          |                      |

After install, enable it in Preferences > Complex Modifications > Add rule.

You also can install
[configs/karabiner_bash_emacs.json](https://github.com/moskytw/mosky-mini-configs/blob/master/configs/karabiner_bash_emacs.json)
alone by:

```bash
$ cp configs/karabiner_bash_emacs.json ~/.config/karabiner/assets/complex_modifications/bash_emacs.json
```

Hope my configs help! ❤️
