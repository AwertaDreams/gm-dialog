AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("ui/cl_init.lua")
AddCSLuaFile("ui/dialog/cl_dialog.lua")
AddCSLuaFile("ui/dialog/cl_panel.lua")
AddCSLuaFile("ui/dialog/cl_choice.lua")
include("shared.lua")

util.AddNetworkString("entity_exlode")

function GM:PlayerSpawn(ply)
    ply:SetModel("models/player/Group03m/male_07.mdl")
    ply:SetupHands()
end

express.Receive( "dialog_dispatch_server", function(ply, data )
    dialog.log("dialog_dispatch_server has ben called.")
    

    express.Send("dialog_dispatch_client", {data[1], data[2]}, ply)
end )

net.Receive("entity_exlode", function(len, ply)
    local ent = net.ReadEntity()

    
	local explode = ents.Create( "env_explosion" )
	explode:SetPos( ply:GetPos() )
	explode:SetOwner( ent:GetOwner() )
	explode:Spawn()
	explode:SetKeyValue( "iMagnitude", "220" )
	explode:Fire( "Explode", 0, 0 )
	explode:EmitSound( "weapon_AWP.Single", 400, 400 ) 
    util.BlastDamage(ent, ent, ent:GetPos(), 100, 999)
end)


function GM:PlayerSwitchFlashlight()
    return true
end

