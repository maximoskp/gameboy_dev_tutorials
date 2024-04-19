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
	.globl _joypad
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
;main.c:7: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;main.c:10: UINT16 current_frame = 0;
	xor	a, a
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), a
;main.c:17: set_sprite_data(0, 2, Smiler);
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
;main.c:20: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:22: while(1){
00104$:
;main.c:23: if(++current_frame >= frame_to_update_motion){
	ldhl	sp,	#1
	inc	(hl)
	jr	NZ, 00121$
	inc	hl
	inc	(hl)
00121$:
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, #0xe8
	inc	hl
	ld	a, (hl)
	sbc	a, #0x03
	jr	C, 00104$
;main.c:24: UINT8 joypad_value = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;main.c:25: current_frame = 0;
	xor	a, a
	inc	hl
	ld	(hl+), a
;main.c:26: horizontal_motion = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
	ld	(hl-), a
	dec	hl
	ld	c, (hl)
	ld	a, c
	and	a, #0x02
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	ld	a,e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	push	af
	ldhl	sp,	#2
	ld	a, (hl)
	and	a, #0x01
	ld	e, a
	pop	af
	add	a, e
	ld	(hl), a
;main.c:27: vertical_motion = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
	ld	a, c
	and	a, #0x04
	ld	l, a
	ld	h, #0x00
	srl	h
	rr	l
	srl	h
	rr	l
	ld	e, l
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	ld	a, c
	and	a, #0x08
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	add	a, l
	ld	e, a
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:659: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:660: itm->y+=y, itm->x+=x; 
	ld	a, (bc)
	add	a, e
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#0
	add	a, (hl)
	ld	(bc), a
;main.c:29: scroll_sprite(0,horizontal_motion,vertical_motion);
	jp	00104$
;main.c:32: }
	add	sp, #3
	ret
	.area _CODE
	.area _CABS (ABS)
