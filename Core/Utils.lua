local _, TDP = ...

local Utils = {}
Utils.__index = Utils

function Utils:New()
    return setmetatable({}, self)
end

function Utils:CopyDefaults(target, defaults)
    if type(defaults) ~= "table" then
        return target
    end

    if type(target) ~= "table" then
        target = {}
    end

    for key, value in pairs(defaults) do
        if type(value) == "table" then
            target[key] = self:CopyDefaults(target[key], value)
        elseif target[key] == nil then
            target[key] = value
        end
    end

    return target
end

function Utils:Trim(input)
    if type(input) ~= "string" then
        return ""
    end
    return (input:gsub("^%s+", ""):gsub("%s+$", ""))
end

function Utils:Msg(text)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00d1b2TODO Planner|r: " .. text)
    else
        print("TODO Planner: " .. text)
    end
end

function Utils:IndexOf(list, value)
    for i, item in ipairs(list) do
        if item == value then
            return i
        end
    end
    return nil
end

function Utils:GetDateStamp(timestamp)
    if not timestamp then
        return ""
    end
    return date("%Y-%m-%d", timestamp)
end

function Utils:GetDateTimeStamp(timestamp)
    if not timestamp then
        return "Unknown"
    end
    return date("%Y-%m-%d %H:%M", timestamp)
end

function Utils:CallMaybeMethod(owner, method, ...)
    if type(method) ~= "function" then
        return false, nil
    end

    local ok, result = pcall(method, ...)
    if ok then
        return true, result
    end

    if owner then
        ok, result = pcall(method, owner, ...)
        if ok then
            return true, result
        end
    end

    return false, nil
end

TDP.Utils = Utils:New()
