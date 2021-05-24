--[[
    Use this module to handle adding Categories with Wikitext
]]

---@class CategoryHandlerCreator
--Module for creating CategoryHandlers.
local Module = {}

---@class CategoryHandler
--Handler for handling and getting categories.
local CategoryHandler = setmetatable({
    Categories = {}
}, {
    -- when tostring() is called, handle it
    __tostring = function(self)
        local Categories = ""
        -- "concat" the table into "[[Category:1]][[Category:2]]..."
        for _,Category in ipairs(self.Categories) do
            Categories = Categories .. string.format("[[Category:%s]]", Category)
        end
        return Categories
    end
})

--Add a new category to the handler.
---@param category string - The category to add
---@return CategoryHandler
function CategoryHandler:Add(category)
    -- add category to CategoryHandler categories
    table.insert(self.Categories, category)
    return self
end

--Create a a new Category Handler.
---@return CategoryHandler
function Module.New()
    -- send back a clone of CategoryHandler
    return mw.clone(CategoryHandler)
end

return Module