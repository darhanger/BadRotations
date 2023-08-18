---
-- Anima is the table located at br.player.anima
-- These functions are accessible via `local anima = br.player.anima`
-- `spell` in the usage examples represent the name in the animas list (Spec, Shared Class, Shared Global Lists) defined in System/List/Spells.lua
-- @module br.player.anima
local _, br = ...
if br.api == nil then br.api = {} end

local MAW_BUFF_MAX_DISPLAY = 44;
local mawBuff = {};

local function getAnimaInfo(animaID)
    table.wipe(mawBuff)
    mawBuff.exists = false
    mawBuff.count = 0
    if br._G.IsInJailersTower() then
        for i=1, MAW_BUFF_MAX_DISPLAY do
            local _, icon, count, _, _, _, _, _, _, spellID = br._G.UnitAura("player", i, "MAW");
            if icon then
                if count == 0 then
                    count = 1;
                end
                if spellID == animaID then
                    mawBuff.exists = true
                    mawBuff.count = count
                end
            end
        end
    end
    return mawBuff
end

br.api.animas = function(anima,v)
    --- Check if a specific anima power exists.
    -- @function br.player.anima.spell.exists
    -- @treturn bool True if the anima power exists, false otherwise.
    anima.exists = function()
        local thisAnima = getAnimaInfo(v)
        return thisAnima.exists
    end

    --- Get the rank of a specific anima power.
    -- @function br.player.anima.spell.rank
    -- @treturn number The rank of the anima power.
    anima.rank = function()
        local thisAnima = getAnimaInfo(v)
        return thisAnima.count
    end
end
