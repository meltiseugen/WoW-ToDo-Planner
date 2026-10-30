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

function Utils:EnsureChatLoggingSettings()
    local defaults = TDP.Constants.DEFAULT_DB.settings
    local settings = type(TODOPlannerDB) == "table" and TODOPlannerDB.settings
    if type(settings) ~= "table" then return end
    local keys = { "enableChatLogging", "chatLogTimestamps" }
    for _, category in ipairs(TDP.Constants.CHAT_LOG_CATEGORIES) do keys[#keys + 1] = category.key end
    for _, key in ipairs(keys) do
        if type(settings[key]) ~= "boolean" then settings[key] = defaults[key] end
    end
end

function Utils:GetChatLoggingSettings()
    local settings = type(TODOPlannerDB) == "table" and TODOPlannerDB.settings
    return type(settings) == "table" and settings or TDP.Constants.DEFAULT_DB.settings
end

function Utils:IsChatLoggingEnabled(categoryID)
    local defaults = TDP.Constants.DEFAULT_DB.settings
    local settings = self:GetChatLoggingSettings()
    local function enabled(key)
        if type(settings[key]) == "boolean" then return settings[key] end
        return defaults[key] == true
    end
    if not enabled("enableChatLogging") then return false end
    if categoryID == "test" then return true end
    local category = TDP.Constants.CHAT_LOG_CATEGORY_BY_ID[categoryID] or TDP.Constants.CHAT_LOG_CATEGORY_BY_ID.commands
    return enabled(category.key)
end

function Utils:Msg(text, categoryID)
    if not self:IsChatLoggingEnabled(categoryID) then return false end
    local settings = self:GetChatLoggingSettings()
    local category = TDP.Constants.CHAT_LOG_CATEGORY_BY_ID[categoryID] or TDP.Constants.CHAT_LOG_CATEGORY_BY_ID.commands
    local timestamp = settings.chatLogTimestamps == true and (date("%H:%M:%S") .. " ") or ""
    local message = timestamp .. "|cff00d1b2TODO Planner|r |cff9aa5b5["
        .. (categoryID == "test" and "Test" or category.label) .. "]|r " .. tostring(text)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage(message)
    else
        print(message)
    end
    return true
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
