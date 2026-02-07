local Module = {}

function Module.Print_Help_And_Exit()
    print("  Verbena libraries testing software")
    print("Necessary inputs: Project name, action/mode")
    print("Debugger is chosen in a project level, empty argument will default to normal mode (no debugger)")
    print("Possible actions beside build actions:")
    print("list-config: List configuration for specified project, if ran with no project name, will give defaults for all projects from projects.env file.")
    print("")
    print("Software by Verbena")
    os.exit(0)
end

function Module.Print_Wrong_Mode()
    print("Wrong mode!")
    print("Run with -h, --help or help for help!")
end

function Module.Print_Project_Not_Found()
    print("Project not found!")
end

local function format_Output(type, descriptor, code)
    local time = os.date("[%b %d %X] ")
    local formatted
    if type == 0 then
        formatted = string.format("%s \x1b[1;32m%s:\x1b[0m %s", time, "STATUS", descriptor)
        return formatted
    elseif type == 1 then
        formatted = string.format("%s \x1b[1;33m%s:\x1b[0m %s", time, "WARNING", descriptor)
        return formatted
    elseif type == 2 then
        formatted = string.format("%s \x1b[1;31m%s:\x1b[0m %s code: %d", time, "ERROR", descriptor, code)
        return formatted
    else
        print("Something went horribly wrong...")
        os.exit(255)
    end
end

function Module.Error(descriptor, code)
    local error = format_Output(2, descriptor, code)
    print(error)
    os.exit(code)
end

function Module.Warn(descriptor)
    local warning = format_Output(1, descriptor)
    print(warning)
end

function Module.Status(descriptor)
    local status = format_Output(0, descriptor)
    print(status)
end

function Module.Simple_Status(descriptor)
    local time = os.date("[%b %d %X]")
    local status = string.format("%s: %s", time, descriptor)
    print(status)
end

function Module.debug_Warn(descriptor)
    if Debug == true then
        Module.Warn(descriptor)
    end
end
function Module.debug_Status(descriptor)
    if Debug == true then
        Module.Status(descriptor)
    end
end
function Module.debug_Simple_Status(descriptor)
    if Debug == true then
        Module.Simple_Status(descriptor)
    end
end
function Module.debug_Status_Output_Var(varname, var)
    if Debug == true then
        local time = os.date("[%b %d %X] ")
        local formatted = string.format("%s \x1b[1;32m%s:\x1b[0m Value of variable %s:", time, "VALUE", varname)
        print(formatted, var)
    end
end

return Module
