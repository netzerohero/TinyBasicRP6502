.export  _init, _exit
.export  __STARTUP__ : absolute = 1
;.export ACIAout, ACIAin
.export  SNDCHR,  RCCHR 
.import  CV,WV   ; import Tiny Basic cold-start & warm-start vectors

.include "rp6502.inc"

.segment "CODE"

; Entry point
_init:
    ; 6502 doesn't reset these
    ldx #$FF
    txs
    cld

; Print "Banner / Start-up Message" message
    ldx #0
@loop:
    lda message,x
    beq @done           ; If zero, we're done
@wait:
    bit RIA_READY       ; Waiting on UART tx ready
    bpl @wait
    sta RIA_TX          ; Transmit the byte
    inx
    bne @loop           ; Continue loop
@done:
    ; Jump to Tiny Basic startup 
;   jmp CV 
    jmp FBLK 
    ; not-reached 

; Halts the 6502 by pulling RESB low
_exit:
    lda #RIA_OP_EXIT
    sta RIA_OP
    ; not-reached 


;
; Begin base system initialization - credit to: Bill O'Neill 
;
FBLK:
         jsr CLRSC                  ; Go clear the screen
         ldx #$00                   ; Offset for welcome message and prompt
         jsr SNDMSG                 ; Go print it
ST_LP:
         jsr RCCHR                  ; Go get a character from the console
         cmp #$43                   ; Check for 'C'
         bne IS_WRM                 ; If not branch to next check
;        jmp COLD_S                 ; Otherwise cold-start Tiny Basic
         jmp CV                     ; Otherwise cold-start Tiny Basic
IS_WRM:
         cmp #$57                   ; Check for 'W'
         bne PRMPT                  ; If not, branch to re-prompt them
;        jmp WARM_S                 ; Otherwise warm-start Tiny Basic
         jmp WV                     ; Otherwise warm-start Tiny Basic
PRMPT:
;        LDX #$28                   ; Offset of to c/w-boot prompt in message block
         LDX #$3E
         jsr SNDMSG                 ; Go print the prompt	 
         jmp ST_LP                  ; Go get the response



;
; Begin BIOS subroutines - credit to: Bill O'Neill 
;

;
; Clear the screen
;
CLRSC:
         ldx #$05                  ; Load X - we're going to print 05 lines
         lda #$0D                   ; CR
         jsr SNDCHR                 ; Send a carriage return
         lda #$0A                   ; LF
CSLP:
         jsr SNDCHR                 ; Send the line feed
         dex                        ; One less to do
         bne CSLP                   ; Go send another until we're done
         rts                        ; Return

;
; Print a message.
; This sub expects the message offset from MBLK in X.
;
SNDMSG:
         lda MBLK,X                 ; Get a character from the message block
         cmp #$00                   ; Look for end of message-string marker (0)
         beq EXSM                   ; Finish up if it is
         jsr SNDCHR                 ; Otherwise send the character
         inx                        ; Increment the pointer
         jmp SNDMSG                 ; Go get next character
EXSM:    rts                        ; Return



; Get a character from simulated ACIA / keyboard
; Remove RTS at bottom to run into char-out to provide screen-echo;
;  or: change JMP to JSR in jump-table for same echo effect.
;
RCCHR:
;ACIAin:
      BIT   RIA_READY
;     BVC   ACIAin            ; loop until a valid key-press char-byte is rcvd
      BVC   RCCHR             ; loop until a valid key-press char-byte is rcvd
      LDA   RIA_RX            ; get char-byte from simulated ACIA
                      ;consider masking hi-bit to ensure a valid-ASCII char
;     and #%01111111          ; Clear high bit to be valid ASCII
;
      RTS ; remove-me for local-echo and run into char-out below...


; Send a character out to simulated ACIA / screen-terminal
;
SNDCHR:
;ACIAout:
; First filter characters before sending to ACIA
    sta $FE                   ; Save the character to be printed
    cmp #$FF                  ; Check for a bunch of characters
    BEQ EXSC                  ; that we don't want to print to
    cmp #$00                  ; the terminal and discard them to
    beq EXSC                  ; clean up the output
    cmp #$91                  ;
    beq EXSC                  ;
    cmp #$93                  ;
    beq EXSC                  ;
    cmp #$80                  ;
    beq EXSC 
GETSTS:
    BIT   RIA_READY
    BPL   GETSTS              ; wait for FIFO
    lda   $FE                 ; Restore the character
    STA   RIA_TX              ; save byte to simulated ACIA - SEND CHARACTER
EXSC:
    rts                       ; Return



.segment "RODATA"

;
; The message blocks; must terminates with a 00.
;
message:
         .byte  $0C ; Formfeed - clear the screen
         .byte "Entering...", $0D, $0A, 0

MBLK:
         .byte  "TINY BASIC - Copyright 1977, Tom Pittman"
         .byte  $0D, $0A
         .byte  "RP6502 ver: 20251111"
         .byte  $0D, $0A
TBQ: ;TinyBasic Boot Question
         .byte  "Tiny Basic Boot: (C)old / (W)arm ?"
         .byte  $07, $00
