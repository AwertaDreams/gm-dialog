function lprint(luafile)
    MsgC(Color(178,103,221), "[Library Loader] ", Color(142,142,142), luafile, " \n")
    AddCSLuaFile(luafile .. ".lua")
    include(luafile .. ".lua")
end

MsgC(Color(150,150,150), "===============================\n")
lprint("sh_dialog_load")
lprint("sh_dialog")
lprint("sh_dialog_function")
lprint("sh_tween")
MsgC(Color(150,150,150), "===============================\n")


if SERVER then AddCSLuaFile("shared.lua") end