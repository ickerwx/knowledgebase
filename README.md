# knowledgebase

Stuff I tend to forget on a regular basis

## Installation and setup

- `git clone` this repo
- set the `KBHOME` environment variable to point to the knowledgebase root directory
- add `$KBHOME/scripts` to `$PATH`
- install `bat` from your distro repositories or from [here](https://github.com/sharkdp/bat). Having `bat` is optional for searching with syntax highlighting, but required for using `cheat`.

## Note Format

Each note should start with a heading and end with a tag line:

```
# A heading
Some Text

tags: #tag1 #tag_number_2 #tag3
```

## Tags

You can run `./scripts/createtaglist` to create a `tags` folder containing index files. So if you are looking for notes tagged with `#linux`, open `tags/linux.md` and you will find links to all of these notes.

Search for `systemd` to find unit and timer files to support automatic and periodic update of tag files

## `KBHOME` environment

Create a `KBHOME` environment variable and add `$KBHOME/scripts` to `PATH` to enable `search`ing for terms from any working directory.

## Helper scripts

If you put `$KBHOME/scripts` in your `PATH`, you can run a few scripts that help using the knowledgebase.

### createtaglist

Run this to parse the `tags:` line from your notes and write index files into the `tags` folder. This will create markdown files with links to each file that uses the tag. To see all notes tagged with `#android`, look at `tags/android.md`:

```
$ cat tags/android.md
# Notes tagged with #android
[Notes about reversing on Android](<snip>/reversing/androidnotes.md)
[Android Applications Reversing 101](<snip>/reversing/androidreversing101.md)
```

See the `systemd` tag to find a systemd service and timer that you can use to periodically update the tags.

You might want to add a hook to automatically update the tags once you commited stuff. To do this, add a script to your `.git/hooks/` folder and make it executable:

```sh
$ cat .git/hooks/post-commit
#!/bin/sh

$KBHOME/scripts/createtaglist
$ chmod +x .git/hooks/post-commit
```

This also creates an opportunity for endless fun if somebody else modifies the script and you don't notice it.

### note

Use this to quickly create a new note. it will treat folders under `KBHOME` as categories and ask you to pick one or create a new one.

```sh
$ note  #use the menu to create a new note
$ note foo  # use the menu to select a category, will then create a new note foo.md under the category you selected
$ note foo/bar  # will create bar.md unter $KBHOME/foo, will mkdir foo if folder doesn't exist
```

You can create your own note template by editing `scripts/template.md`. Make sure to keep the tags line intact or edit `scripts/note` accordingly. 

### search

Search through your notes. Will search through all your notes for the term you provided. You can then input the number next to the file name to open the note with `less`. Using `-c/--case` will search preserving the case, using `-w/--word` will search for the search term as a whole word only. Default search is case-insensitive and matches on substrings.

You can search for tags by using `-t` and modify your search using `-c` and `-w`.

```
$ search -h
usage: search [-h] [-w] [-c] [-t] [-e] searchterm

Search through the knowledgebase

positional arguments:
  searchterm     Thing to look for

optional arguments:
  -h, --help     show this help message and exit
  -w, --word     Search for word only, no substring search
  -c, --case     Search is case-sensitive
  -t, --tag      Search through tags
  -e, --heading  Only search headings (lines starting with #)

$ search vpn
+=~----------
| 0:  <snip>/pentest/links.md
+=~----------
2: 
3: ## VPN over SSH
4: 

4: 
5: [Using SSH to create a tun device to tunnel traffic](https://wiki.archlinux.org/index.php/VPN_over_SSH)
6: 

26: 
27: tags: #links #pentest #ssh #vpn #linux #webapp
+=~----------
| 1:  <snip>/blueteam/blocklanturtle.md
+=~----------
50: 
51: The only occasions I see this being a problem would be if something like VMWare Workstation was added to the system, but then you could temporarily disable the setting, install the software, and then reapply the GPO.  It is also possible that some VPN software could also trip this up, but I *suspect* that if you started the VPN once while the GPO was disabled it would still work, however that would require further testing.
52: 

Enter number to open or anything else to quit: 

$ search -t vpn
+=~----------
|/home/rene/code/knowledgebase/tags/vpn.md
| # Notes tagged with #vpn
+=~----------
┌─ 0:  <snip>/pentest/links.md
└─ Useful pentest links

Enter number to open or anything else to quit: 
```

If you happen to use [bat](https://github.com/axiros/terminal_markdown_viewer), the search script will detect it and use it with a random theme.

### cheat

You can use the `cheat` command to look for cheat sheets. These are little snippets of code to help you remember how to use a command etc. It was very much inspired by [cheat](https://github.com/cheat/cheat). For now, cheat is hard-coded to use a great paging tool called [bat](https://github.com/sharkdp/bat). This may change in the future, but probably won't. To use `cheat` you need to have `bat` in your `$PATH`.    

Use the `-l` switch to list available cheatsheets. You can use `-l substring` to limit search results.

```
$ cheat -h
usage: cheat [-h] [-n] [-l] [-o] [cheatsheet]

Show command cheatsheets

positional arguments:
  cheatsheet     Thing to look for

optional arguments:
  -h, --help     show this help message and exit
  -n, --nocolor  Do not use colored output
  -l, --list     List available cheatsheets.
  -o, --old      Print legacy cheat sheet

$ cheat -n sip
# enumerate
```bash
svmap <ip>
svwar -m INVITE -e200-250 <ip>
``
$ cheat -l | wc -l
51

$ cheat -l win
windows
winrm
```

The tool parses all your notes and uses code blocks that follow a special syntax as cheat sheets. When you write a note and want to use a code block as a cheat sheet, simply add the following to a codeblock:

````
```sh cheat foo A topic
some text inside your code block.
```
````

The `sh` is optional to enable syntax highlighting, then followed by the magic word `cheat`. The next word is the search term you want to use. In the above example you could run `$ cheat foo` from the command line and find this particular cheat sheet.

You can also use a `|` to make the cheat appear under multiple search terms:

````
```sh cheat foo|bar A topic
some text inside your code block.
```
````

Using this, you could find the same cheat using either `$ cheat foo` or `$ cheat bar` from the command line. The search term must not contain spaces, the topic may use them.

The folder `cheat/` contains cheat sheets from the [cheat/cheatsheets](https://github.com/cheat/cheatsheets) repo, but not as a submodule (I should probably do that some time...). By default, `cheat` will not use these cheat sheets but only the inline cheats from the notes. If you want to use these what I call legacy cheat sheets, use the `-o` command line argument.
