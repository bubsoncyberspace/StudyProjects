
;CodeVisionAVR C Compiler V2.05.0 Evaluation
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega128
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 1024 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4351
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _digit=R5
	.DEF _digit_point=R4
	.DEF _s=R7
	.DEF _number=R6
	.DEF _ms=R8
	.DEF _rx_wr_index0=R11
	.DEF _rx_rd_index0=R10
	.DEF _rx_counter0=R13
	.DEF __lcd_x=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_comp_isr
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x47:
	.DB  0x0,0x0,0x5,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x0:
	.DB  0x45,0x52,0x52,0x4F,0x52,0x32,0x0,0x65
	.DB  0x72,0x72,0x6F,0x72,0x31,0x0,0x25,0x30
	.DB  0x32,0x64,0x20,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x07
	.DW  _0x3B
	.DW  _0x0*2

	.DW  0x07
	.DW  _0x3B+7
	.DW  _0x0*2

	.DW  0x07
	.DW  _0x3B+14
	.DW  _0x0*2+7

	.DW  0x0A
	.DW  0x04
	.DW  _0x47*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <delay.h>
;
;    #define A   0
;    #define B   1
;    #define C   6
;    #define D   2
;    #define E   3
;    #define F   4
;    #define G   5
;    #define DP  7
;
;    #define SEGMENT_PORT    PORTF
;    #define DIGIT_PORT      PORTG
;    #define DIGIT_PIN_1     1
;    #define DIGIT_PIN_2     2
;    #define DIGIT_MAX       2
;
;// Declare your global variables here
;unsigned char   digit, digit_point = 0;
;unsigned char   digit_data [2];
;unsigned char   s = 0;
;unsigned char   number = 0x5;
;unsigned int    ms = 0;
;bit             input_flag = 0;
;
;#define DATA_REGISTER_EMPTY (1<<UDRE0)
;#define RX_COMPLETE (1<<RXC0)
;#define FRAMING_ERROR (1<<FE0)
;#define PARITY_ERROR (1<<UPE0)
;#define DATA_OVERRUN (1<<DOR0)
;
;// USART0 Receiver buffer
;#define RX_BUFFER_SIZE0 8
;char rx_buffer0[RX_BUFFER_SIZE0];
;
;#if RX_BUFFER_SIZE0 <= 256
;unsigned char rx_wr_index0=0,rx_rd_index0=0;
;#else
;unsigned int rx_wr_index0=0,rx_rd_index0=0;
;#endif
;
;#if RX_BUFFER_SIZE0 < 256
;unsigned char rx_counter0=0;
;#else
;unsigned int rx_counter0=0;
;#endif
;
;// This flag is set on USART0 Receiver buffer overflow
;bit rx_buffer_overflow0;
;
;// USART0 Receiver interrupt service routine
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0000 0037 {

	.CSEG
_usart0_rx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0038 char status,data;
; 0000 0039 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 003A data=UDR0;
	IN   R16,12
; 0000 003B if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 003C    {
; 0000 003D     if (data != 0x0D){
	CPI  R16,13
	BREQ _0x4
; 0000 003E        rx_buffer0[rx_wr_index0++]=data;
	MOV  R30,R11
	INC  R11
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 003F     #if RX_BUFFER_SIZE0 == 256
; 0000 0040        // special case for receiver buffer size=256
; 0000 0041        if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 0042     #else
; 0000 0043        if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R11
	BRNE _0x5
	CLR  R11
; 0000 0044        if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x5:
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x6
; 0000 0045           {
; 0000 0046           rx_counter0=0;
	CLR  R13
; 0000 0047           rx_buffer_overflow0=1;
	SET
	BLD  R2,1
; 0000 0048           }
; 0000 0049     #endif
; 0000 004A     }
_0x6:
; 0000 004B     else input_flag = 1;
	RJMP _0x7
_0x4:
	SET
	BLD  R2,0
; 0000 004C    }
_0x7:
; 0000 004D }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART0 Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0054 {
_getchar:
; 0000 0055 char data;
; 0000 0056 while (rx_counter0==0);
	ST   -Y,R17
;	data -> R17
_0x8:
	TST  R13
	BREQ _0x8
; 0000 0057 data=rx_buffer0[rx_rd_index0++];
	MOV  R30,R10
	INC  R10
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R17,Z
; 0000 0058 #if RX_BUFFER_SIZE0 != 256
; 0000 0059 if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R10
	BRNE _0xB
	CLR  R10
; 0000 005A #endif
; 0000 005B #asm("cli")
_0xB:
	cli
; 0000 005C --rx_counter0;
	DEC  R13
; 0000 005D #asm("sei")
	sei
; 0000 005E return data;
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 005F }
;#pragma used-
;#endif
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;void NumberTHScreen (void){
; 0000 0066 void NumberTHScreen (void){
_NumberTHScreen:
; 0000 0067     DIGIT_PORT |= (DIGIT_PIN_1 | DIGIT_PIN_2);
	LDS  R30,101
	ORI  R30,LOW(0x3)
	STS  101,R30
; 0000 0068     SEGMENT_PORT = 0;
	LDI  R30,LOW(0)
	STS  98,R30
; 0000 0069     if (digit == 1) DIGIT_PORT &= ~DIGIT_PIN_1;
	LDI  R30,LOW(1)
	CP   R30,R5
	BRNE _0xC
	LDS  R30,101
	ANDI R30,0xFE
	RJMP _0x44
; 0000 006A     else if (digit == 2) DIGIT_PORT &= ~DIGIT_PIN_2;
_0xC:
	LDI  R30,LOW(2)
	CP   R30,R5
	BRNE _0xE
	LDS  R30,101
	ANDI R30,0xFD
_0x44:
	STS  101,R30
; 0000 006B     //else if (digit == 3) PORTB |= 4;
; 0000 006C     //else if (digit == 4) PORTB |= 16;
; 0000 006D 
; 0000 006E     switch (digit_data [digit - 1]) {
_0xE:
	MOV  R30,R5
	LDI  R31,0
	SBIW R30,1
	SUBI R30,LOW(-_digit_data)
	SBCI R31,HIGH(-_digit_data)
	LD   R30,Z
	LDI  R31,0
; 0000 006F         case 0:{
	SBIW R30,0
	BRNE _0x12
; 0000 0070             SEGMENT_PORT = (1 << A)|(1 << B)|(0 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(63)
	RJMP _0x45
; 0000 0071             break;
; 0000 0072         }
; 0000 0073         case 1:{
_0x12:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x13
; 0000 0074             SEGMENT_PORT = (0 << A)|(1 << B)|(0 << C)|(1 << D)|(0 << E)|(0 << F)|(0 << G);
	LDI  R30,LOW(6)
	RJMP _0x45
; 0000 0075             break;
; 0000 0076         }
; 0000 0077         case 2:{
_0x13:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x14
; 0000 0078             SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(0 << D)|(1 << E)|(1 << F)|(0 << G);
	LDI  R30,LOW(91)
	RJMP _0x45
; 0000 0079             break;
; 0000 007A         }
; 0000 007B         case 3:{
_0x14:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x15
; 0000 007C             SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(0 << G);
	LDI  R30,LOW(79)
	RJMP _0x45
; 0000 007D             break;
; 0000 007E         }
; 0000 007F         case 4:{
_0x15:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x16
; 0000 0080             SEGMENT_PORT = (0 << A)|(1 << B)|(1 << C)|(1 << D)|(0 << E)|(0 << F)|(1 << G);
	LDI  R30,LOW(102)
	RJMP _0x45
; 0000 0081             break;
; 0000 0082         }
; 0000 0083         case 5:{
_0x16:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x17
; 0000 0084             SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(1 << G);
	LDI  R30,LOW(109)
	RJMP _0x45
; 0000 0085             break;
; 0000 0086         }
; 0000 0087         case 6:{
_0x17:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x18
; 0000 0088             SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(125)
	RJMP _0x45
; 0000 0089             break;
; 0000 008A         }
; 0000 008B         case 7:{
_0x18:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x19
; 0000 008C             SEGMENT_PORT = (1 << A)|(1 << B)|(0 << C)|(1 << D)|(0 << E)|(0 << F)|(0 << G);
	LDI  R30,LOW(7)
	RJMP _0x45
; 0000 008D             break;
; 0000 008E         }
; 0000 008F         case 8:{
_0x19:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x1A
; 0000 0090             SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(127)
	RJMP _0x45
; 0000 0091             break;
; 0000 0092         }
; 0000 0093         case 9:{
_0x1A:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x1B
; 0000 0094             SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(1 << D)|(1 << E)|(0 << F)|(1 << G);
	LDI  R30,LOW(111)
	RJMP _0x45
; 0000 0095             break;
; 0000 0096         }
; 0000 0097         case '-':{
_0x1B:
	CPI  R30,LOW(0x2D)
	LDI  R26,HIGH(0x2D)
	CPC  R31,R26
	BRNE _0x1C
; 0000 0098             SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(0 << D)|(0 << E)|(0 << F)|(0 << G);
	LDI  R30,LOW(64)
	RJMP _0x45
; 0000 0099             break;
; 0000 009A         }
; 0000 009B         case 'b':{
_0x1C:
	CPI  R30,LOW(0x62)
	LDI  R26,HIGH(0x62)
	CPC  R31,R26
	BRNE _0x1D
; 0000 009C             SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(124)
	RJMP _0x45
; 0000 009D             break;
; 0000 009E         }
; 0000 009F         case 'e':{
_0x1D:
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRNE _0x1E
; 0000 00A0             SEGMENT_PORT = (1 << A)|(0 << B)|(1 << C)|(0 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(121)
	RJMP _0x45
; 0000 00A1             break;
; 0000 00A2         }
; 0000 00A3         case 'g':{
_0x1E:
	CPI  R30,LOW(0x67)
	LDI  R26,HIGH(0x67)
	CPC  R31,R26
	BRNE _0x1F
; 0000 00A4             SEGMENT_PORT = (1 << A)|(0 << B)|(0 << C)|(1 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(61)
	RJMP _0x45
; 0000 00A5             break;
; 0000 00A6         }
; 0000 00A7         case 'l':{
_0x1F:
	CPI  R30,LOW(0x6C)
	LDI  R26,HIGH(0x6C)
	CPC  R31,R26
	BRNE _0x20
; 0000 00A8             SEGMENT_PORT = (0 << A)|(0 << B)|(0 << C)|(0 << D)|(1 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(56)
	RJMP _0x45
; 0000 00A9             break;
; 0000 00AA         }
; 0000 00AB         case 'n':{
_0x20:
	CPI  R30,LOW(0x6E)
	LDI  R26,HIGH(0x6E)
	CPC  R31,R26
	BRNE _0x21
; 0000 00AC             SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(0 << E)|(1 << F)|(0 << G);
	LDI  R30,LOW(84)
	RJMP _0x45
; 0000 00AD             break;
; 0000 00AE         }
; 0000 00AF         case 'o':{
_0x21:
	CPI  R30,LOW(0x6F)
	LDI  R26,HIGH(0x6F)
	CPC  R31,R26
	BRNE _0x22
; 0000 00B0             SEGMENT_PORT = (0 << A)|(0 << B)|(1 << C)|(1 << D)|(1 << E)|(1 << F)|(0 << G);
	LDI  R30,LOW(92)
	RJMP _0x45
; 0000 00B1             break;
; 0000 00B2         }
; 0000 00B3         case 'p':{
_0x22:
	CPI  R30,LOW(0x70)
	LDI  R26,HIGH(0x70)
	CPC  R31,R26
	BRNE _0x23
; 0000 00B4             SEGMENT_PORT = (1 << A)|(1 << B)|(1 << C)|(0 << D)|(0 << E)|(1 << F)|(1 << G);
	LDI  R30,LOW(115)
	RJMP _0x45
; 0000 00B5             break;
; 0000 00B6         }
; 0000 00B7         case ' ':{
_0x23:
	CPI  R30,LOW(0x20)
	LDI  R26,HIGH(0x20)
	CPC  R31,R26
	BRNE _0x11
; 0000 00B8             SEGMENT_PORT = (0 << A)|(0 << B)|(0 << C)|(0 << D)|(0 << E)|(0 << F)|(0 << G);
	LDI  R30,LOW(0)
_0x45:
	STS  98,R30
; 0000 00B9             break;
; 0000 00BA         }
; 0000 00BB     }
_0x11:
; 0000 00BC     if ((digit_point >> (digit - 1))&1) SEGMENT_PORT |= 1 << DP;
	MOV  R26,R4
	CLR  R27
	MOV  R30,R5
	LDI  R31,0
	SBIW R30,1
	CALL __ASRW12
	ANDI R30,LOW(0x1)
	BREQ _0x25
	LDS  R30,98
	ORI  R30,0x80
	STS  98,R30
; 0000 00BD     digit ++;
_0x25:
	INC  R5
; 0000 00BE     if (digit == DIGIT_MAX+1) digit = 1;
	LDI  R30,LOW(3)
	CP   R30,R5
	BRNE _0x26
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 00BF }
_0x26:
	RET
;
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
; 0000 00C3 {
_timer0_comp_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00C4     if (ms++ == 4000) {
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,1
	CPI  R30,LOW(0xFA0)
	LDI  R26,HIGH(0xFA0)
	CPC  R31,R26
	BRNE _0x27
; 0000 00C5         ms = 0;
	CLR  R8
	CLR  R9
; 0000 00C6         if (s++ == 100) {
	MOV  R30,R7
	INC  R7
	CPI  R30,LOW(0x64)
	BRNE _0x28
; 0000 00C7             s = 0;
	CLR  R7
; 0000 00C8         }
; 0000 00C9         digit_data [0] = s / 10;
_0x28:
	MOV  R26,R7
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	STS  _digit_data,R30
; 0000 00CA         digit_data [1] = s % 10;
	MOV  R26,R7
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	__PUTB1MN _digit_data,1
; 0000 00CB         if (s == number) PORTG |= 1 << 2;
	CP   R6,R7
	BRNE _0x29
	LDS  R30,101
	ORI  R30,4
	RJMP _0x46
; 0000 00CC         else PORTG &= ~(1 << 2);
_0x29:
	LDS  R30,101
	ANDI R30,0xFB
_0x46:
	STS  101,R30
; 0000 00CD     }
; 0000 00CE     NumberTHScreen ();
_0x27:
	RCALL _NumberTHScreen
; 0000 00CF }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;void main(void)
; 0000 00D2 {
_main:
; 0000 00D3 // Declare your local variables here
; 0000 00D4 unsigned char st [17];
; 0000 00D5 unsigned char input_string [8];
; 0000 00D6 unsigned char i;
; 0000 00D7 
; 0000 00D8 // Input/Output Ports initialization
; 0000 00D9 // Port A initialization
; 0000 00DA // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00DB DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,25
;	st -> Y+8
;	input_string -> Y+0
;	i -> R17
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 00DC // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00DD PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 00DE 
; 0000 00DF // Port B initialization
; 0000 00E0 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00E1 DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(247)
	OUT  0x17,R30
; 0000 00E2 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00E3 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (1<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(16)
	OUT  0x18,R30
; 0000 00E4 
; 0000 00E5 // Port C initialization
; 0000 00E6 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00E7 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(0)
	OUT  0x14,R30
; 0000 00E8 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00E9 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 00EA 
; 0000 00EB // Port D initialization
; 0000 00EC // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00ED DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 00EE // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00EF PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 00F0 
; 0000 00F1 // Port E initialization
; 0000 00F2 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00F3 DDRE=(0<<DDE7) | (0<<DDE6) | (0<<DDE5) | (0<<DDE4) | (0<<DDE3) | (0<<DDE2) | (0<<DDE1) | (0<<DDE0);
	OUT  0x2,R30
; 0000 00F4 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00F5 PORTE=(0<<PORTE7) | (0<<PORTE6) | (0<<PORTE5) | (0<<PORTE4) | (0<<PORTE3) | (0<<PORTE2) | (0<<PORTE1) | (0<<PORTE0);
	OUT  0x3,R30
; 0000 00F6 
; 0000 00F7 // Port F initialization
; 0000 00F8 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00F9 DDRF=(1<<DDF7) | (1<<DDF6) | (1<<DDF5) | (1<<DDF4) | (1<<DDF3) | (1<<DDF2) | (1<<DDF1) | (1<<DDF0);
	LDI  R30,LOW(255)
	STS  97,R30
; 0000 00FA // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 00FB PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF3) | (0<<PORTF2) | (0<<PORTF1) | (0<<PORTF0);
	LDI  R30,LOW(0)
	STS  98,R30
; 0000 00FC 
; 0000 00FD // Port G initialization
; 0000 00FE // Function: Bit4=In Bit3=In Bit2=Out Bit1=Out Bit0=Out
; 0000 00FF DDRG=(0<<DDG4) | (0<<DDG3) | (1<<DDG2) | (1<<DDG1) | (1<<DDG0);
	LDI  R30,LOW(7)
	STS  100,R30
; 0000 0100 // State: Bit4=T Bit3=T Bit2=0 Bit1=0 Bit0=0
; 0000 0101 PORTG=(0<<PORTG4) | (0<<PORTG3) | (0<<PORTG2) | (0<<PORTG1) | (0<<PORTG0);
	LDI  R30,LOW(0)
	STS  101,R30
; 0000 0102 
; 0000 0103 // Timer/Counter 0 initialization
; 0000 0104 // Clock source: System Clock
; 0000 0105 // Clock value: 1000,000 kHz
; 0000 0106 // Mode: CTC top=OCR0
; 0000 0107 // OC0 output: Disconnected
; 0000 0108 // Timer Period: 0,25 ms
; 0000 0109 ASSR=0<<AS0;
	OUT  0x30,R30
; 0000 010A TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (1<<WGM01) | (0<<CS02) | (1<<CS01) | (0<<CS00);
	LDI  R30,LOW(10)
	OUT  0x33,R30
; 0000 010B TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 010C OCR0=0xF9;
	LDI  R30,LOW(249)
	OUT  0x31,R30
; 0000 010D 
; 0000 010E // Timer/Counter 1 initialization
; 0000 010F // Clock source: System Clock
; 0000 0110 // Clock value: Timer1 Stopped
; 0000 0111 // Mode: Normal top=0xFFFF
; 0000 0112 // OC1A output: Disconnected
; 0000 0113 // OC1B output: Disconnected
; 0000 0114 // OC1C output: Disconnected
; 0000 0115 // Noise Canceler: Off
; 0000 0116 // Input Capture on Falling Edge
; 0000 0117 // Timer1 Overflow Interrupt: Off
; 0000 0118 // Input Capture Interrupt: Off
; 0000 0119 // Compare A Match Interrupt: Off
; 0000 011A // Compare B Match Interrupt: Off
; 0000 011B // Compare C Match Interrupt: Off
; 0000 011C TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0000 011D TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 011E TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 011F TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0120 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0121 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0122 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0123 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0124 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0125 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0126 OCR1CH=0x00;
	STS  121,R30
; 0000 0127 OCR1CL=0x00;
	STS  120,R30
; 0000 0128 
; 0000 0129 // Timer/Counter 2 initialization
; 0000 012A // Clock source: System Clock
; 0000 012B // Clock value: Timer2 Stopped
; 0000 012C // Mode: Normal top=0xFF
; 0000 012D // OC2 output: Disconnected
; 0000 012E TCCR2=(0<<WGM20) | (0<<COM21) | (0<<COM20) | (0<<WGM21) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 012F TCNT2=0x00;
	OUT  0x24,R30
; 0000 0130 OCR2=0x00;
	OUT  0x23,R30
; 0000 0131 
; 0000 0132 // Timer/Counter 3 initialization
; 0000 0133 // Clock source: System Clock
; 0000 0134 // Clock value: Timer3 Stopped
; 0000 0135 // Mode: Normal top=0xFFFF
; 0000 0136 // OC3A output: Disconnected
; 0000 0137 // OC3B output: Disconnected
; 0000 0138 // OC3C output: Disconnected
; 0000 0139 // Noise Canceler: Off
; 0000 013A // Input Capture on Falling Edge
; 0000 013B // Timer3 Overflow Interrupt: Off
; 0000 013C // Input Capture Interrupt: Off
; 0000 013D // Compare A Match Interrupt: Off
; 0000 013E // Compare B Match Interrupt: Off
; 0000 013F // Compare C Match Interrupt: Off
; 0000 0140 TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	STS  139,R30
; 0000 0141 TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
	STS  138,R30
; 0000 0142 TCNT3H=0x00;
	STS  137,R30
; 0000 0143 TCNT3L=0x00;
	STS  136,R30
; 0000 0144 ICR3H=0x00;
	STS  129,R30
; 0000 0145 ICR3L=0x00;
	STS  128,R30
; 0000 0146 OCR3AH=0x00;
	STS  135,R30
; 0000 0147 OCR3AL=0x00;
	STS  134,R30
; 0000 0148 OCR3BH=0x00;
	STS  133,R30
; 0000 0149 OCR3BL=0x00;
	STS  132,R30
; 0000 014A OCR3CH=0x00;
	STS  131,R30
; 0000 014B OCR3CL=0x00;
	STS  130,R30
; 0000 014C 
; 0000 014D // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 014E TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (1<<OCIE0) | (0<<TOIE0);
	LDI  R30,LOW(2)
	OUT  0x37,R30
; 0000 014F ETIMSK=(0<<TICIE3) | (0<<OCIE3A) | (0<<OCIE3B) | (0<<TOIE3) | (0<<OCIE3C) | (0<<OCIE1C);
	LDI  R30,LOW(0)
	STS  125,R30
; 0000 0150 
; 0000 0151 // External Interrupt(s) initialization
; 0000 0152 // INT0: Off
; 0000 0153 // INT1: Off
; 0000 0154 // INT2: Off
; 0000 0155 // INT3: Off
; 0000 0156 // INT4: Off
; 0000 0157 // INT5: Off
; 0000 0158 // INT6: Off
; 0000 0159 // INT7: Off
; 0000 015A EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  106,R30
; 0000 015B EICRB=(0<<ISC71) | (0<<ISC70) | (0<<ISC61) | (0<<ISC60) | (0<<ISC51) | (0<<ISC50) | (0<<ISC41) | (0<<ISC40);
	OUT  0x3A,R30
; 0000 015C EIMSK=(0<<INT7) | (0<<INT6) | (0<<INT5) | (0<<INT4) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x39,R30
; 0000 015D 
; 0000 015E // USART0 initialization
; 0000 015F // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0160 // USART0 Receiver: On
; 0000 0161 // USART0 Transmitter: Off
; 0000 0162 // USART0 Mode: Asynchronous
; 0000 0163 // USART0 Baud Rate: 9600
; 0000 0164 UCSR0A=(0<<RXC0) | (0<<TXC0) | (0<<UDRE0) | (0<<FE0) | (0<<DOR0) | (0<<UPE0) | (0<<U2X0) | (0<<MPCM0);
	OUT  0xB,R30
; 0000 0165 UCSR0B=(1<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (1<<RXEN0) | (0<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	LDI  R30,LOW(144)
	OUT  0xA,R30
; 0000 0166 UCSR0C=(0<<UMSEL0) | (0<<UPM01) | (0<<UPM00) | (0<<USBS0) | (1<<UCSZ01) | (1<<UCSZ00) | (0<<UCPOL0);
	LDI  R30,LOW(6)
	STS  149,R30
; 0000 0167 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  144,R30
; 0000 0168 UBRR0L=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0169 
; 0000 016A // USART1 initialization
; 0000 016B // USART1 disabled
; 0000 016C UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	LDI  R30,LOW(0)
	STS  154,R30
; 0000 016D 
; 0000 016E // Analog Comparator initialization
; 0000 016F // Analog Comparator: Off
; 0000 0170 // The Analog Comparator's positive input is
; 0000 0171 // connected to the AIN0 pin
; 0000 0172 // The Analog Comparator's negative input is
; 0000 0173 // connected to the AIN1 pin
; 0000 0174 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0175 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0176 
; 0000 0177 // ADC initialization
; 0000 0178 // ADC disabled
; 0000 0179 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADFR) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 017A 
; 0000 017B // SPI initialization
; 0000 017C // SPI disabled
; 0000 017D SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 017E 
; 0000 017F // TWI initialization
; 0000 0180 // TWI disabled
; 0000 0181 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  116,R30
; 0000 0182 
; 0000 0183     digit = 1;
	LDI  R30,LOW(1)
	MOV  R5,R30
; 0000 0184     lcd_init (4);
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _lcd_init
; 0000 0185 
; 0000 0186 // Global enable interrupts
; 0000 0187 #asm("sei")
	sei
; 0000 0188 
; 0000 0189 while (1)
_0x2B:
; 0000 018A {
; 0000 018B //    if (rx_counter0 != 0){
; 0000 018C //        lcd_gotoxy (0, 0);
; 0000 018D //        sprintf (st, "%02X %02X", getchar (), getchar ());
; 0000 018E //        lcd_puts (st);
; 0000 018F //    }
; 0000 0190     if (input_flag == 1){
	SBRS R2,0
	RJMP _0x2E
; 0000 0191         i = 0;
	LDI  R17,LOW(0)
; 0000 0192         input_flag = 0;
	CLT
	BLD  R2,0
; 0000 0193         if (rx_counter0 == 2) {
	LDI  R30,LOW(2)
	CP   R30,R13
	BRNE _0x2F
; 0000 0194             while (rx_counter0 != 0) {
_0x30:
	TST  R13
	BREQ _0x32
; 0000 0195                 input_string [i++] = getchar ();
	MOV  R30,R17
	SUBI R17,-1
	LDI  R31,0
	MOVW R26,R28
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
; 0000 0196             }
	RJMP _0x30
_0x32:
; 0000 0197             if (((input_string [0] >= 0x30) && (input_string [0] <= 0x39)) && ((input_string [1] >= 0x30) && (input_string [1] <= 0x39))){
	LD   R26,Y
	CPI  R26,LOW(0x30)
	BRLO _0x34
	CPI  R26,LOW(0x3A)
	BRLO _0x35
_0x34:
	RJMP _0x36
_0x35:
	LDD  R26,Y+1
	CPI  R26,LOW(0x30)
	BRLO _0x37
	CPI  R26,LOW(0x3A)
	BRLO _0x38
_0x37:
	RJMP _0x36
_0x38:
	RJMP _0x39
_0x36:
	RJMP _0x33
_0x39:
; 0000 0198                 number = ((input_string [0] - 0x30) * 10) + (input_string [1] - 0x30);
	LD   R30,Y
	CALL SUBOPT_0x0
	LDI  R26,LOW(10)
	MULS R30,R26
	MOVW R30,R0
	MOV  R26,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x0
	ADD  R30,R26
	MOV  R6,R30
; 0000 0199             }
; 0000 019A             else {
	RJMP _0x3A
_0x33:
; 0000 019B                 lcd_gotoxy (0, 1);
	CALL SUBOPT_0x1
; 0000 019C                 lcd_puts ("ERROR2");
	__POINTW1MN _0x3B,0
	CALL SUBOPT_0x2
; 0000 019D                 delay_ms (1000);
; 0000 019E                 lcd_clear ();
; 0000 019F             }
_0x3A:
; 0000 01A0         }
; 0000 01A1         else if (rx_counter0 == 1) {
	RJMP _0x3C
_0x2F:
	LDI  R30,LOW(1)
	CP   R30,R13
	BRNE _0x3D
; 0000 01A2             if ((input_string [0] >= 0x30) && (input_string [0] <= 0x39)){
	LD   R26,Y
	CPI  R26,LOW(0x30)
	BRLO _0x3F
	CPI  R26,LOW(0x3A)
	BRLO _0x40
_0x3F:
	RJMP _0x3E
_0x40:
; 0000 01A3                 number = getchar () - 0x30;
	RCALL _getchar
	CALL SUBOPT_0x0
	MOV  R6,R30
; 0000 01A4             }
; 0000 01A5             else {
	RJMP _0x41
_0x3E:
; 0000 01A6                 lcd_gotoxy (0, 1);
	CALL SUBOPT_0x1
; 0000 01A7                 lcd_puts ("ERROR2");
	__POINTW1MN _0x3B,7
	CALL SUBOPT_0x2
; 0000 01A8                 delay_ms (1000);
; 0000 01A9                 lcd_clear ();
; 0000 01AA             }
_0x41:
; 0000 01AB         }
; 0000 01AC         else {
	RJMP _0x42
_0x3D:
; 0000 01AD             lcd_gotoxy (0, 1);
	CALL SUBOPT_0x1
; 0000 01AE             lcd_puts ("error1");
	__POINTW1MN _0x3B,14
	CALL SUBOPT_0x2
; 0000 01AF             delay_ms (1000);
; 0000 01B0             lcd_clear ();
; 0000 01B1         }
_0x42:
_0x3C:
; 0000 01B2             lcd_gotoxy (0, 0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RCALL _lcd_gotoxy
; 0000 01B3             sprintf (st, "%02d ", number);
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,14
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R6
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0000 01B4             lcd_puts (st);
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	RCALL _lcd_puts
; 0000 01B5     }
; 0000 01B6 }
_0x2E:
	RJMP _0x2B
; 0000 01B7 }
_0x43:
	RJMP _0x43

	.DSEG
_0x3B:
	.BYTE 0x15
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2000004
	SBI  0x18,4
	RJMP _0x2000005
_0x2000004:
	CBI  0x18,4
_0x2000005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	SBI  0x18,5
	RJMP _0x2000007
_0x2000006:
	CBI  0x18,5
_0x2000007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2000008
	SBI  0x18,6
	RJMP _0x2000009
_0x2000008:
	CBI  0x18,6
_0x2000009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	SBI  0x18,7
	RJMP _0x200000B
_0x200000A:
	CBI  0x18,7
_0x200000B:
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 13
	CBI  0x18,2
	__DELAY_USB 13
	RJMP _0x2080002
__lcd_write_data:
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2080002
_lcd_gotoxy:
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R30,R26
	ST   -Y,R30
	RCALL __lcd_write_data
	LDD  R12,Y+1
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
	LDI  R30,LOW(12)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(1)
	CALL SUBOPT_0x3
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	MOV  R12,R30
	RET
_lcd_putchar:
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000011
	LDS  R30,__lcd_maxx
	CP   R12,R30
	BRLO _0x2000010
_0x2000011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,__lcd_y
	SUBI R30,-LOW(1)
	STS  __lcd_y,R30
	ST   -Y,R30
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000013
	RJMP _0x2080002
_0x2000013:
_0x2000010:
	INC  R12
	SBI  0x18,0
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_data
	CBI  0x18,0
	RJMP _0x2080002
_lcd_puts:
	ST   -Y,R17
_0x2000014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000016
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2000014
_0x2000016:
	LDD  R17,Y+0
	ADIW R28,3
	RET
_lcd_init:
	SBI  0x17,4
	SBI  0x17,5
	SBI  0x17,6
	SBI  0x17,7
	SBI  0x17,2
	SBI  0x17,0
	SBI  0x17,1
	CBI  0x18,2
	CBI  0x18,0
	CBI  0x18,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R30,LOW(40)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(133)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080002:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G101:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2020012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2020014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2020014:
_0x2020013:
	RJMP _0x2020015
_0x2020010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2020015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
__print_G101:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x202001C
	CPI  R18,37
	BRNE _0x202001D
	LDI  R17,LOW(1)
	RJMP _0x202001E
_0x202001D:
	CALL SUBOPT_0x5
_0x202001E:
	RJMP _0x202001B
_0x202001C:
	CPI  R30,LOW(0x1)
	BRNE _0x202001F
	CPI  R18,37
	BRNE _0x2020020
	CALL SUBOPT_0x5
	RJMP _0x20200C9
_0x2020020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020021
	LDI  R16,LOW(1)
	RJMP _0x202001B
_0x2020021:
	CPI  R18,43
	BRNE _0x2020022
	LDI  R20,LOW(43)
	RJMP _0x202001B
_0x2020022:
	CPI  R18,32
	BRNE _0x2020023
	LDI  R20,LOW(32)
	RJMP _0x202001B
_0x2020023:
	RJMP _0x2020024
_0x202001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2020025
_0x2020024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020026
	ORI  R16,LOW(128)
	RJMP _0x202001B
_0x2020026:
	RJMP _0x2020027
_0x2020025:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x202001B
_0x2020027:
	CPI  R18,48
	BRLO _0x202002A
	CPI  R18,58
	BRLO _0x202002B
_0x202002A:
	RJMP _0x2020029
_0x202002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202001B
_0x2020029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x202002F
	CALL SUBOPT_0x6
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x7
	RJMP _0x2020030
_0x202002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2020032
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020033
_0x2020032:
	CPI  R30,LOW(0x70)
	BRNE _0x2020035
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x64)
	BREQ _0x2020039
	CPI  R30,LOW(0x69)
	BRNE _0x202003A
_0x2020039:
	ORI  R16,LOW(4)
	RJMP _0x202003B
_0x202003A:
	CPI  R30,LOW(0x75)
	BRNE _0x202003C
_0x202003B:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x202003D
_0x202003C:
	CPI  R30,LOW(0x58)
	BRNE _0x202003F
	ORI  R16,LOW(8)
	RJMP _0x2020040
_0x202003F:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2020071
_0x2020040:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x202003D:
	SBRS R16,2
	RJMP _0x2020042
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020043:
	CPI  R20,0
	BREQ _0x2020044
	SUBI R17,-LOW(1)
	RJMP _0x2020045
_0x2020044:
	ANDI R16,LOW(251)
_0x2020045:
	RJMP _0x2020046
_0x2020042:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
_0x2020046:
_0x2020036:
	SBRC R16,0
	RJMP _0x2020047
_0x2020048:
	CP   R17,R21
	BRSH _0x202004A
	SBRS R16,7
	RJMP _0x202004B
	SBRS R16,2
	RJMP _0x202004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004D
_0x202004C:
	LDI  R18,LOW(48)
_0x202004D:
	RJMP _0x202004E
_0x202004B:
	LDI  R18,LOW(32)
_0x202004E:
	CALL SUBOPT_0x5
	SUBI R21,LOW(1)
	RJMP _0x2020048
_0x202004A:
_0x2020047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x202004F
_0x2020050:
	CPI  R19,0
	BREQ _0x2020052
	SBRS R16,3
	RJMP _0x2020053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020054
_0x2020053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2020054:
	CALL SUBOPT_0x5
	CPI  R21,0
	BREQ _0x2020055
	SUBI R21,LOW(1)
_0x2020055:
	SUBI R19,LOW(1)
	RJMP _0x2020050
_0x2020052:
	RJMP _0x2020056
_0x202004F:
_0x2020058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x202005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x202005A
_0x202005C:
	CPI  R18,58
	BRLO _0x202005D
	SBRS R16,3
	RJMP _0x202005E
	SUBI R18,-LOW(7)
	RJMP _0x202005F
_0x202005E:
	SUBI R18,-LOW(39)
_0x202005F:
_0x202005D:
	SBRC R16,4
	RJMP _0x2020061
	CPI  R18,49
	BRSH _0x2020063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020062
_0x2020063:
	RJMP _0x20200CA
_0x2020062:
	CP   R21,R19
	BRLO _0x2020067
	SBRS R16,0
	RJMP _0x2020068
_0x2020067:
	RJMP _0x2020066
_0x2020068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2020069
	LDI  R18,LOW(48)
_0x20200CA:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x202006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x202006A:
_0x2020069:
_0x2020061:
	CALL SUBOPT_0x5
	CPI  R21,0
	BREQ _0x202006C
	SUBI R21,LOW(1)
_0x202006C:
_0x2020066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020059
	RJMP _0x2020058
_0x2020059:
_0x2020056:
	SBRS R16,0
	RJMP _0x202006D
_0x202006E:
	CPI  R21,0
	BREQ _0x2020070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x7
	RJMP _0x202006E
_0x2020070:
_0x202006D:
_0x2020071:
_0x2020030:
_0x20200C9:
	LDI  R17,LOW(0)
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0xA
	SBIW R30,0
	BRNE _0x2020072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x2020072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0xA
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G101)
	LDI  R31,HIGH(_put_buff_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,10
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G101
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2080001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG

	.CSEG
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_digit_data:
	.BYTE 0x2
_rx_buffer0:
	.BYTE 0x8
__base_y_G100:
	.BYTE 0x4
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R31,0
	SBIW R30,48
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x5:
	ST   -Y,R18
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x8:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ASRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __ASRW12R
__ASRW12L:
	ASR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRW12L
__ASRW12R:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
