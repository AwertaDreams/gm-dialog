surface.CreateFont("Name", {
    font = "CreditsText",
    size = 20,
    weight = 600
})

surface.CreateFont("DialogItalic", {
    font = "Trebuchet24",
    size = 20,
    weight = 600,
    italic = true
})


voice = nil

local PANEL = {}

function PANEL:Init()
    local xSize = (ScrW() - 51)
    self:SetSize(xSize, 200)
    self:SetPos(25, ScrH()) 

    local targetX = 25
    local targetY = ScrH() - self:GetTall() - 30

    self.tween = Tween(
        Vector(self:GetPos()),
        Vector(targetX, targetY),
        0.5,
        TWEEN_EASE_IN_OUT,
        function(tween)
            self:SetPos(targetX, targetY)
        end
    )

    self.PanelText = vgui.Create("DLabel", self)
    self.PanelText:SetPos(200,0)
    self.PanelText:SetText("")
    self.PanelText:SetFont("Trebuchet24")
    self.PanelText:SetSize(self:GetWide() - 200, self:GetTall() )
    self.PanelText:SetWrap(true)
    self.PanelText:SetContentAlignment(7)

    self.ActorIcon = vgui.Create("DImage", self)
    self.ActorIcon:SetPos(0, 0)
    self.ActorIcon:SetSize(200, 150)		
    self.ActorIcon:SetImage("undefined")


    self.ActorName = vgui.Create("DLabel", self)
    self.ActorName:SetPos(0,150)
    self.ActorName:SetText("undefined")
    self.ActorName:SetFont("Name")
    self.ActorName:SetSize(200,50)
    self.ActorName:SetContentAlignment(5)

    self.tween:Start()
   --[[
    function self.ActorName:Paint(w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(158, 74, 74))
    end
    ]]

end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(58, 58, 58))
end


function PANEL:Think()
    if self.tween and self.tween.running then
        local currentPosition = self.tween:GetValue()
        self:SetPos(currentPosition.x, currentPosition.y)
    end
end


function PANEL:DSwitchActor(isSelf, image)
    if IsValid(self.ActorIcon) then
        self.ActorIcon:Remove()
    end

    if isSelf == true then
        self.ActorIcon = vgui.Create("AvatarImage", self)
        self.ActorIcon:SetPos(0, 0)
        self.ActorIcon:SetSize(200, 150)
        self.ActorIcon:SetPlayer( LocalPlayer(), 184 )
    else
        self.ActorIcon = vgui.Create("DImage", self)
        self.ActorIcon:SetPos(0, 0)
        self.ActorIcon:SetSize(200, 150)		
        self.ActorIcon:SetMaterial(image, "vgui/avatar_default")
    
    end

end

function PANEL:DSetVoice(voice)
    if voice ~= nil then
        self.voice = "talk/" .. voice .. ".mp3"
    else
        self.voice = "talk/main.mp3"
    end
end

function PANEL:DSetText(text, interval, func)
    local index = 0
    local maxIndex = #text

    local timerName = "AddTextTimer"

    local font = "Trebuchet24"
    if string.sub(text, 1, 1) == "*" then
        font = "DialogItalic" -- Purple color for text starting with an asterisk
    end
    self.PanelText:SetFont(font)
    timer.Create(timerName, interval, maxIndex, function()
        index = index + 1
        local newText = string.sub(text, 1, index)
        if IsValid(self.PanelText) then
            self.PanelText:SetText(newText)
        end

        if self.voice then
            EmitSound(self.voice, LocalPlayer():GetPos(), 1, CHAN_AUTO, 1, 75, 0, math.Rand(120,170))
        else
            dialog.log("User didn't give us a voice. Womp womp.")
        end


        
        
        if index >= maxIndex then
            timer.Remove(timerName)
            if func then
                func()
            end
        end
    end)
end

function PANEL:DError(text)
    self:DSetText("[DIALOG ERROR] \n" .. text .. "\nPlease report this issue to the developer.", 0.01)
    self.PanelText:SetColor(Color(179,0,255))
end

function PANEL:DSetActorName(text)
    self.ActorName:SetText(text)
end

function PANEL:DRemove()
    self.tween = Tween(
        Vector(self:GetPos()),
        Vector(25, ScrH()),
        0.5,
        TWEEN_EASE_IN_OUT,
        function(tween)
            self:SetPos(targetX, targetY)
            self:Remove()
        end
    )

    self.tween:Start()
end




vgui.Register("DialogPanel", PANEL, "DPanel")