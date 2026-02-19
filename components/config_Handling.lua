local dotenv = require("components.lua-dotenv")
local messages = require("components.Messages")
local misc = require("components.miscellaneous")

local Module = {}

function Module.Get_Project_Defaults()
    local project_Config_Defaults = {}
    dotenv.load_dotenv("projects.env")

    -- Directory related
    project_Config_Defaults.Source_Directory = dotenv.get("SRC_DIR")
    project_Config_Defaults.Library_Directory = dotenv.get("LIB_DIR")
    project_Config_Defaults.Build_Directory = dotenv.get("BUILD_DIR")
    -- Compilation related
    project_Config_Defaults.Build_Script = dotenv.get("BUILD_SCRIPT")
    project_Config_Defaults.CC = dotenv.get("CC") -- Obs: CC is the C compiler.
    project_Config_Defaults.CCFLAGS = dotenv.get("CCFLAGS")
    project_Config_Defaults.CXX = dotenv.get("CXX") -- Obs: CXX is the C++ compiler.
    project_Config_Defaults.CXXFLAGS = dotenv.get("CXXFLAGS")
    project_Config_Defaults.Debugger = dotenv.get("DEBUGGER")

    return project_Config_Defaults
end

function Module.Get_Project_Options(project_Name)
    local projects_Table
    local current_Project_Config = {}

    if Is_Multiproject == true then
        if arg[1] ~= "all" then
            print("Todo")
        else
            local project_config_env_path = string.format("%s/%s", arg[1], "project.env")

            dotenv.load_dotenv(project_config_env_path)

            local language = dotenv.get("LANGUAGE", false)

            if language == false then
		
            end

        end
    else
        print("todo")
    end
end

function Module.Show_Defaults(project_Config_Defaults)
    print("Displaying all configuration options and values:\n")

    print("Defaults for project Directories:")
    print("Default project souce:                       ", project_Config_Defaults.Source_Directory)
    print("Defualt project library directory:           ", project_Config_Defaults.Library_Directory)
    print("Default project build directory:             ", project_Config_Defaults.Build_Directory)
    print("\n")
    print("Default for Compilation and Debugging")
    print("Default project C compiler:                  ", project_Config_Defaults.CC)
    print("Default project C++ compiler:                ", project_Config_Defaults.CXX)
    print("Default project C compiler flags:            ", project_Config_Defaults.CCFLAGS)
    print("Defualt project C++ compiler flags:          ", project_Config_Defaults.CXXFLAGS)
    print("Default project Debugger:                    ", project_Config_Defaults.Debugger)
end

function Module.get_Config_Option(config, default)
    local value = dotenv.get(config, default)
    local config_Option
    if value == "true" then
        config_Option = true
        return config_Option
    elseif value == "false" then
        config_Option = false
        return config_Option
    else
        return value
    end
end

return Module
