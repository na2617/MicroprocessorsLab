	#include p18f87k22.inc
	
	code
	org 0x0
	goto	setup
	
	org 0x100		    ; Main code starts here at address 0x100

	; ******* Programme FLASH read Setup Code ****  
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	clrf TRISD
	movlw 0x03
	movwf LATD
	clrf TRISE
	goto	start

; ******* My data and where to put it in RAM *
myTable data	"This is just some data"
	constant 	myArray=0x400	; Address in RAM for data
	constant 	counter=0x10	; Address of counter variable
	; ******* Main programme *********************
	
start	movlw 0x0F	    ;data trying to store
	call write
	goto start
	
write	movwf LATE
	clrf TRISE
	movlw 0x01
	movwf LATD
	nop
	nop
	movlw 0x03
	movwf LATD
	setf TRISE
	return
	end
