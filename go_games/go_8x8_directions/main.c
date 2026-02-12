#include <gb/gb.h>
// #include "go_8x8.h"
#include "character.h"


// void main(void){
//     SPRITES_8x8;
//     set_sprite_data(0, 11, go);
//     set_sprite_tile(0,0);

//     move_sprite(0, 88,78);
//     SHOW_SPRITES;
// }

Character player;

void main(void) {
    SPRITES_8x8;
    character_init(&player, 0, 80, 72);
    SHOW_SPRITES;

    while (1) {
        uint8_t keys = joypad();
        if (keys & J_UP) {
            character_move(&player, DIR_UP);
        } else if (keys & J_DOWN) {
            character_move(&player, DIR_DOWN);
        } else if (keys & J_LEFT) {
            character_move(&player, DIR_LEFT);
        } else if (keys & J_RIGHT) {
            character_move(&player, DIR_RIGHT);
        } else {
            character_move(&player, DIR_NONE);
        }

        wait_vbl_done();
    }
}

