# TINY BASIC for the RP6502

This is my port of Tom Pittman's TINY BASIC to the [RP6502](https://picocomputer.github.io/).

Code here was based-on Hans Otten's carefully reconstructed version from audio-tapes originally targetted to the [KIM-1] (https://en.wikipedia.org/wiki/KIM-1).
 
TINY BASIC along with the inception of the People's Computer Company's (PCC) Dr. Dobb's Journal (DDJ) in the mid-1970s are important milestones in computer history. At the time, the BASIC language brought ease-of-use to the computer user. Hobbiests provided the creative energy driving computer HW & SW improvements. Differences between hobbiest approaches and those of the naccent computer HW/SW industry on code sharing and its distribution were being work through. The various forms of BASIC stood at the center of these different approaches. The alternative approach of code distribution was represented by MicroSoft's BASIC. These different approaches have infuenced the commercial and the communinty-driven licensing and distribution approaches of software development to the present day now 50-years hence.

My initial exposure to TINY BASIC was in the late 1970's. After building my own [Netronics ELF II](https://carleton.ca/scs/vintage-computing/item/vin17/) RCA-1802 system and its 4K static-RAM board, I bought a copy of TINY BASIC on cassette-tape along with Pittman's infuential and approachably instructive manuals. I still own them...

Internally, TINY BASIC (TB) runs its own intermediate-language byte-code interpretter (TBIL) of the language. Porting to different CPUs involved directly re-using the TBIL program, only having to port the native Machine-Language (ML) code interpreting TBIL on the varity of CPUs that ran TINY BASIC.


## References:

http://en.wikipedia.org/wiki/Tiny_BASIC
http://www.ittybittycomputers.com/IttyBitty/TinyBasic/index.htm
http://www.ittybittycomputers.com/IttyBitty/TinyBasic/TinyBasic.asm

The elegance of TINY BASICS's architecture allow the 1802-ELF and the 6502-KIM1 to share the same underlying TBIL. Credit to Hans Otten for the KIM-1 source-code origins of this port:

http://retro.hansotten.nl/6502-sbc/kim-1-manuals-and-software/kim-1-software/tiny-basic


## Usage:

Load TINY BASIC as you would any other RP6502 software package. [See the RP6052 site](https://github.com/picocomputer/examples). Following the banner start-up message, select either 'C' or 'W' (in CAPS-ONLY) for a Cold or Warm TINY BASIC startup.  Enter your TINY BASIC program and enjoy yesterday's simplicity!

## Issues:

Running TINY BASIC on the RP6502 is currently limited to the original 1-MHz; so 'SET PHI2 1000' on the RP6052 prior to TB startup.  I believe this limitation is tied to TINY BASIC's handling of BREAK-detection on the serial-line and exposes itself (say) when listing a large TB program. 


