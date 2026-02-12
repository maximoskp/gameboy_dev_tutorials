// world.h

#include <gb/gb.h>
#include <stdio.h>
#include "character.h"

void character_draw(Character *c) {
    move_sprite(
        c->sprite_id,
        c->x,
        c->y
    );
}

void character_try_move(Character *c, direction_t dir, vertical_force_t vert) {
    // if (dir == DIR_NONE) {
    //     character_set_idle(c);
    //     return;
    // }

    int16_t next_x = c->x;
    int16_t next_y = c->y;

    if (dir != DIR_NONE){
        c->facing = dir;
        c->is_moving_lr = 1;
        switch (dir) {
            case DIR_LEFT:  next_x -= 1; break;
            case DIR_RIGHT: next_x += 1; break;
            default: break;
        }
    }else{
        c->is_moving_lr = 0;
    }
    c->vertical = vert;
    switch (vert) {
        case VERTICAL_ASCEND:
            next_y -= 1;
            break;
        case VERTICAL_DESCEND:
            if (!c->is_hovering){
                next_y += 1;
            }
            break;
        default: break;
    }

    if (next_x < 8){
        c->x = 8;
    }else if(next_x > 160){
        c->x = 160;
    }else{
        c->x = next_x;
    }
    if (next_y >= 140){
        c->y = 140;
        c->is_airborne = 0;
    }else if(next_y < 16){
        c->y = 16;
        c->is_airborne = 1;
    }else{
        c->y = next_y;
        c->is_airborne = 1;
    }

    move_sprite(c->sprite_id, c->x, c->y);
    character_animate(c);
    character_draw(c);
}