#include <gb/gb.h>
#include <stdio.h>
#include "go_sprites.h"

// optimised to skip delay and read motion based on a counter

void main(void){
    // uint8_t wall_right = SCREENWIDTH;
    uint8_t wall_right = SCREENWIDTH-(uint8_t)8;
    uint8_t wall_left = 8;
    uint8_t wall_up = 16;
    uint8_t wall_down = SCREENHEIGHT;
    // uint8_t wall_down = SCREENHEIGHT+(uint8_t)8;
    uint8_t currentspriteindex = 0;
    // time management
    uint16_t current_frame = 0;
    // uint16_t frame_to_read_joypad = 10000;
    uint16_t frame_to_update_motion = 500;
    // motion management
    int8_t max_velocity = 32; // divided by divisor
    // velocity divisor
    int8_t position_divisor = 16;
    uint16_t expanded_x_position = position_divisor*88;
    uint16_t expanded_y_position = position_divisor*78;
    uint8_t actual_x_position = expanded_x_position/position_divisor;
    uint8_t actual_y_position = expanded_y_position/position_divisor;
    int8_t x_v = 0;
    int8_t y_v = 0;
    int8_t x_a = 0;
    int8_t y_a = 0;
    int8_t vertical_motion = 0;
    int8_t horizontal_motion = 0;

    SPRITES_8x16;
    set_sprite_data(0, 12, go);
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 2);
    move_sprite(0, actual_x_position, actual_y_position);
    move_sprite(1, actual_x_position+8, actual_y_position);
    SHOW_SPRITES;

    while(1){
        if(++current_frame >= frame_to_update_motion){
            uint8_t joypad_value = joypad();
            current_frame = 0;
            x_a = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
            y_a = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
            // printf("h: %d - v: %d\n", horizontal_motion, vertical_motion);
            x_v += x_a;
            if(x_v > max_velocity){
                x_v = max_velocity;
            }
            if(x_v < -max_velocity){
                x_v = -max_velocity;
            }
            y_v += y_a;
            if(y_v > max_velocity){
                y_v = max_velocity;
            }
            if(y_v < -max_velocity){
                y_v = -max_velocity;
            }
            expanded_x_position += x_v;
            actual_x_position = expanded_x_position/position_divisor;
            expanded_y_position += y_v;
            actual_y_position = expanded_y_position/position_divisor;
            // bounce off the wall
            if(actual_x_position <= wall_left || actual_x_position >= wall_right){
                x_v = -x_v;
                actual_x_position = actual_x_position <= wall_left ? wall_left : wall_right;
            }
            if(actual_y_position <= wall_up || actual_y_position >= wall_down){
                y_v = -y_v;
                actual_y_position = actual_y_position <= wall_up ? wall_up : wall_down;
            }
            move_sprite(0, actual_x_position, actual_y_position);
            move_sprite(1, actual_x_position+8, actual_y_position);
        }
    }
}