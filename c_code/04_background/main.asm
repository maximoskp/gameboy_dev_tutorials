;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.3 #11868 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _delay
	.globl _backgroundmap
	.globl _backgroundtiles
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_backgroundtiles::
	.ds 128
_backgroundmap::
	.ds 720
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;simplebackground.c:26: unsigned char backgroundtiles[] =
	ld	bc, #_backgroundtiles+0
	ld	e, c
	ld	d, b
	call	__initrleblock
	.db	#-16, #0x00
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x01
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x10
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x01
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x11
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x80
	.db	#2
	.db	#0xFF, #0xFF
	.db	#-6, #0x88
	.db	#15
	.db	#0x55, #0x00, #0xAA, #0x00, #0x55, #0x00, #0xAA, #0x00
	.db	#0x55, #0x00, #0xAA, #0x00, #0x55, #0x00, #0xAA
	.db	#-9, #0x00
	.db	#7
	.db	#0xFF, #0xFF, #0xFF, #0xAA, #0xFF, #0x00, #0x55
	.db	#-11, #0x00
	.db	#5
	.db	#0xFF, #0xFF, #0x00, #0xFF, #0xFF
	.db	#-11, #0x00
	.db	#6
	.db	#0xFF, #0x00, #0xFF, #0x00, #0xFF, #0x00
	.db	#0
;simplebackgroundmap.c:25: unsigned char backgroundmap[] =
	ld	bc, #_backgroundmap+0
	ld	e, c
	ld	d, b
	call	__initrleblock
	.db	#-127, #0x00
	.db	#-127, #0x00
	.db	#-35, #0x00
	.db	#1
	.db	#0x03
	.db	#-11, #0x01
	.db	#1
	.db	#0x02
	.db	#-27, #0x00
	.db	#1
	.db	#0x03
	.db	#-11, #0x01
	.db	#1
	.db	#0x02
	.db	#-27, #0x00
	.db	#1
	.db	#0x03
	.db	#-11, #0x01
	.db	#1
	.db	#0x02
	.db	#-27, #0x00
	.db	#1
	.db	#0x03
	.db	#-11, #0x01
	.db	#1
	.db	#0x02
	.db	#-18, #0x00
	.db	#-9, #0x06
	.db	#1
	.db	#0x03
	.db	#-11, #0x01
	.db	#1
	.db	#0x02
	.db	#-17, #0x06
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#-39, #0x04
	.db	#1
	.db	#0x00
	.db	#0
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:5: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:6: set_bkg_data(0, 7, backgroundtiles);
	ld	hl, #_backgroundtiles
	push	hl
	ld	a, #0x07
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;main.c:7: set_bkg_tiles(0, 0, 40, 18, backgroundmap);
	ld	hl, #_backgroundmap
	push	hl
	ld	de, #0x1228
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:9: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;main.c:10: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;main.c:12: while(1){
00102$:
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:498: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG+0)
	inc	a
	ldh	(_SCX_REG+0),a
;main.c:14: delay(100);
	ld	hl, #0x0064
	push	hl
	call	_delay
	add	sp, #2
;main.c:16: }
	jr	00102$
	.area _CODE
	.area _CABS (ABS)
