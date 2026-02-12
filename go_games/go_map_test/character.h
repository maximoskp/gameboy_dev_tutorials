// character.h

#ifndef CHARACTER_H
#define CHARACTER_H

#include <gb/gb.h>
#include "go_8x8.h"

typedef enum {
    DIR_DOWN = 0,
    DIR_UP,
    DIR_LEFT,
    DIR_RIGHT,
    DIR_NONE   // no movement this frame
} direction_t;

const uint8_t sprite_tiles[4][3] = {
    { 0,  1,  2 },   // DIR_DOWN
    { 3,  4,  5 },   // DIR_UP
    { 6,  7,  8 },   // DIR_LEFT
    { 9, 10, 11 }    // DIR_RIGHT
};

typedef struct {
    uint16_t x;
    uint16_t y;

    direction_t facing;

    uint8_t anim_frame;     // 0 or 1
    uint8_t anim_counter;   // timing

    uint8_t sprite_id;
} Character;

void character_init(Character *c, uint8_t sprite_id, uint8_t x, uint8_t y) {
    set_sprite_data(0, 12, go);
    c->sprite_id = sprite_id;
    c->x = x;
    c->y = y;
    c->facing = DIR_DOWN;

    c->anim_frame = 0;
    c->anim_counter = 0;

    set_sprite_tile(sprite_id, sprite_tiles[DIR_DOWN][0]);
    move_sprite(sprite_id, x, y);
}

void character_animate_walk(Character *c) {
    c->anim_counter++;

    if (c->anim_counter >= 8) {  // adjust speed
        c->anim_counter = 0;
        c->anim_frame ^= 1;      // toggle 0 <-> 1
    }

    set_sprite_tile(
        c->sprite_id,
        sprite_tiles[c->facing][1 + c->anim_frame]
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

void character_move(Character *c, direction_t dir) {
    if (dir == DIR_NONE) {
        character_set_idle(c);
        return;
    }

    c->facing = dir;

    switch (dir) {
        case DIR_UP:    c->y -= 1; break;
        case DIR_DOWN:  c->y += 1; break;
        case DIR_LEFT:  c->x -= 1; break;
        case DIR_RIGHT: c->x += 1; break;
        default: break;
    }

    move_sprite(c->sprite_id, c->x, c->y);
    character_animate_walk(c);
}

#endif
