.export _init, _exit
.export __STARTUP__ : absolute = 1
.export ACIAout, ACIAin
.import CV,WV   ; import Tiny Basic cold-start & warm-start vectors

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
    ; Jump to Tiny Basic start vector
    jmp CV 
    ; not-reached 

; Halts the 6502 by pulling RESB low
_exit:
    lda #RIA_OP_EXIT
    sta RIA_OP
    ; not-reached 

; character out to simulated ACIA
ACIAout:
      BIT   RIA_READY
      BPL   ACIAout           ; wait for FIFO
      STA   RIA_TX            ; save byte to simulated ACIA
      RTS

; character in from simulated ACIA
ACIAin:
      BIT   RIA_READY
;     BVC   LAB_nobyw         ; branch if no byte waiting
      BVC   ACIAin            ; loop until a valid key-press char-byte is rcvd
      LDA   RIA_RX            ; get char-byte from simulated ACIA
;      consider masking hi-bit to ensure a valid-ASCII char
      and #%01111111          ; Clear high bit to be valid ASCII
;     SEC                     ; flag byte received - this was an EhBASIC requirement; not needed for TinyBasic
      RTS
;LAB_nobyw:
;      CLC                     ; flag no byte received
;no_load:                      ; empty load vector for EhBASIC
;no_save:                      ; empty save vector for EhBASIC
;      RTS

.segment "RODATA"

message:
    .byte "Entering Tiny-Basic...", $0D, $0A, 0
