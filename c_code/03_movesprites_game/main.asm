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
	.globl _move_enemy
	.globl _move_player
	.globl _set_sprite_data
	.globl _joypad
	.globl _en_y_a
	.globl _en_x_a
	.globl _en_y_v
	.globl _en_x_v
	.globl _en_actual_y_position
	.globl _en_actual_x_position
	.globl _en_expanded_y_position
	.globl _en_expanded_x_position
	.globl _pl_y_a
	.globl _pl_x_a
	.globl _pl_y_v
	.globl _pl_x_v
	.globl _pl_actual_y_position
	.globl _pl_actual_x_position
	.globl _pl_expanded_y_position
	.globl _pl_expanded_x_position
	.globl _position_divisor
	.globl _max_velocity
	.globl _frame_to_update_motion
	.globl _current_frame
	.globl _currentspriteindex
	.globl _wall_down
	.globl _wall_up
	.globl _wall_left
	.globl _wall_right
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
_wall_right::
	.ds 1
_wall_left::
	.ds 1
_wall_up::
	.ds 1
_wall_down::
	.ds 1
_currentspriteindex::
	.ds 1
_current_frame::
	.ds 2
_frame_to_update_motion::
	.ds 2
_max_velocity::
	.ds 1
_position_divisor::
	.ds 1
_pl_expanded_x_position::
	.ds 2
_pl_expanded_y_position::
	.ds 2
_pl_actual_x_position::
	.ds 1
_pl_actual_y_position::
	.ds 1
_pl_x_v::
	.ds 1
_pl_y_v::
	.ds 1
_pl_x_a::
	.ds 1
_pl_y_a::
	.ds 1
_en_expanded_x_position::
	.ds 2
_en_expanded_y_position::
	.ds 2
_en_actual_x_position::
	.ds 1
_en_actual_y_position::
	.ds 1
_en_x_v::
	.ds 1
_en_y_v::
	.ds 1
_en_x_a::
	.ds 1
_en_y_a::
	.ds 1
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
;main.c:7: UINT8 wall_right = SCREENWIDTH;
	ld	hl, #_wall_right
	ld	(hl), #0xa0
;main.c:8: UINT8 wall_left = 8;
	ld	hl, #_wall_left
	ld	(hl), #0x08
;main.c:9: UINT8 wall_up = 16;
	ld	hl, #_wall_up
	ld	(hl), #0x10
;main.c:10: UINT8 wall_down = SCREENHEIGHT+(UINT8)8;
	ld	hl, #_wall_down
	ld	(hl), #0x98
;main.c:11: UINT8 currentspriteindex = 0;
	ld	hl, #_currentspriteindex
	ld	(hl), #0x00
;main.c:13: UINT16 current_frame = 0;
	ld	hl, #_current_frame
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
;main.c:15: UINT16 frame_to_update_motion = 500;
	ld	hl, #_frame_to_update_motion
	ld	(hl), #0xf4
	inc	hl
	ld	(hl), #0x01
;main.c:17: INT8 max_velocity = 64; // divided by divisor
	ld	hl, #_max_velocity
	ld	(hl), #0x40
;main.c:19: INT8 position_divisor = 16;
	ld	hl, #_position_divisor
	ld	(hl), #0x10
;main.c:25: INT8 pl_x_v = 0;
	ld	hl, #_pl_x_v
	ld	(hl), #0x00
;main.c:26: INT8 pl_y_v = 0;
	ld	hl, #_pl_y_v
	ld	(hl), #0x00
;main.c:27: INT8 pl_x_a = 0;
	ld	hl, #_pl_x_a
	ld	(hl), #0x00
;main.c:28: INT8 pl_y_a = 0;
	ld	hl, #_pl_y_a
	ld	(hl), #0x00
;main.c:34: INT8 en_x_v = 15;
	ld	hl, #_en_x_v
	ld	(hl), #0x0f
