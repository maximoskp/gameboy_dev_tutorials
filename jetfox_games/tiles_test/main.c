#include <gb/gb.h>
#include "character.h"
#include "world.h"

Character player;

void main(void) {
    character_init(&player, 0, 30, 140);
    character_draw(&player);
    SHOW_SPRITES;
    while (1) {
        uint8_t keys = joypad();
        uint8_t vertical_type = VERTICAL_DESCEND;
        if (keys & J_A | keys & J_B){
            vertical_type = VERTICAL_ASCEND;
            player.is_hovering = 0;
        }
        uint8_t direction_type = DIR_NONE;
        if (keys & J_RIGHT) {
            direction_type = DIR_RIGHT;
        } else if (keys & J_LEFT) {
            direction_type = DIR_LEFT;
        }
        if (keys & J_UP){
            player.is_hovering = 1;
        }else if (keys & J_DOWN){
            player.is_hovering = 0;
        }
        character_try_move(&player, direction_type, vertical_type);

        // wait_vbl_done();
        vsync();
    }
}