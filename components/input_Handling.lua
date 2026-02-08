local messages = require("components.Messages")

local Module = {}

local function switch(case, option)
    local action = option[case] or option["default"]
    if action then
        return action()
    end
end


-- usage would be something like this:
-- say the thing we are looking for is a function with the number label 2
-- we'd just put number 2 in the case part of the function, if It finds it, It can do another thing (like execute another function) like so
--
-- switch(2, {
-- [1] = function() print("Case 1 executed!!!!!!") end,
-- [2] = function() print("case 2 was executed!!!") end,
-- ["default"] = function() os.exit(0)end,
-- })
--
--This should be fairly expandable and very useful
--
--


function Module.check_Options(arguments, projects_name, projects_count)
    local first_arg
    local second_arg

    messages.debug_Status("About to check input...")

    if Debug == true then
        first_arg = arguments[2]
        second_arg = arguments[3]
    else
        first_arg = arguments[1]
        second_arg = arguments[2]
    end

    if first_arg ~= nil and first_arg == "help" or first_arg == "-h" or first_arg == "--help" then
        messages.Print_Help_And_Exit()
    elseif first_arg == "list-config" then
        return 200
    else
        local run = true
        local count = 1
        while run == true do
            if count > projects_count then
                run = false
                print("Project not found!")
                os.exit(1)
                --return 0
            end
            if Is_Multiproject == true then
                messages.debug_Status("Multiproject input handling.")
                if first_arg == projects_name[count] then
                    run = false
                    if second_arg == "normal" or second_arg == nil then
                        return 1
                    elseif second_arg == "test" then
                        return 2
                    elseif second_arg == "debug" then
                        return 3
                    elseif second_arg == "release" then
                        return 4
                    elseif second_arg == "list-config" then
                        return 201
                    else
                        print("Command not found! Typed wrong command?")
                        print("Use -h, --help or help for a list of commands.")
                        os.exit(2)
                    end
                elseif first_arg == "all" then
                    run = false
                    if second_arg == "normal" or second_arg == nil then
                        return 11
                    elseif second_arg == "test" then
                        return 12
                    elseif second_arg == "debug" then
                        messages.Warn("Can't debug many projects at once!")
                        return 1
                    elseif second_arg == "release" then
                        return 14
                    end
                end
            else
                messages.debug_Status("Handling non-multiproject input")
                if first_arg == "build" then
                    return 1
                elseif first_arg == "normal" then
                    return 1
                elseif first_arg == "test" then
                    return 2
                elseif first_arg == "debug" then
                    return 3
                end
            end
            count = count + 1
        end
    end
end

return Module
