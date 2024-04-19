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
	.globl _interruptLCD
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _add_LCD
	.globl _windowmap
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
_windowmap::
	.ds 5
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
	.db	#0x28
	.db	#-11, #0x26
	.db	#1
	.db	#0x27
	.db	#-27, #0x00
	.db	#1
	.db	#0x28
	.db	#-11, #0x26
	.db	#1
	.db	#0x27
	.db	#-27, #0x00
	.db	#1
	.db	#0x28
	.db	#-11, #0x26
	.db	#1
	.db	#0x27
	.db	#-27, #0x00
	.db	#1
	.db	#0x28
	.db	#-11, #0x26
	.db	#1
	.db	#0x27
	.db	#-18, #0x00
	.db	#-9, #0x2b
	.db	#1
	.db	#0x28
	.db	#-11, #0x26
	.db	#1
	.db	#0x27
	.db	#-17, #0x2b
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#-39, #0x29
	.db	#1
	.db	#0x00
	.db	#0
;windowmap.c:1: unsigned char windowmap[] =
	ld	bc, #_windowmap+0
	ld	e, c
	ld	d, b
	call	__initrleblock
	.db	#5
	.db	#0x13, #0x10, #0x17, #0x17, #0x1A
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
;main.c:7: void interruptLCD(){
;	---------------------------------
; Function interruptLCD
; ---------------------------------
_interruptLCD::
;main.c:8: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;main.c:9: }
	ret
;main.c:11: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:14: STAT_REG = 0x45;
	ld	a, #0x45
	ldh	(_STAT_REG+0),a
;main.c:15: LYC_REG = 0x08;  //  Fire LCD Interupt on the 8th scan line (just first row)
	ld	a, #0x08
	ldh	(_LYC_REG+0),a
;main.c:17: disable_interrupts();
	call	_disable_interrupts
;main.c:19: font_init();
	call	_font_init
;main.c:20: min_font = font_load(font_min); // 36 tile
	ld	hl, #_font_min
	push	hl
	call	_font_load
	add	sp, #2
;main.c:21: font_set(min_font);
	push	de
	call	_font_set
	add	sp, #2
;main.c:23: set_bkg_data(37, 7, backgroundtiles);
	ld	hl, #_backgroundtiles
	push	hl
	ld	de, #0x0725
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:24: set_bkg_tiles(0, 0, 40, 18, backgroundmap);
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
;main.c:26: set_win_tiles(0,0,5,1,windowmap);
	ld	hl, #_windowmap
	push	hl
	ld	de, #0x0105
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:564: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG+0),a
	ld	a, #0x00
	ldh	(_WY_REG+0),a
;main.c:29: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;main.c:30: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;main.c:31: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;main.c:33: add_LCD(interruptLCD);
	ld	hl, #_interruptLCD
	push	hl
	call	_add_LCD
	add	sp, #2
;main.c:34: enable_interrupts();
	call	_enable_interrupts
;main.c:35: set_interrupts(VBL_IFLAG | LCD_IFLAG);    
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;main.c:37: while(1){
00102$:
;main.c:38: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:498: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG+0)
	inc	a
	ldh	(_SCX_REG+0),a
;main.c:40: wait_vbl_done();
	call	_wait_vbl_done
;main.c:42: }
	jr	00102$
	.area _CODE
	.area _CABS (ABS)
