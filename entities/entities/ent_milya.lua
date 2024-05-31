AddCSLuaFile()

ENT.Type = "anim" 
ENT.Base = "base_gmodentity"
ENT.PrintName = "ent_milya"
ENT.Author = "Meowyahh"
ENT.Category = "Dialogue" 
ENT.Spawnable = true 


function ENT:Initialize()
    if SERVER then
    self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then 
        phys:Wake()
    end

    

end
end

function ENT:Use(activator, caller)
    dialog.dispatch("vendingmachine001", activator, self)


end

function ENT:Draw()
    self:DrawModel()
end