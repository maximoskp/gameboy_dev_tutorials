// character.h

#ifndef CHARACTER_H
#define CHARACTER_H

#include <gb/gb.h>
#include "jetfox0.h"

typedef enum {
    DIR_NONE,
    DIR_RIGHT,
    DIR_LEFT
} direction_t;

typedef enum{
    VERTICAL_ASCEND,
    VERTICAL_DESCEND
} vertical_force_t;

const uint8_t sprite_tiles[5][2] = {
    { 0, 5 },   // (right or left) and not moving and not airborn
    { 1, 2 },   // right and moving and not airborn
    { 6, 7 },    // left and moving and not airborn
    { 3, 4 },   // right and airborn
    { 8, 9 }    // left and airborn
};

typedef struct {
    uint16_t x;
    uint16_t y;

    direction_t facing;
    vertical_force_t vertical;
    uint8_t is_airborne;    // 0 or 1
    uint8_t is_moving_lr;   // 0 or 1
    uint8_t is_hovering;    // 0 or 1

    uint8_t anim_frame;     // 0 or 1
    uint8_t anim_counter;   // timing

    uint8_t sprite_id;
} Character;

void character_init(Character *c, uint8_t sprite_id, uint8_t x, uint8_t y) {
    set_sprite_data(0, 12, jetfox);
    c->sprite_id = sprite_id;
    c->x = x;
    c->y = y;
    c->facing = DIR_RIGHT;
    c->vertical = VERTICAL_DESCEND;

    c->is_airborne = 0;
    c->is_moving_lr = 0;
    c->is_hovering = 0;

    c->anim_frame = 0;
    c->anim_counter = 0;

    set_sprite_tile(sprite_id, sprite_tiles[c->facing][0]);
    move_sprite(sprite_id, x, y);
}

void character_animate(Character *c) {
    c->anim_counter++;

    if (c->anim_counter >= 8) {  // adjust speed
        c->anim_counter = 0;
        c->anim_frame ^= 1;      // toggle 0 <-> 1
    }

    uint8_t i, j;
    if (!c->is_moving_lr & !c->is_airborne){
        i = 0;
        j = c->facing - 1;
    }else{
        if (!c->is_airborne){
            i = c->facing;
            j = c->anim_frame;
        }else{
            i = c->facing + 2;
            j = c->anim_frame;
        }
    }

    set_sprite_tile(
        c->sprite_id,
        sprite_tiles[i][j]
    );
}

void character_set_idle(Character *c) {
    c->anim_frame = 0;
    c->anim_counter = 0;

    set_sprite_tile(
        c->sprite_id,
        sprite_tiles[c->facing][0]
    );
}

#endif
