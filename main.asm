;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:

	mov #Array, R4

	mov #Array, Max

	add Len, Max

	add Len, Max

	sub #1, Max

	mov #Result, R10

	mov Len, R11

	mov R4,	R9

init_array:

	mov #1,	0(R9)

	incd	R9

	dec		R11

	jnz init_array

	jmp main

main:

	mov Len, R8

	clrc

	rla	R8

	clr Offset

	mov Num, R7

	clrc

	rla	R7

	sub R7,	R8

	mov R4,	R5

	add Index, R5

	add Index, Offset

	incd Index

	tst 0(R5)

	jnz count

	inc Num

	cmp Num, Len

	jn	end

	jmp main


count:

	add R7, Offset

	mov R4, R6

	add Offset, R6

	cmp R6, Max

	jn count_2

	mov #0,	0(R6)

	jmp count_2

count_2:

	cmp R8, Offset

	jn count

	mov Num, 0(R10)

	add #2,	R10

	inc Num

	jmp main

	nop

end:
	nop

                                            
	.data
	.retain


Array:	.space	58
Offset:	.short	0
Index:	.short	0
Num:	.short 	2
Len:	.short 	29
Max:	.space	2
Result:	.space	58


;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
