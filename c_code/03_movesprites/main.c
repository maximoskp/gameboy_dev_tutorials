#include <gb/gb.h>
#include <stdio.h>
#include "SmilerSprites.c"

// optimised to skip delay and read motion based on a counter

void main(){
    UINT8 currentspriteindex = 0;
    // time management
    UINT16 current_frame = 0;
    // UINT16 frame_to_read_joypad = 10000;
    UINT16 frame_to_update_motion = 1000;
    // motion management
    INT8 vertical_motion = 0;
    INT8 horizontal_motion = 0;

    set_sprite_data(0, 2, Smiler);
    set_sprite_tile(0, 0);
    move_sprite(0, 88, 78);
    SHOW_SPRITES;

    while(1){
        if(++current_frame >= frame_to_update_motion){
            UINT8 joypad_value = joypad();
            current_frame = 0;
            horizontal_motion = -1*( (J_LEFT & joypad_value)>>1 ) + (J_RIGHT & joypad_value);
            vertical_motion = -1*( (J_UP & joypad_value)>>2 ) + ( (J_DOWN & joypad_value)>>3 );
            // printf("h: %d - v: %d\n", horizontal_motion, vertical_motion);
            scroll_sprite(0,horizontal_motion,vertical_motion);
        }
    }
}