;main.c:35: INT8 en_y_v = -35;
	ld	hl, #_en_y_v
	ld	(hl), #0xdd
;main.c:36: INT8 en_x_a = 0;
	ld	hl, #_en_x_a
	ld	(hl), #0x00
;main.c:37: INT8 en_y_a = 0;
	ld	hl, #_en_y_a
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:39: void move_player(){
;	---------------------------------
; Function move_player
; ---------------------------------
_move_player::
	add	sp, #-4
;main.c:40: UINT8 joypad_value = joypad();
	call	_joypad
	ld	b, e
;main.c:41: pl_x_a = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
	ldhl	sp,	#2
	ld	(hl), b
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
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
	ld	c, a
	ld	a, b
	and	a, #0x01
	add	a, c
	ld	(#_pl_x_a),a
;main.c:42: pl_y_a = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
	ldhl	sp,	#2
	ld	a, (hl)
	and	a, #0x04
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
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
	ldhl	sp,	#2
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
	add	a, c
	ld	(#_pl_y_a),a
;main.c:44: pl_x_v += pl_x_a;
	ld	a, (#_pl_x_v)
	ld	hl, #_pl_x_a
	add	a, (hl)
	ld	(#_pl_x_v),a
;main.c:46: pl_x_v = max_velocity;
	ld	a, (#_max_velocity)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:45: if(pl_x_v > max_velocity){
	ld	hl, #_pl_x_v
	ld	e, (hl)
	ld	hl, #_max_velocity
	ld	d, (hl)
	ld	a, (hl)
	ld	hl, #_pl_x_v
	sub	a, (hl)
	bit	7, e
	jr	Z, 00162$
	bit	7, d
	jr	NZ, 00163$
	cp	a, a
	jr	00163$
00162$:
	bit	7, d
	jr	Z, 00163$
	scf
00163$:
	jr	NC, 00102$
;main.c:46: pl_x_v = max_velocity;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_pl_x_v),a
00102$:
;main.c:48: if(pl_x_v < -max_velocity){
	ld	a, (#_max_velocity)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	de, #0x0000
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#2
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_pl_x_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
;main.c:49: pl_x_v = -max_velocity;
	xor	a, a
	ld	hl, #_max_velocity
	sub	a, (hl)
	ldhl	sp,	#3
;main.c:48: if(pl_x_v < -max_velocity){
	ld	(hl-), a
	dec	hl
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00104$
;main.c:49: pl_x_v = -max_velocity;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_pl_x_v),a
00104$:
;main.c:51: pl_y_v += pl_y_a;
	ld	a, (#_pl_y_v)
	ld	hl, #_pl_y_a
	add	a, (hl)
	ld	hl, #_pl_y_v
	ld	(hl), a
;main.c:52: if(pl_y_v > max_velocity){
	ld	e, (hl)
	ld	hl, #_max_velocity
	ld	d, (hl)
	ld	a, (hl)
	ld	hl, #_pl_y_v
	sub	a, (hl)
	bit	7, e
	jr	Z, 00166$
	bit	7, d
	jr	NZ, 00167$
	cp	a, a
	jr	00167$
00166$:
	bit	7, d
	jr	Z, 00167$
	scf
00167$:
	jr	NC, 00106$
;main.c:53: pl_y_v = max_velocity;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_pl_y_v),a
00106$:
;main.c:55: if(pl_y_v < -max_velocity){
	ld	a, (#_pl_y_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ldhl	sp,	#1
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00168$
	bit	7, d
	jr	NZ, 00169$
	cp	a, a
	jr	00169$
00168$:
	bit	7, d
	jr	Z, 00169$
	scf
00169$:
	jr	NC, 00108$
;main.c:56: pl_y_v = -max_velocity;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_pl_y_v),a
00108$:
;main.c:58: pl_expanded_x_position += pl_x_v;
	ld	a, (#_pl_x_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_pl_expanded_x_position
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;main.c:59: pl_actual_x_position = pl_expanded_x_position/position_divisor;
	ld	a, (#_position_divisor)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	push	bc
	push	bc
	ld	hl, #_pl_expanded_x_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	pop	bc
	ld	hl, #_pl_actual_x_position
	ld	(hl), e
;main.c:60: pl_expanded_y_position += pl_y_v;
	ld	a, (#_pl_y_v)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_pl_expanded_y_position
	ld	a, (hl)
	add	a, e
	ld	(hl+), a
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
;main.c:61: pl_actual_y_position = pl_expanded_y_position/position_divisor;
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #_pl_actual_y_position
	ld	(hl), e
;main.c:63: if(pl_actual_x_position <= wall_left || pl_actual_x_position >= wall_right){
	ld	a, (#_wall_left)
	ld	hl, #_pl_actual_x_position
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00109$
	ld	a, (hl)
	ld	hl, #_wall_right
	sub	a, (hl)
	jr	C, 00110$
00109$:
;main.c:64: pl_x_v = -pl_x_v;
	xor	a, a
	ld	hl, #_pl_x_v
	sub	a, (hl)
	ld	(hl), a
;main.c:65: pl_actual_x_position = pl_actual_x_position <= wall_left ? wall_left : wall_right;
	bit	0, c
	jr	NZ, 00118$
	ld	a, (#_wall_left)
	jr	00119$
00118$:
	ld	a, (#_wall_right)
00119$:
	ld	(#_pl_actual_x_position),a
00110$:
;main.c:67: if(pl_actual_y_position <= wall_up || pl_actual_y_position >= wall_down){
	ld	a, (#_wall_up)
	ld	hl, #_pl_actual_y_position
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00112$
	ld	a, (hl)
	ld	hl, #_wall_down
	sub	a, (hl)
	jr	C, 00113$
00112$:
;main.c:68: pl_y_v = -pl_y_v;
	xor	a, a
	ld	hl, #_pl_y_v
	sub	a, (hl)
	ld	(hl), a
;main.c:69: pl_actual_y_position = pl_actual_y_position <= wall_up ? wall_up : wall_down;
	bit	0, c
	jr	NZ, 00120$
	ld	a, (#_wall_up)
	jr	00121$
00120$:
	ld	a, (#_wall_down)
00121$:
	ld	(#_pl_actual_y_position),a
00113$:
;main.c:71: move_sprite(0, pl_actual_x_position, pl_actual_y_position);
	ld	hl, #_pl_actual_y_position
	ld	b, (hl)
	ld	hl, #_pl_actual_x_position
	ld	c, (hl)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:71: move_sprite(0, pl_actual_x_position, pl_actual_y_position);
;main.c:72: }
	add	sp, #4
	ret
;main.c:74: void move_enemy(){
;	---------------------------------
; Function move_enemy
; ---------------------------------
_move_enemy::
	add	sp, #-4
;main.c:80: en_x_v += en_x_a;
	ld	a, (#_en_x_v)
	ld	hl, #_en_x_a
	add	a, (hl)
	ld	(#_en_x_v),a
;main.c:82: en_x_v = max_velocity;
	ld	a, (#_max_velocity)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:81: if(en_x_v > max_velocity){
	ld	hl, #_en_x_v
	ld	e, (hl)
	ld	hl, #_max_velocity
	ld	d, (hl)
	ld	a, (hl)
	ld	hl, #_en_x_v
	sub	a, (hl)
	bit	7, e
	jr	Z, 00162$
	bit	7, d
	jr	NZ, 00163$
	cp	a, a
	jr	00163$
00162$:
	bit	7, d
	jr	Z, 00163$
	scf
00163$:
	jr	NC, 00102$
;main.c:82: en_x_v = max_velocity;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_en_x_v),a
00102$:
;main.c:84: if(en_x_v < -max_velocity){
	ld	a, (#_max_velocity)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	de, #0x0000
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#2
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_en_x_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
;main.c:85: en_x_v = -max_velocity;
	xor	a, a
	ld	hl, #_max_velocity
	sub	a, (hl)
	ldhl	sp,	#3
;main.c:84: if(en_x_v < -max_velocity){
	ld	(hl-), a
	dec	hl
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00104$
;main.c:85: en_x_v = -max_velocity;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_en_x_v),a
00104$:
;main.c:87: en_y_v += en_y_a;
	ld	a, (#_en_y_v)
	ld	hl, #_en_y_a
	add	a, (hl)
	ld	hl, #_en_y_v
	ld	(hl), a
;main.c:88: if(en_y_v > max_velocity){
	ld	e, (hl)
	ld	hl, #_max_velocity
	ld	d, (hl)
	ld	a, (hl)
	ld	hl, #_en_y_v
	sub	a, (hl)
	bit	7, e
	jr	Z, 00166$
	bit	7, d
	jr	NZ, 00167$
	cp	a, a
	jr	00167$
00166$:
	bit	7, d
	jr	Z, 00167$
	scf
00167$:
	jr	NC, 00106$
;main.c:89: en_y_v = max_velocity;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_en_y_v),a
00106$:
;main.c:91: if(en_y_v < -max_velocity){
	ld	a, (#_en_y_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ldhl	sp,	#1
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00168$
	bit	7, d
	jr	NZ, 00169$
	cp	a, a
	jr	00169$
00168$:
	bit	7, d
	jr	Z, 00169$
	scf
00169$:
	jr	NC, 00108$
;main.c:92: en_y_v = -max_velocity;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_en_y_v),a
00108$:
;main.c:94: en_expanded_x_position += en_x_v;
	ld	a, (#_en_x_v)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_en_expanded_x_position
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;main.c:95: en_actual_x_position = en_expanded_x_position/position_divisor;
	ld	a, (#_position_divisor)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	push	bc
	push	bc
	ld	hl, #_en_expanded_x_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	pop	bc
	ld	hl, #_en_actual_x_position
	ld	(hl), e
;main.c:96: en_expanded_y_position += en_y_v;
	ld	a, (#_en_y_v)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_en_expanded_y_position
	ld	a, (hl)
	add	a, e
	ld	(hl+), a
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
;main.c:97: en_actual_y_position = en_expanded_y_position/position_divisor;
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #_en_actual_y_position
	ld	(hl), e
;main.c:99: if(en_actual_x_position <= wall_left || en_actual_x_position >= wall_right){
	ld	a, (#_wall_left)
	ld	hl, #_en_actual_x_position
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00109$
	ld	a, (hl)
	ld	hl, #_wall_right
	sub	a, (hl)
	jr	C, 00110$
00109$:
;main.c:100: en_x_v = -en_x_v;
	xor	a, a
	ld	hl, #_en_x_v
	sub	a, (hl)
	ld	(hl), a
;main.c:101: en_actual_x_position = en_actual_x_position <= wall_left ? wall_left : wall_right;
	bit	0, c
	jr	NZ, 00118$
	ld	a, (#_wall_left)
	jr	00119$
00118$:
	ld	a, (#_wall_right)
00119$:
	ld	(#_en_actual_x_position),a
00110$:
;main.c:103: if(en_actual_y_position <= wall_up || en_actual_y_position >= wall_down){
	ld	a, (#_wall_up)
	ld	hl, #_en_actual_y_position
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	bit	0, c
	jr	Z, 00112$
	ld	a, (hl)
	ld	hl, #_wall_down
	sub	a, (hl)
	jr	C, 00113$
00112$:
;main.c:104: en_y_v = -en_y_v;
	xor	a, a
	ld	hl, #_en_y_v
	sub	a, (hl)
	ld	(hl), a
;main.c:105: en_actual_y_position = en_actual_y_position <= wall_up ? wall_up : wall_down;
	bit	0, c
	jr	NZ, 00120$
	ld	a, (#_wall_up)
	jr	00121$
00120$:
	ld	a, (#_wall_down)
00121$:
	ld	(#_en_actual_y_position),a
00113$:
;main.c:107: move_sprite(1, en_actual_x_position, en_actual_y_position);
	ld	hl, #_en_actual_y_position
	ld	b, (hl)
	ld	hl, #_en_actual_x_position
	ld	c, (hl)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:107: move_sprite(1, en_actual_x_position, en_actual_y_position);
;main.c:108: }
	add	sp, #4
	ret
;main.c:110: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-2
;main.c:112: pl_expanded_x_position = position_divisor*88;
	ld	a, (#_position_divisor)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	d, h
	ld	hl, #_pl_expanded_x_position
	ld	(hl+), a
	ld	(hl), d
;main.c:113: pl_expanded_y_position = position_divisor*78;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	a, l
	ld	d, h
	ld	hl, #_pl_expanded_y_position
	ld	(hl+), a
	ld	(hl), d
;main.c:114: pl_actual_x_position = pl_expanded_x_position/position_divisor;
	ld	a, (#_position_divisor)
	ldhl	sp,	#0
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl), a
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #_pl_expanded_x_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	pop	bc
	ld	hl, #_pl_actual_x_position
	ld	(hl), e
;main.c:115: pl_actual_y_position = pl_expanded_y_position/position_divisor;
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #_pl_expanded_y_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	pop	bc
	ld	hl, #_pl_actual_y_position
	ld	(hl), e
;main.c:117: en_expanded_x_position = position_divisor*73;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	ld	d, h
	ld	hl, #_en_expanded_x_position
	ld	(hl+), a
	ld	(hl), d
;main.c:118: en_expanded_y_position = position_divisor*89;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	ld	d, h
	ld	hl, #_en_expanded_y_position
	ld	(hl+), a
	ld	(hl), d
;main.c:119: en_actual_x_position = en_expanded_x_position/position_divisor;
	pop	hl
	push	hl
	push	hl
	ld	hl, #_en_expanded_x_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #_en_actual_x_position
	ld	(hl), e
;main.c:120: en_actual_y_position = en_expanded_y_position/position_divisor;
	pop	hl
	push	hl
	push	hl
	ld	hl, #_en_expanded_y_position
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divuint
	add	sp, #4
	ld	hl, #_en_actual_y_position
	ld	(hl), e
;main.c:122: set_sprite_data(0, 2, Smiler);
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
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x01
;main.c:125: move_sprite(0, pl_actual_x_position, pl_actual_y_position);
	ld	hl, #_pl_actual_y_position
	ld	c, (hl)
	ld	hl, #_pl_actual_x_position
	ld	b, (hl)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:126: move_sprite(1, en_actual_x_position, en_actual_y_position);
	ld	hl, #_en_actual_y_position
	ld	c, (hl)
	ld	hl, #_en_actual_x_position
	ld	b, (hl)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:652: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;/Users/max/Documents/gb_dev/gbdk/include/gb/gb.h:653: itm->y=y, itm->x=x; 
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:127: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:129: while(1){
00104$:
;main.c:130: if(++current_frame >= frame_to_update_motion){
	ld	hl, #_current_frame
	inc	(hl)
	jr	NZ, 00122$
	inc	hl
	inc	(hl)
00122$:
	ld	de, #_current_frame
	ld	hl, #_frame_to_update_motion
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00104$
;main.c:131: current_frame = 0;
	ld	hl, #_current_frame
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:132: move_player();
	call	_move_player
;main.c:133: move_enemy();
	call	_move_enemy
	jr	00104$
;main.c:136: }
	add	sp, #2
	ret
	.area _CODE
	.area _CABS (ABS)
