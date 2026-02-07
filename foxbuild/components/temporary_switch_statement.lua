function switch(case, option)
  local action = option[case] or option["default"]
  if action then 
    return action()
  end
end



