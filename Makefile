
ZIG ?= zig
ZIG_CACHE?=zig-cache
OUTDIR=zig-out

.PHONY: build
build:
	"$(ZIG)" build -Doptimize=ReleaseFast $(ZIG_FLAGS)

.PHONY: debug
debug:
	"$(ZIG)" build $(ZIG_FLAGS)

.PHONY: all
all: win32-all linux-all

.PHONY: win32-msvc
win32-msvc:
	"$(ZIG)" build -Doptimize=ReleaseFast -Dtarget=x86_64-windows-msvc -Dcpu=x86_64_v3 $(ZIG_FLAGS) -p "$(OUTDIR)/win32-x86_64-msvc"

.PHONY: win32-mingw
win32-mingw:
	"$(ZIG)" build -Doptimize=ReleaseFast -Dtarget=x86_64-windows-gnu -Dcpu=x86_64_v3 $(ZIG_FLAGS) -p "$(OUTDIR)/win32-x86_64-mingw"

.PHONY: win32-all
win32-all: win32-msvc win32-mingw

.PHONY: linux-amd64
linux-amd64:
	"$(ZIG)" build -Doptimize=ReleaseFast -Dtarget=x86_64-linux-gnu -Dcpu=x86_64_v3 $(ZIG_FLAGS) -p "$(OUTDIR)/linux-amd64"

# Raspberry Pi 4: BCM2711
.PHONY: linux-aarch64
linux-aarch64:
	"$(ZIG)" build -Doptimize=ReleaseFast -Dtarget=aarch64-linux-gnu -Dcpu=cortex_a72 $(ZIG_FLAGS) -p "$(OUTDIR)/linux-aarch64"

# Raspberry Pi 3: BCM2837
.PHONY: linux-arm
linux-arm:
	"$(ZIG)" build -Doptimize=ReleaseFast -Dtarget=arm-linux-gnueabihf -Dcpu=cortex_a53 $(ZIG_FLAGS) -p "$(OUTDIR)/linux-arm"

.PHONY: linux
linux: linux-amd64

.PHONY: linux-all
linux-all: linux-amd64 linux-aarch64 linux-arm

.PHONY: clean
clean:
	$(RM) -fr $(OUTDIR)

.PHONY: clobber
clobber: clean
	$(RM) -fr $(ZIG_CACHE)
