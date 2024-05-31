module("dialog_function", package.seeall)

DialogFunctions = {}

function register(name, func)
    DialogFunctions[name] = func
    dialog.log("Successfully registered a function: " .. name)
end

function execute(name)
    if DialogFunctions[name] then
        DialogFunctions[name]()
    else
        dialog.log("No function registered: " .. name)
    end
end

