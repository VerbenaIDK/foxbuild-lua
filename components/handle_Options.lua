local messages = require("components.Messages")
local config = require("components.config_Handling")

local Module = {}

function Module.Handle_Options(option_Code)
    messages.debug_Status("About to check options...")
    if option_Code == nil then
        messages.Error("Failure in checking options, nil value recieved, something went horribly wrong...", 20)
    elseif option_Code == 200 then
        print(config.Show_Defaults(Project_Config_Defaults))
        messages.debug_Status("Shown default configurations for projects, exiting.")
        os.exit(0)
    elseif option_Code == 201 then
        print("TODO")
    end
end

return Module
