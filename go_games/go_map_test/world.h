// world.h

#include <gb/gb.h>
#include <stdio.h>
#include "dungeon_tiles_test_8x8.h"
#include "maze_test.h"
#include "character.h"
// #include <gbdk/emu_debug.h>

#define SPRITE_X_OFFSET 8
#define SPRITE_Y_OFFSET 16

#define WORLD_TILE_SOLID_1 0x01
#define WORLD_TILE_SOLID_2 0x02
#define WORLD_TILE_DOOR    0x03
#define WORLD_TILE_FREE    0x00

#define TILE_SIZE 8
#define SCREEN_TILES_X 20
#define SCREEN_TILES_Y 18
#define SCROLL_MARGIN 4 // tiles
// #define SCROLL_MARGIN_PX 24

#define SCROLL_MARGIN_PX (SCROLL_MARGIN * TILE_SIZE)  // 32 pixels

#define SCREEN_WIDTH_PX  160
#define SCREEN_HEIGHT_PX 144

#define MAP_WIDTH_TILES  32
#define MAP_HEIGHT_TILES 32

#define MAP_WIDTH_PX  (MAP_WIDTH_TILES * TILE_SIZE)
#define MAP_HEIGHT_PX (MAP_HEIGHT_TILES * TILE_SIZE)

int16_t scroll_x = 0;  // in pixels
int16_t scroll_y = 0;  // in pixels

void camera_init(Character *player) {
    scroll_x = player->x - (SCREEN_WIDTH_PX / 2);
    scroll_y = player->y - (SCREEN_HEIGHT_PX / 2);

    // Clamp to map bounds
    if (scroll_x < 0) scroll_x = 0;
    if (scroll_y < 0) scroll_y = 0;

    int16_t max_x = MAP_WIDTH_PX - SCREEN_WIDTH_PX;
    int16_t max_y = MAP_HEIGHT_PX - SCREEN_HEIGHT_PX;

    if (scroll_x > max_x) scroll_x = max_x;
    if (scroll_y > max_y) scroll_y = max_y;

    move_bkg(scroll_x, scroll_y);
}

void show_world(void){
    set_bkg_data(0,4, dungeon_tiles);
    set_bkg_tiles(0,0, 32,32, maze);
}

uint8_t world_is_solid(int16_t px, int16_t py) {
    uint8_t left   = (px - SPRITE_X_OFFSET) >> 3;
    uint8_t right  = (px + 7 - SPRITE_X_OFFSET) >> 3;
    uint8_t top    = (py - SPRITE_Y_OFFSET) >> 3;
    uint8_t bottom = (py + 7 - SPRITE_Y_OFFSET) >> 3;

    // Out-of-bounds check
    if (left >= mazeWidth || right >= mazeWidth ||
        top >= mazeHeight || bottom >= mazeHeight)
        return 1;

    // Check all 4 corners
    uint8_t t1 = maze[top * mazeWidth + left];
    uint8_t t2 = maze[top * mazeWidth + right];
    uint8_t t3 = maze[bottom * mazeWidth + left];
    uint8_t t4 = maze[bottom * mazeWidth + right];

    return (t1 & WORLD_TILE_SOLID_1) || (t1 & WORLD_TILE_SOLID_2) ||
           (t2 & WORLD_TILE_SOLID_1) || (t2 & WORLD_TILE_SOLID_2) ||
           (t3 & WORLD_TILE_SOLID_1) || (t3 & WORLD_TILE_SOLID_2) ||
           (t4 & WORLD_TILE_SOLID_1) || (t4 & WORLD_TILE_SOLID_2);
}

uint8_t check_door_reached(int16_t px, int16_t py) {
    uint8_t tile_x = (px - SPRITE_X_OFFSET) >> 3;
    uint8_t tile_y = (py - SPRITE_Y_OFFSET) >> 3;

    if (tile_x >= mazeWidth || tile_y >= mazeHeight)
        return 1;

    uint8_t tile = maze[tile_y * mazeWidth + tile_x];
    return tile & WORLD_TILE_DOOR;
}

void update_camera(Character *player) {
    int16_t px = player->x;
    int16_t py = player->y;

    // Horizontal scroll
    if (px - TILE_SIZE < scroll_x + SCROLL_MARGIN_PX)
        scroll_x = px - TILE_SIZE - SCROLL_MARGIN_PX;
    else if (px > scroll_x + (SCREEN_TILES_X - SCROLL_MARGIN) * TILE_SIZE - 1)
        scroll_x = px - (SCREEN_TILES_X - SCROLL_MARGIN) * TILE_SIZE + 1;
    // Vertical scroll
    if (py - 2*TILE_SIZE < scroll_y + SCROLL_MARGIN_PX)
        scroll_y = py - 2*TILE_SIZE - SCROLL_MARGIN_PX;
    else if (py - TILE_SIZE > scroll_y + (SCREEN_TILES_Y - SCROLL_MARGIN) * TILE_SIZE - 1)
        scroll_y = py - TILE_SIZE - (SCREEN_TILES_Y - SCROLL_MARGIN) * TILE_SIZE + 1;
    
    // Clamp scroll so we don't go past map edges
    if (scroll_x < 0) scroll_x = 0;
    if (scroll_y < 0){
        scroll_y = 0;
    }

    int16_t max_scroll_x = mazeWidth * TILE_SIZE - SCREEN_TILES_X * TILE_SIZE;
    int16_t max_scroll_y = mazeHeight * TILE_SIZE - SCREEN_TILES_Y * TILE_SIZE;

    if (scroll_x > max_scroll_x) scroll_x = max_scroll_x;
    if (scroll_y > max_scroll_y){
        scroll_y = max_scroll_y;
    }
    // Apply hardware scroll
    move_bkg(scroll_x, scroll_y);
}

void character_draw(Character *c) {
    move_sprite(
        c->sprite_id,
        c->x - scroll_x,
        c->y - scroll_y
    );
}

void character_try_move(Character *c, direction_t dir) {
    if (dir == DIR_NONE) {
        character_set_idle(c);
        return;
    }

    int16_t next_x = c->x;
    int16_t next_y = c->y;
    c->facing = dir;

    switch (dir) {
        case DIR_UP:    next_y--; break;
        case DIR_DOWN:  next_y++; break;
        case DIR_LEFT:  next_x--; break;
        case DIR_RIGHT: next_x++; break;
        default: break;
    }

    if (!world_is_solid(next_x, next_y)) {
        c->x = next_x;
        c->y = next_y;
        character_animate_walk(c);
    } else {
        character_set_idle(c);
    }
    update_camera(c);
    character_draw(c);
}