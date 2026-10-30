# HereBeDragons

Unmodified upstream `2.18-release` by Hendrik Leppkes (Nevcairiel), embedded for
collection pins on the Blizzard world map and minimap. No separate addon
installation is required.

Source: https://github.com/Nevcairiel/HereBeDragons/tree/2.18-release
API: https://www.wowace.com/projects/herebedragons/pages/api/here-be-dragons-pins-2-0
License: https://www.curseforge.com/wow/addons/herebedragons/license

`HereBeDragons-2.0.lua` is revision 35; `HereBeDragons-Pins-2.0.lua` is revision 17.
The addon registers world-map pins with `AddWorldMapIconMap`, using zone-only
visibility, and minimap pins with `AddMinimapIconMap` and `floatOnEdge = false`.
HereBeDragons owns world-coordinate conversion, range, zoom, rotation, map shape,
zone changes, and movement updates. Clear unregisters only this window's pins.

Dependencies are bundled alongside it: LibStub revision 2 (public domain) and
CallbackHandler-1.0 revision 8 (Ace3 license in its folder). Their source is
https://github.com/WoWUIDev/Ace3. LibStub's original public-domain notice is kept
in its source. Upstream library files are not themed or modified by this addon.

The published HereBeDragons BSD license is reproduced in `LICENSE.txt`, including
its original unfilled copyright placeholders.
