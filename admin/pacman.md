# Useful pacman Commands

## Find a specific binary

```cheat pacman Find a specific binary
# Update database
pacman -Fy

# do the search
pacman -Fs packagename
```

```cheat pacman List the commands provided by an installed package
pacman -Ql <package name> | sed -n -e 's/.*\/bin\///p' | tail -n +2
```

```cheat pacman List explicitly installed packages
pacman -Qe

```

```cheat pacman List orphan packages (installed as dependencies and not required anymore)
pacman -Qdt
```

tags: #arch_linux #admin #pacman #linux 
