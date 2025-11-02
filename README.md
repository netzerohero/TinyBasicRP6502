# TinyBasic for the RP6502

This is my (currently unworking) port of Tom Pittman's TinyBasic to the RP6502.

Initial code here was originally targetted to the KIM-1.

TinyBasic (and the origins of Dr. Dobb's Journal - DDJ) are important milestones in computer history and are in contrast with the recent (Sept-2025) open-source release of Microsoft's Basic whose origins were around the same time as Tiny Basic as well as DDJ.
My initial exposure to Tiny-Basic was in the late 1970's. I bought a copy of TinyBasic on cassette-tape along with Pittman's manuals after building my own [Netronics ELF II] (https://carleton.ca/scs/vintage-computing/item/vin17/) RCA-1802 system and its 4K static-RAM board.  I still own them...

Internally, TinyBasic (TB) runs its own intermediate-language byte-code interpretter (TBIL) of the TinyBasic language. Porting to different CPUs involved re-using the TBIL program, only have to port the native Machine-Language (ML) code to the varity of CPUs that ran TinyBasic.

References:
http://en.wikipedia.org/wiki/Tiny_BASIC
http://www.ittybittycomputers.com/IttyBitty/TinyBasic/index.htm
http://www.ittybittycomputers.com/IttyBitty/TinyBasic/TinyBasic.asm
http://retro.hansotten.nl/6502-sbc/kim-1-manuals-and-software/kim-1-software/tiny-basic


## RP6502 VSCode Scaffolding for CC65

This provides scaffolding for a new Picocomputer 6502 software project. Both
C and assembly examples of "Hello, world!" are included. Make sure
`CMakeLists.txt` points to your choice of `main.c` or `main.s`, then delete
the one you aren't using.

### Linux Tools Install:
 * [VSCode](https://code.visualstudio.com/) - This has its own installer.
 * A source build of [CC65](https://cc65.github.io/getting-started.html).
 * The following tools installed from your package managers:
    * `sudo apt install cmake python3 pip git build-essential`
    * `pip install pyserial`

### Windows Tools Install:
 * `winget install -e --id Microsoft.VisualStudioCode`
 * `winget install -e --id Git.Git`
 * `winget install -e --id Kitware.CMake`
 * `winget install -e --id GnuWin32.Make`
    Add `C:\Program Files (x86)\GnuWin32\bin` to your PATH.
 * The current snapshot of [CC65](https://cc65.github.io/getting-started.html) -
   Do not skip the step about adding the `bin` directory to your PATH.
 * Install Python by typing `python3` in a command prompt, which will launch
   the Microsoft Store where you can start the installation. If Python runs,
   this has already been done — exit Python with Ctrl-Z plus Enter.
 * `pip install pyserial`

### Getting Started:
Go to the [GitHub template](https://github.com/picocomputer/vscode-cc65) and
select "Use this template" then "Create a new repository". GitHub will create
a clean project for you to start with. Then you can clone the repository and
open the files.

```bash
$ git clone [path_to_github]
$ cd [to_where_it_cloned]
$ code .
```

Install the recommended extensions when VSCode prompts you, choosing the
default or obvious choice for any other prompts. The tools we use in VSCode
are constantly improving and changing making it too difficult to maintain
documentation.

"Start Debugging" (F5) will build your project and upload it to the
Picocomputer over a USB cable plugged into the RP6502 VGA USB port.

If you get a Python error about the communications device not being found,
edit `.rp6502` in the project root. This file will be created the first time
you "Start Debugging" and will be ignored by git.

Once the upload is complete, a debug console becomes available on the terminal
tab. It will say "Python Debug Console" because the rp6502.py tool is Python.
Ctrl-A then X will exit. Ctrl-A then B will send a break.

Edit `CMakeLists.txt` to add new source and asset files. From here on, it's
standard C/assembly development for the 6502 platform.
