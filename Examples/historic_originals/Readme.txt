Except for HELLO.TXT, these sample programs are copied from Tom Pittman's
website:

http://www.ittybittycomputers.com/IttyBitty/TinyBasic/


Notes (15-Nov-2025):

Modify as necessary per the targeted memory map. 
(Some examples have explicit expectations of TB's location in the 
6502's memory, expecting either start-location(s) as 0x100 or 0x200).

Programs, sizes and attributes:

Note: when programs below use USR(), they are PEEK and POKE 
implementations ASSUMED to be located per the TB User manual at 
locations just after the historical 6800-cpu cold-start location (0x100):
 0x114 (PEEK) 0x118 (POKE). 
The default KIM1-low coldstart location was 0x200. 
Need to account for any differences in those assumptions.

Files: 

1. HELLO.txt

2. rnumbers.txt - 151-bytes - Prints Random Numbers

3. hexdump.txt - 2kbytes - Hex-Dump memory using the USR() function.

4. tictactoe.txt - 3.9kbytes - TicTacToe using USR() for PEEK & POKE. 

5. life.txt - 4.2kbytes - Classic Life using USR() for PEEK & POKE.

6. Euphoria.txt - 6.5kbytes - Game.

7. TFlash.txt - 6.7kbytes - Math proficiancy game.

8. Advent.txt - 25.3kBytes TB Adventure using USR() for PEEK & POKE.



