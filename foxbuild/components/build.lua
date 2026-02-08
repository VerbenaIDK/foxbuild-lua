local messages = require("component.Messages")

local Module = {}

local function simple_C_Compilation(path)
    local fileFinderCommand
    local finalCommand

    fileFinderCommand = string.format("$(find %s %s)")
end

function Module.Build(type, project)

    messages.debug_Status("About to build project(s).")
    if project ~= "all" then
   
        --todo

    elseif type == 1 then
        -- Todo
    
    end

end

return Module
