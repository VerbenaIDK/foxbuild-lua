local Module = {}

function Module.File_Exists(path)
    local file = io.open(path, "r")
    if file ~= nil then
        return true
    else
        return false
    end
end

return Module
