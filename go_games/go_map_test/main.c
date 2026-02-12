#include <gb/gb.h>
#include "character.h"
#include "world.h"

Character player;

void main(void) {
    show_world();
    SHOW_BKG;
    DISPLAY_ON;
    SPRITES_8x8;
    character_init(&player, 0, 30, 30);
    camera_init(&player);
    character_draw(&player);
    SHOW_SPRITES;

    while (1) {
        uint8_t keys = joypad();
        if (keys & J_UP) {
            // character_move(&player, DIR_UP);
            character_try_move(&player, DIR_UP);
        } else if (keys & J_DOWN) {
            // character_move(&player, DIR_DOWN);
            character_try_move(&player, DIR_DOWN);
        } else if (keys & J_LEFT) {
            // character_move(&player, DIR_LEFT);
            character_try_move(&player, DIR_LEFT);
        } else if (keys & J_RIGHT) {
            // character_move(&player, DIR_RIGHT);
            character_try_move(&player, DIR_RIGHT);
        } else {
            // character_move(&player, DIR_NONE);
            character_try_move(&player, DIR_NONE);
        }

        wait_vbl_done();
    }
}

