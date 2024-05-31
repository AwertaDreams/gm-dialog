

module("dialog", package.seeall)

local dialogue_folder = "dialog/"
local files, directories = file.Find(dialogue_folder .. "*", "DATA" )

function log(text)
    MsgC(Color(111,142,242), "[Dialog]",Color(194,192,192), " ", text, " \n")
end

function dispatch(script, ply, ent)
    if CLIENT then
        log("Dispatching script via clientside " .. script .. " for player " .. tostring(ply))
        express.Send( "dialog_dispatch_server", {script, ent})
    else
        log("Dispatching script via serverside " .. script .. " for player " .. tostring(ply) .. " Hes about to talk to ")
        express.Send("dialog_dispatch_client", {script, ent}, ply)
    end
end

function read(script)
    for _, files in ipairs(files) do
        if files == script .. ".json" then
            dialog.log(files)
            log("Found the dialog, returning it.")
            data = file.Read(dialogue_folder .. files, "DATA")
            return data
        end
    end
end

function showDialogs()
    for _, files in ipairs(files) do
        log("[" .. _ .. "]" .. " " .. "Dialog: "..files)
    end
end