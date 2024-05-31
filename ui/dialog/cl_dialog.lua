include("cl_panel.lua")
include("cl_choice.lua")

dialogFile = nil
dialogEnt = nil
locked = false
inChoiceBranch = false 
deb = false
index = 0
cindex = 0
_key = nil
canClick = true



express.Receive("dialog_dispatch_client", function(data)
    if data[1] == nil then 
        dialog.log("dialog_dispatch_client has been called, but the data was nil. Did the client got the dialog files?")
    end

    dialog.log("dialog_dispatch_client has been called. Running CreateDialogPanel.")

    dialogFile = util.JSONToTable(dialog.read(data[1]))
    dialogEnt = data[2]
    index = 0
    cindex = 0

    RegisterInit()
    CreateDialogPanel()
end)

function RegisterInit()
    dialog_function.register("Explode", function()
        net.Start("entity_exlode")
        net.WriteEntity(dialogEnt)
        net.SendToServer()
    end)

    dialog.log("Registers initialized.")
end

local function processText(text)
    return string.gsub(text, "$SELF", LocalPlayer():GetName())
end

function CreateDialogPanel()
    hook.Add("Think", "CheckLeftClick", ProcessClick)
    Panel = vgui.Create("DialogPanel")
    Panel:MakePopup()   
    Next()
end

function CreateChoicePanel(tbl)
    ChoicePanel = vgui.Create("ChoicePanel")
    ChoicePanel:MakePopup()
    ChoicePanel:Passover(tbl)
end

function ProcessClick()
    if locked then return end
    
    if input.IsButtonDown(MOUSE_LEFT) then
        if canClick then
            if inChoiceBranch then
                Next(_key)
            else
                Next()
            end
            canClick = false
        end
    else
        canClick = true
    end
end

function Next(c)
    dialog.log("Next was called, we shall continue with the dialog!")
    locked = true

    if c then
        dialog.log(c)
        cindex = cindex + 1
        inChoiceBranch = true
        dialog.log("Current (branch c): " .. tostring(c) .. " " .. cindex)
        _dialog = dialogFile[c][cindex]
    else
        index = index + 1
        dialog.log("Current index (incremented): " .. index)
        _dialog = dialogFile[index]
    end

    if _dialog then
        local Actor = _dialog["Actor"]
        local ActorName = _dialog["Name"]
        local ActorText = _dialog["Text"]
        local ActorChoice = _dialog["Choice"]
        local ActorVoice = _dialog["Voice"]
        local ActorTSpeed = _dialog["Speed"]
        local FunctionName = _dialog["FunctionName"]

        if FunctionName then
            dialog_function.execute(FunctionName)
        end

        if Actor and ActorName and ActorText then
            if Actor == "$SELF" then
                Panel:DSwitchActor(true, false)
            else
                Panel:DSwitchActor(false, Actor)
            end

            Panel:DSetActorName(processText(ActorName))

            if ActorVoice then
                Panel:DSetVoice(ActorVoice)
                dialog.log("Set actor voice to. " .. ActorVoice)
            else
                dialog.log("No actor voice.")
                Panel:DSetVoice(nil)
            end

            Panel:DSetText(processText(ActorText), ActorTSpeed or 0.01, function()
                if not ActorChoice then
                    locked = false 
                end
            end)

            if ActorChoice then
                locked = true
                dialog.log("Creating choice panel")
                CreateChoicePanel(ActorChoice)
            end
        else
            if IsValid(Panel) then
                Panel:DError("" .. dialogName .. ".json" .. " Is broken. The stacktrace is dumped into the console.")
                timer.Simple(5, function()
                    Panel:DRemove()
                end)
            end
            dialog.log("===== OH SHIT A DIALOG ERROR! =====")
            print("\n", "Actor:", Actor, "\n", "ActorName:", ActorName, "\n", "ActorText:", ActorText, "\n", "ActorChoice:", ActorChoice, "\n")
        end
    else
        dialog.log("I think we are done? Leave the panel.")
        hook.Remove("Think", "CheckLeftClick")
        Panel:DRemove()
    end
end

if IsValid(Panel) then
    Panel:Remove()
end