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
	.globl _set_sprite_data
	.globl _delay
	.globl _Smiler
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_Smiler::
	.ds 32
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
;SmilerSprites.c:26: unsigned char Smiler[] =
	ld	bc, #_Smiler+0
	ld	e, c
	ld	d, b
	call	__initrleblock
	.db	#32
	.db	#0x7E, #0x7E, #0xFF, #0x81, #0xFF, #0xA5, #0xFF, #0x81
	.db	#0xFF, #0x81, #0xFF, #0xBD, #0xFF, #0x81, #0x7E, #0x7E
	.db	#0x7E, #0x7E, #0xFF, #0x81, #0xFF, #0xA5, #0xFF, #0x81
	.db	#0xFF, #0xA5, #0xFF, #0x99, #0xFF, #0x81, #0x7E, #0x7E
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
;main.c:6: UINT8 currentspriteindex = 0;
	ld	c, #0x00
;main.c:8: set_sprite_data(0, 2, Smiler);
	ld	hl, #_Smiler
	push	hl
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:11: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:13: while(1){
00105$:
;main.c:14: if(currentspriteindex==0){
	ld	a, c
	or	a, a
;main.c:15: currentspriteindex = 1;
;main.c:18: currentspriteindex = 0;
	ld	c, #0x01
	jr	Z, 00103$
	ld	c, #0x00
00103$:
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:610: shadow_OAM[nb].tile=tile; 
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), c
;main.c:21: delay(1000);
	push	bc
	ld	hl, #0x03e8
	push	hl
	call	_delay
	add	sp, #2
	pop	bc
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:659: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:660: itm->y+=y, itm->x+=x; 
	ld	a, (de)
	ld	(de), a
	inc	de
	ld	a, (de)
	add	a, #0x0a
	ld	(de), a
;main.c:22: scroll_sprite(0,10,0);
;main.c:24: }
	jr	00105$
	.area _CODE
	.area _CABS (ABS)
