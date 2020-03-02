# Useful objdump commands

```cheat objdump show relocation entries
objdump -R ./executable
```

```cheat objdump Disassemble PLT entries
objdump -d -j .plt ./executable
```

tags: linux reversing objdump rene
