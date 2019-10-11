	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start
	movlw 	0x0
	movwf	TRISC, ACCESS	    ; Port C all outputs
	bra 	test
	
	
delay2	decfsz	0x11
	bra	delay2
	return
	
delay	decfsz	0x10
	bra	delay
	movlw	0x3
	movwf	0x11
	bra	delay2	
	
loop	movff 	0x06, PORTC
	movlw	0x3
	movwf	0x10
	call	delay
	incf 	0x06, W, ACCESS
	
test	movwf	0x06, ACCESS	    ; Test for end of loop condition
	movf 	PORTD, W, ACCESS
	;call	delay
	cpfsgt 	0x06, ACCESS
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start
		
	end