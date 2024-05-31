include("shared.lua")
include("ui/cl_init.lua")
include("ui/dialog/cl_dialog.lua")

express.Receive("dialogue_file_rw", function(data)
    file.Write("dialog/" .. data[2], data[1])
end)

dialog.dispatch("test", LocalPlayer())
