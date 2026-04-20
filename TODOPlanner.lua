local ADDON_NAME, TDP = ...

TDP.name = ADDON_NAME
TDP.EventFrame = TDP.EventFrame or CreateFrame("Frame")
TDP.modules = TDP.modules or {}

_G.TODOPlanner = TDP
