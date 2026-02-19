local messages = require("components.Messages")

local Module = {}

local function switch(case, option)
  local action = option[case] or option["default"]
  if action then
    return action()
  end
end


function Module.check_Options(arguments, projects_name, projects_count)
  local firstArgument
  local secondArgument

  messages.debug_Status("About to check input...")

  if Debug then
    firstArgument = arguments[2]
    secondArgument = arguments[3]
  else
    firstArgument = arguments[1]
    secondArgument = arguments[2]
  end

  if firstArgument == "help" or firstArgument == "-h" or firstArgument == "--help" then
    messages.Print_Help_And_Exit()
  end


  if firstArgument == "list-config" then 
    return 200
  end

  local function multiprojectHandling()
    messages.debug_Status("Multiproject input handling...")

    local modeSwitching = {
      ["build"] = function()        return 1 end,
      ["test"] = function()         return 2 end,
      ["debug"] = function()        return 3 end,
      ["release"] = function()      return 4 end,
      ["list-config"] = function()  return 201 end,
      ["default"] = function()
          print("Command not found! Typed wrong command? Use -h, --help or help for a list of commands.")
          os.exit(2)
      end
    }

    if firstArgument == "all" then
      return switch(secondArgument or "normal", {
        ["build"] = function()      return 11 end,
        ["test"] = function()       return 12 end,
        ["debug"] = function()
            messages.Warn("Can't debug many projects at once!!")
            return 0
        end,
        ["release"] = function()    return 14 end,
        ["default"] = modeSwitching["default"]
      })
    end

      for _ = 1, projects_count do
        if firstArgument == projects_name[_] then
          return switch(secondArgument or "normal", modeSwitching)
        end
      end

      print("Project not found!")
      os.exit(2)
    end


  local function singleprojectHandling()
    messages.debug_Status("Handling non-multiproject input...")
    return switch(firstArgument, {
      ["build"] = function()    return 1 end,
      ["test"] = function()     return 2 end,
      ["debug"] = function()    return 3 end,
      ["default"] = function()
          messages.debug_Status("Not sure what to do here...")
          return 1
      end
    })
  end





  if Is_Multiproject then
    return multiprojectHandling()
  else
    return singleprojectHandling()
  end
end

return Module


  
