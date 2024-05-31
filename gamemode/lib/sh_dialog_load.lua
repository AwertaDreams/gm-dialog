if CLIENT then return end
local dialogue_folder = "gamemodes/dialogue/gamemode/dialog/"
local files, directories = file.Find(dialogue_folder .. "*", "GAME" )

MsgC(Color(111,142,242), "[Dialog Loader]",Color(194,192,192), " Please wait, loading dialog's.\n")
if table.Count(files) == 0 then MsgC(Color(255,0,0), " There's a error. We haven't found any dialog files.\nPlease report this to the devs.\n") return end
MsgC(Color(111,142,242), "[Dialog Loader]",Color(194,192,192), " We found ",Color(255,255,255), table.Count(files), " dialog's\n")


local load_queue = {}

hook.Add( "PlayerInitialSpawn", "dialog/Load", function( ply )
	load_queue[ ply ] = true
end )

hook.Add( "StartCommand", "dialog/Load", function( ply, cmd )
	if load_queue[ ply ] and not cmd:IsForced() then
		load_queue[ ply ] = nil

        
        for i, _file in pairs(files) do
            MsgC(Color(111,142,242), "[Dialog Loader]", Color(194,192,192), " ",_file, "\n")
        
            data = file.Read(dialogue_folder .. _file, "GAME")
            express.Send( "dialogue_file_rw", { data, _file }, ply )
        
        end

    end
end)

MsgC(Color(111,142,242), "[Dialog Loader]",Color(255,255,255)," Finished loading all dialogues.\n")