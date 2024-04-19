#include <gb/gb.h>
#include <stdio.h>
#include "SmilerSprites.c"

// optimised to skip delay and read motion based on a counter

void main(){
    UINT8 wall_right = SCREENWIDTH;
    UINT8 wall_left = 8;
    UINT8 wall_up = 16;
    UINT8 wall_down = SCREENHEIGHT+(UINT8)8;
    UINT8 currentspriteindex = 0;
    // time management
    UINT16 current_frame = 0;
    // UINT16 frame_to_read_joypad = 10000;
    UINT16 frame_to_update_motion = 500;
    // motion management
    INT8 max_velocity = 64; // divided by divisor
    // velocity divisor
    INT8 position_divisor = 16;
    UINT16 expanded_x_position = position_divisor*88;
    UINT16 expanded_y_position = position_divisor*78;
    UINT8 actual_x_position = expanded_x_position/position_divisor;
    UINT8 actual_y_position = expanded_y_position/position_divisor;
    INT8 x_v = 0;
    INT8 y_v = 0;
    INT8 x_a = 0;
    INT8 y_a = 0;
    INT8 vertical_motion = 0;
    INT8 horizontal_motion = 0;

    set_sprite_data(0, 2, Smiler);
    set_sprite_tile(0, 0);
    move_sprite(0, actual_x_position, actual_y_position);
    SHOW_SPRITES;

    while(1){
        if(++current_frame >= frame_to_update_motion){
            UINT8 joypad_value = joypad();
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
        }
    }
}