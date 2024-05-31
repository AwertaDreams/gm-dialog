local PANEL = {}

function PANEL:Init()

    local targetX = 25
    local targetY = 25

    self:SetSize(500, 165)
    self:SetPos(25, -self:GetTall()) 

    self.tween = Tween(
        Vector(self:GetPos()),
        Vector(targetX, targetY),
        0.5,
        TWEEN_EASE_IN_OUT,
        function(tween)
            self:SetPos(targetX, targetY)
        end
    )



    self.tween:Start()
end

function PANEL:Think()
    if self.tween and self.tween.running then
        local currentPosition = self.tween:GetValue()
        self:SetPos(currentPosition.x, currentPosition.y)
    end

end

function PANEL:Passover(tbl)
    local choiceIndex = 1
    for key, choice in pairs(tbl) do
        if string.sub(key, 1, 1) == "c" and choice then
            self:AddButton(choiceIndex, choice, function()
                self.tween = Tween(
                    Vector(self:GetPos()),
                    Vector(-self:GetWide(), 25),
                    0.5,
                    TWEEN_EASE_IN_OUT,
                    function(tween)
                        cindex = 0
                        _key = key
                        Next(key)
                        self:SetPos(targetX, targetY)
                        self:Remove()
                    end
                )
                self.tween:Start()
            end)
            choiceIndex = choiceIndex + 1
        end
    end
end

function PANEL:AddButton(index, text, func)
    local buttonWidth = self:GetWide()
    local buttonHeight = 50
    local buttonSpacing = 6

    local button = vgui.Create("DButton", self)
    button:SetSize(buttonWidth, buttonHeight)
    button:SetPos((self:GetWide() - buttonWidth) / 2, (index - 1) * (buttonHeight + buttonSpacing))
    button:SetText(text)
    button:SetTextColor(Color(255, 255, 255))

    button.DoClick = func

    function button:Paint(w, h)

    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(58,58,58))
end

vgui.Register("ChoicePanel", PANEL, "DPanel")