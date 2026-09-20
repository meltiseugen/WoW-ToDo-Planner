local _, TDP = ...

TDP.Constants = {
    ALL_BOARD_KEY = "ALL",
    ARCHIVED_BOARD_KEY = "ARCHIVED",
    GLOBAL_BOARD_KEY = "GLOBAL",

    STATUS_ORDER = { "TODO", "DOING", "DONE" },
    STATUS_LABELS = {
        TODO = "To Do",
        DOING = "In Progress",
        DONE = "Done",
    },

    TASK_CATEGORIES = {
        "General",
        "Achievements",
        "Mounts",
        "Collections",
        "Reputation",
        "Other",
    },

    FILTER_CATEGORIES = {
        "All",
        "General",
        "Achievements",
        "Mounts",
        "Collections",
        "Reputation",
        "Other",
    },

    DEFAULT_DB = {
        version = 3,
        nextTaskId = 1,
        tasks = {},
        characters = {},
        favorites = {},
        settings = {
            filterCategory = "All",
            selectedBoard = false,
            useProgressBars = true,
            worldMapPinScale = 1.6,
            collectionHideCollected = true,
            collectionMountSourceFilters = {},
            frame = {
                point = "CENTER",
                x = 0,
                y = 0,
            },
            framePositions = {},
        },
    },

    FALLBACK_BACKDROP = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 },
    },

    STATUS_ACCENT_COLORS = {
        TODO = "accentGold",
        DOING = "accentGold",
        DONE = "accentGold",
    },
}
