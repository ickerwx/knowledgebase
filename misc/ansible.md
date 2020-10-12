# Ansible modules

## More readable error output

Export the `ANSIBLE_STDOUT_CALLBACK` variable

```cheat ansible Readable error output
$ export ANSIBLE_STDOUT_CALLBACK=debug
```

## copy
```
- name: "copy files"
  copy:
    src: /home/test/file
    dest: "/remote/home/test/file"
```

## chown change owner
```
- file:
  path: /usr/local/
  owner: openvas
  group: openvas
  recurse: yes
```
## copy files from tower

```
- name: "copy files"
  copy:
    src: /home/test/file
    dest: "/remote/home/test/file"
```

tags: #ansible 
