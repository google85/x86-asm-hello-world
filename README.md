## x86 Youtube clip
- based on [YouTube video](https://www.youtube.com/watch?v=HgEGAaYdABA)


- using custom `.devcontainer` that includes:
    - [hexdump](from `bsdmainutils` package)
    - [ld](from `binutils` package)
    - [nasm](https://nasm.us/docs/3.01/)

#

- Documentation:
    - ```bash man 2 write```
    - ```bash man 2 exit```

#

### Usage:
```bash
make build
```

### Equivalent C build:
```bash
gcc -nostdlib -nostartfiles -static -O2 -s -o ./build/hello-world.equiv-02 ./src/hello_world.equivalent-02.c -lc
# doesn't work yet
gcc -nostdlib -nostartfiles -static -s -o ./build/hello-world.equiv-01 ./src/hello_world.equivalent.c
```