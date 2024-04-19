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
	add	sp, #-13
;main.c:14: UINT16 current_frame = 0;
	xor	a, a
	ldhl	sp,	#5
	ld	(hl+), a
;main.c:21: UINT16 expanded_x_position = position_divisor*88;
	ld	(hl+), a
	ld	a, #0x80
	ld	(hl+), a
;main.c:22: UINT16 expanded_y_position = position_divisor*78;
	ld	a, #0x05
	ld	(hl+), a
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0x04
;main.c:25: INT8 x_v = 0;
	xor	a, a
	inc	hl
	ld	(hl), a
;main.c:26: INT8 y_v = 0;
	xor	a, a
	inc	hl
	ld	(hl), a
;main.c:32: set_sprite_data(0, 2, Smiler);
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
;main.c:35: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:37: while(1){
00118$:
;main.c:38: if(++current_frame >= frame_to_update_motion){
	ldhl	sp,	#5
	inc	(hl)
	jr	NZ, 00179$
	inc	hl
	inc	(hl)
00179$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0xf4
	inc	hl
	ld	a, (hl)
	sbc	a, #0x01
	jr	C, 00118$
;main.c:39: UINT8 joypad_value = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), e
;main.c:40: current_frame = 0;
	xor	a, a
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), a
;main.c:41: x_a = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	and	a, #0x02
	inc	hl
	inc	hl
	ld	(hl+), a
	ld	a, #0x00
	ld	(hl-), a
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	ld	c, a
	ldhl	sp,	#0
	ld	a, (hl)
	and	a, #0x01
	add	a, c
	ld	c, a
;main.c:42: y_a = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
	inc	hl
	ld	a, (hl)
	and	a, #0x04
	ld	e, a
	ld	b, #0x00
	srl	b
	rr	e
	srl	b
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
	ld	b, a
	ldhl	sp,	#1
	ld	a, (hl)
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
	add	a, b
	ldhl	sp,	#4
	ld	(hl), a
;main.c:44: x_v += x_a;
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, c
	ld	(hl), a
;main.c:45: if(x_v > max_velocity){
	ld	e, (hl)
	ld	a,#0x40
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00180$
	bit	7, d
	jr	NZ, 00181$
	cp	a, a
	jr	00181$
00180$:
	bit	7, d
	jr	Z, 00181$
	scf
00181$:
	jr	NC, 00102$
;main.c:46: x_v = max_velocity;
	ldhl	sp,	#11
	ld	(hl), #0x40
00102$:
;main.c:48: if(x_v < -max_velocity){
	ldhl	sp,	#11
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	a, c
	sub	a, #0xc0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00104$
;main.c:49: x_v = -max_velocity;
	ld	(hl), #0xc0
00104$:
;main.c:51: y_v += y_a;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;main.c:52: if(y_v > max_velocity){
	ld	e, (hl)
	ld	a,#0x40
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00182$
	bit	7, d
	jr	NZ, 00183$
	cp	a, a
	jr	00183$
00182$:
	bit	7, d
	jr	Z, 00183$
	scf
00183$:
	jr	NC, 00106$
;main.c:53: y_v = max_velocity;
	ldhl	sp,	#12
	ld	(hl), #0x40
00106$:
;main.c:55: if(y_v < -max_velocity){
	ldhl	sp,	#12
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	a, c
	sub	a, #0xc0
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00108$
;main.c:56: y_v = -max_velocity;
	ld	(hl), #0xc0
00108$:
;main.c:58: expanded_x_position += x_v;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	a, l
	ld	d, h
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), d
;main.c:59: actual_x_position = expanded_x_position/position_divisor;
	ld	hl, #0x0010
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ldhl	sp,	#3
	ld	(hl), e
;main.c:60: expanded_y_position += y_v;
	ldhl	sp,	#12
	ld	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	a, l
	ld	d, h
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), d
;main.c:61: actual_y_position = expanded_y_position/position_divisor;
	ld	hl, #0x0010
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ldhl	sp,	#4
	ld	(hl), e
;main.c:63: if(actual_x_position <= wall_left || actual_x_position >= wall_right){
	ld	a, #0x08
	dec	hl
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00109$
	ld	a, (hl)
	sub	a, #0xa0
	jr	C, 00110$
00109$:
;main.c:64: x_v = -x_v;
	xor	a, a
	ldhl	sp,	#11
	sub	a, (hl)
	ld	(hl), a
;main.c:65: actual_x_position = actual_x_position <= wall_left ? wall_left : wall_right;
	bit	0, c
	ld	a, #0x08
	jr	Z, 00126$
	ld	a, #0xa0
00126$:
	ldhl	sp,	#3
	ld	(hl), a
00110$:
;main.c:67: if(actual_y_position <= wall_up || actual_y_position >= wall_down){
	ld	a, #0x10
	ldhl	sp,	#4
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00112$
	ld	a, (hl)
	sub	a, #0x98
	jr	C, 00113$
00112$:
;main.c:68: y_v = -y_v;
	xor	a, a
	ldhl	sp,	#12
	sub	a, (hl)
	ld	(hl), a
;main.c:69: actual_y_position = actual_y_position <= wall_up ? wall_up : wall_down;
	bit	0, c
	ld	a, #0x10
	jr	Z, 00128$
	ld	a, #0x98
00128$:
	ldhl	sp,	#4
	ld	(hl), a
00113$:
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	dec	hl
	ld	a, (hl)
	ld	(bc), a
;main.c:71: move_sprite(0, actual_x_position, actual_y_position);
	jp	00118$
;main.c:74: }
	add	sp, #13
	ret
	.area _CODE
	.area _CABS (ABS)
