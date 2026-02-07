#!/bin/lua

--  Tests default to non-release builds outside the debugger.
--  Project must still be specified
--
--  "debug" mode will run the software inside the debugger.

--  Includes
local dotenv = require("components.lua-dotenv")
local getprojects = require("components.get_Projects")
local options = require("components.input_Handling")
local messages = require("components.Messages")
local config = require("components.config_Handling")
local option_Handling = require("components.handle_Options")
local misc = require("components.miscellaneous")

if misc.File_Exists("projects.env") then
    dotenv.load_dotenv("projects.env")
    Is_Multiproject = config.get_Config_Option("MULTIPROJECT", false)
    if Is_Multiproject == false then
        messages.Warn("projects.env found, but is not multiproject, configuration error?")
    end
    messages.debug_Status("Multiproject!")
elseif misc.File_Exists("project.env") then
    dotenv.load_dotenv("project.env")
    Is_Multiproject = false
end

if arg[1] == "--debug" then
    Debug = true
    messages.debug_Status("Debug mode is enabled.")
else
    Debug = false
end
Project_Config_Defaults = config.Get_Project_Defaults()
Project_Names = getprojects.get_Projects()
Project_Count = #Project_Names

local option_Code = options.check_Options(arg, Project_Names, Project_Count)
messages.debug_Status_Output_Var("option_Code", option_Code)

option_Handling.Handle_Options(option_Code)

