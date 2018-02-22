`script.sh` creates two repos:

```
repoa
repob
```

They contain the same content (a single line in a single file).

`repoa` has two commits (`C1` and `C2`), which each add a line.

`repob` adds `repoa` as a remote, and `C2` is cherry-picked.

I expected the line from `C2` to be added, but `C1`'s line is brought over too. Why?

