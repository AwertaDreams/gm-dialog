include("shared.lua")
include("ui/cl_init.lua")
include("ui/dialog/cl_dialog.lua")

express.Receive("dialogue_file_rw", function(data)
    dataTable = util.JSONToTable(data[1])


    for _, fileData in ipairs(dataTable) do
        file.Write("dialog/" .. fileData["filename"], fileData["content"])
    end
end)

