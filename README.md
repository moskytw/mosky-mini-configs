# The Configs from a Minimalist

It's easy to get lost in the Unix configuration world. So many fancy choices!
After working on Linux and macOS many years, I converged my configs into a
minimal set, which is good enough, comprehensive, portable, and may be
inspirational to you. ✨

It includes:

1. A [Makefile](https://github.com/moskytw/mosky-mini-configs/blob/master/Makefile)
   to install the configs into system.
2. The [scripts](https://github.com/moskytw/mosky-mini-configs/tree/master/scripts)
   to set up a system, and even config a remote machine.
3. My [vimrc](https://github.com/moskytw/mosky-mini-configs/tree/master/src/vimrc)
   for unadorned requirements of Python development.
4. My [Bash, Git, SSH, and tmux](https://github.com/moskytw/mosky-mini-configs/tree/master/src)
   configs.
5. My [Karabinder config](https://github.com/moskytw/mosky-mini-configs/tree/master/src/karabinder_bash_emacs.json)
   to port the Bash keystrokes to the whole macOS.

## The Makefile

The
[Makefile](https://github.com/moskytw/mosky-mini-configs/blob/master/Makefile)
copies and patches out the correct version of the configs, like Vim or Neovim,
tmux 1.x or 2.x, and installs them into system. It also supports to uninstall.

```bash
$ make
$ make install
$ make uninstall
```

You may not want to use my configs exactly, but it may be a good template to
write your own.

## The Scripts

My favorite in [the scripts](https://github.com/moskytw/mosky-mini-configs/tree/master/scripts)
is:

```bash
$ config-remote mosky-mini-configs mosky.tw
```

I wrote another private script to deploy my configs on bunch of servers.
Awesome. 😎

## The Vimrc

The [vimrc](https://github.com/moskytw/mosky-mini-configs/tree/master/src/vimrc)
has super detailed comments. 📚

## The Karabinder Config

TBC.

Hope it helps!
