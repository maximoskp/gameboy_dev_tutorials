;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:7: void main(void){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-3
;main.c:10: uint16_t current_frame = 0;
	ld	bc, #0x0000
;main.c:17: set_sprite_data(0, 2, Smiler);
	ld	de, #_Smiler
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/Users/max/gbdk/include/gb/gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;/Users/max/gbdk/include/gb/gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/max/gbdk/include/gb/gb.h:1878: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:20: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:22: while(1){
00104$:
;main.c:23: if(++current_frame >= frame_to_update_motion){
	inc	bc
	ld	a, c
	sub	a, #0xe8
	ld	a, b
	sbc	a, #0x03
	jr	C, 00104$
;main.c:24: uint8_t joypad_value = joypad();
	call	_joypad
	ldhl	sp,	#2
	ld	(hl), a
;main.c:25: current_frame = 0;
	ld	bc, #0x0000
;main.c:26: horizontal_motion = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	and	a, #0x02
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	ld	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	sub	a, e
	push	af
	ld	a, (hl)
	and	a, #0x01
	ld	e, a
	pop	af
	add	a, e
;main.c:27: vertical_motion = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	and	a, #0x04
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a,e
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	sub	a, e
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	and	a, #0x08
	ld	e, a
	ld	d, #0x00
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	add	a, l
	ld	e, a
;/Users/max/gbdk/include/gb/gb.h:1893: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/max/gbdk/include/gb/gb.h:1894: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	add	a, e
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	add	a, (hl)
	ld	(de), a
;main.c:29: scroll_sprite(0,horizontal_motion,vertical_motion);
	jr	00104$
;main.c:32: }
	add	sp, #3
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__Smiler:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.area _CABS (ABS)
