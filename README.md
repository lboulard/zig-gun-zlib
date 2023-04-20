## `zpipe` and `gun` executable with Zig build

Requires Zig 0.11-dev (or 0.11 when released).

`gun` is modified to compile with C99 and modern operating system.
`zpipe` on support `-d` option to decompress deflate encoded data.

Run `gun -t [file..]` to test GZip decompression speed.
`zpipe -d` only support `stdin` and `stdout` to read and write files.

`zlib` library comes from project
 [zig-zlib](https://github.com/mattnite/zig-zlib/tree/04ddd81478f35e12717535b256c9d9d52f4b8089).

Target architectures:

- Win32 x86_64 MSVC
- Win32 x86_64 MINGW
- Linux x86_64 GNU libc
- Linux AARCH64 GNU libc (for RPi 4)
- Linux ARM GNU libc (for RPi 3+)

### Makefile

- Run `make -j all` to build all binaries in subdirectories of `zig-out` folder.
- Run `make build` to create release binaries for native architecture in `zig-out/bin`.

Just run `zig build` to create debug binaries in `zig-out/bin`.
