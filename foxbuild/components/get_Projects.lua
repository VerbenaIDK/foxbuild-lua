local dotenv = require("components.lua-dotenv")
local messages = require("components.Messages")

local Module = {}

function Module.get_Projects()
    local projects_raw = {}
    local file = assert((io.open("projects.env", "r")))

    messages.debug_Status_Output_Var("Is_Multiproject", Is_Multiproject)

    if Is_Multiproject == true then
        local run = true
        while run == true do
            local line = file:read("*line")
            --print("file line is: ", line)
            if line ~= nil then
                if string.sub(line, 1, 1) == "#" then
                    line = file:read("*line")
                    --print("IS COMMENT")
                    --print("file line is: ", line)
                end

                if string.match(line, "^PROJECT") == "PROJECT" then
                    table.insert(projects_raw, line)
                end
            else
                file:close()
                run = false
            end
        end

        local project_names = {}

        local project_count = 1
        while projects_raw[project_count] ~= nil do
            messages.debug_Status_Output_Var("current project_raw index", projects_raw[project_count])
            messages.debug_Status_Output_Var("project_count", project_count)

            local separator_Index = nil

            if projects_raw[project_count] ~= nil then
                separator_Index = string.find(projects_raw[project_count], "=")

            end
            if separator_Index ~= nil then
                local name = string.sub(projects_raw[project_count], separator_Index+1)
                table.insert(project_names, name)
            end

            project_count = project_count + 1
        end

        project_count = project_count - 1
        if project_count == 0 or project_count == nil then
            project_count = 1
        end
        messages.debug_Status_Output_Var("TABLE: projects_raw", table.concat(projects_raw, ", "))
        return project_names
    else
        dotenv.load_dotenv("project.env")
        local project_name dotenv.get("NAME")
        messages.debug_Status("Non-multiproject handling at get_Projects.lua.")
        messages.debug_Status_Output_Var("project_name", project_name)
        return project_name
    end
end

return Module
