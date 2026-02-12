First create a column-wise layout of all sprites, e.g., three 16x16 sprites will be 16x48.

Export it as png.

Run
~/gbdk/bin/png2asset test.png -sw 16 -sh 16

-sw: sprite width
-sh: sprite height

see https://gbdk.org/docs/api/docs_toolchain_settings.html#png2asset-settings for more info.