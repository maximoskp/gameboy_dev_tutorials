#include <gb/gb.h>
#include <stdio.h>
#include "SmilerSprites.c"

// optimised to skip delay and read motion based on a counter

uint8_t wall_right = SCREENWIDTH;
uint8_t wall_left = 8;
uint8_t wall_up = 16;
uint8_t wall_down = SCREENHEIGHT+(uint8_t)8;
uint8_t currentspriteindex = 0;
// time management
uint16_t current_frame = 0;
// uint16_t frame_to_read_joypad = 10000;
uint16_t frame_to_update_motion = 500;
// motion management
int8_t max_velocity = 64; // divided by divisor
// velocity divisor
int8_t position_divisor = 16;
// player data
uint16_t pl_expanded_x_position;
uint16_t pl_expanded_y_position;
uint8_t pl_actual_x_position;
uint8_t pl_actual_y_position;
int8_t pl_x_v = 0;
int8_t pl_y_v = 0;
int8_t pl_x_a = 0;
int8_t pl_y_a = 0;
// enemy data
uint16_t en_expanded_x_position;
uint16_t en_expanded_y_position;
uint8_t en_actual_x_position;
uint8_t en_actual_y_position;
int8_t en_x_v = 15;
int8_t en_y_v = -35;
int8_t en_x_a = 0;
int8_t en_y_a = 0;

void move_player(){
    uint8_t joypad_value = joypad();
    pl_x_a = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
    pl_y_a = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
    // printf("h: %d - v: %d\n", horizontal_motion, vertical_motion);
    pl_x_v += pl_x_a;
    if(pl_x_v > max_velocity){
        pl_x_v = max_velocity;
    }
    if(pl_x_v < -max_velocity){
        pl_x_v = -max_velocity;
    }
    pl_y_v += pl_y_a;
    if(pl_y_v > max_velocity){
        pl_y_v = max_velocity;
    }
    if(pl_y_v < -max_velocity){
        pl_y_v = -max_velocity;
    }
    pl_expanded_x_position += pl_x_v;
    pl_actual_x_position = pl_expanded_x_position/position_divisor;
    pl_expanded_y_position += pl_y_v;
    pl_actual_y_position = pl_expanded_y_position/position_divisor;
    // bounce off the wall
    if(pl_actual_x_position <= wall_left || pl_actual_x_position >= wall_right){
        pl_x_v = -pl_x_v;
        pl_actual_x_position = pl_actual_x_position <= wall_left ? wall_left : wall_right;
    }
    if(pl_actual_y_position <= wall_up || pl_actual_y_position >= wall_down){
        pl_y_v = -pl_y_v;
        pl_actual_y_position = pl_actual_y_position <= wall_up ? wall_up : wall_down;
    }
    move_sprite(0, pl_actual_x_position, pl_actual_y_position);
}

void move_enemy(){
    // uint8_t joypad_value = joypad();
    // current_frame = 0;
    // pl_x_a = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
    // pl_y_a = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
    // printf("h: %d - v: %d\n", horizontal_motion, vertical_motion);
    en_x_v += en_x_a;
    if(en_x_v > max_velocity){
        en_x_v = max_velocity;
    }
    if(en_x_v < -max_velocity){
        en_x_v = -max_velocity;
    }
    en_y_v += en_y_a;
    if(en_y_v > max_velocity){
        en_y_v = max_velocity;
    }
    if(en_y_v < -max_velocity){
        en_y_v = -max_velocity;
    }
    en_expanded_x_position += en_x_v;
    en_actual_x_position = en_expanded_x_position/position_divisor;
    en_expanded_y_position += en_y_v;
    en_actual_y_position = en_expanded_y_position/position_divisor;
    // bounce off the wall
    if(en_actual_x_position <= wall_left || en_actual_x_position >= wall_right){
        en_x_v = -en_x_v;
        en_actual_x_position = en_actual_x_position <= wall_left ? wall_left : wall_right;
    }
    if(en_actual_y_position <= wall_up || en_actual_y_position >= wall_down){
        en_y_v = -en_y_v;
        en_actual_y_position = en_actual_y_position <= wall_up ? wall_up : wall_down;
    }
    move_sprite(1, en_actual_x_position, en_actual_y_position);
}

void main(){

    pl_expanded_x_position = position_divisor*88;
    pl_expanded_y_position = position_divisor*78;
    pl_actual_x_position = pl_expanded_x_position/position_divisor;
    pl_actual_y_position = pl_expanded_y_position/position_divisor;

    en_expanded_x_position = position_divisor*73;
    en_expanded_y_position = position_divisor*89;
    en_actual_x_position = en_expanded_x_position/position_divisor;
    en_actual_y_position = en_expanded_y_position/position_divisor;

    set_sprite_data(0, 2, Smiler);
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 1);
    move_sprite(0, pl_actual_x_position, pl_actual_y_position);
    move_sprite(1, en_actual_x_position, en_actual_y_position);
    SHOW_SPRITES;

    while(1){
        if(++current_frame >= frame_to_update_motion){
            current_frame = 0;
            move_player();
            move_enemy();
        }
    }
}
