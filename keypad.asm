 	#include p18f87k22.inc

	global	KEY_Setup, KEY_Read  ; external Keypad subroutines
	
acs0    udata_acs   ; named variables in access ram
delay_count     res 1   ; reserve 1 byte for delay counter
result	    res 1 ; result ofrom keypress
	    
	    
KEY	code	
	
KEY_Setup
	banksel	PADCFG1
	bsf	PADCFG1, REPU
	clrf	LATE
	return
	
KEY_Read
	movlw	0x0F
	movwf	TRISE
	call	delay
	movlw	0x0F
	andwf	PORTE, W
	movwf	result
	movlw	0xF0
	movwf	TRISE
	call	delay
	movlw	0xF0
	andwf	PORTE, W
	iorwf	result, W
	return

delay	movlw	.200
	movwf	delay_count
delay_loop
	decfsz	delay_count	; decrement until zero
	bra delay_loop
	return
	
	end
	
	