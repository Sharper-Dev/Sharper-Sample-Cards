--[[
Made by SharperDev
This script just has a draw effect like Pot Of Greed
but you can customize the Draw Amount and who will draw
]]
--[[
Draw Target Values:
1 = Player
0 = Both
-1 = Opponent
]]
local cardConfig = {
    DRAW_AMOUNT = 2, -- Sets the Draw amount
    DRAW_TARGET = -1 -- Sets who will draw
}
local s, id = GetID()

function s.initial_effect(c)

    local e1 = Effect.CreateEffect(c)

    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    e1:SetOperation(s.activate)

    c:RegisterEffect(e1)

end

local finalTarget

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
    
    if chk == 0 then 
        local result
        if cardConfig.DRAW_TARGET == 0 then
            result = Duel.IsPlayerCanDraw(tp, cardConfig.DRAW_AMOUNT) and Duel.IsPlayerCanDraw(1-tp, cardConfig.DRAW_AMOUNT)
            finalTarget = PLAYER_ALL
        elseif cardConfig.DRAW_TARGET == -1 then
            result = Duel.IsPlayerCanDraw(1-tp, cardConfig.DRAW_AMOUNT)
            finalTarget = 1-tp
        elseif cardConfig.DRAW_TARGET == 1 then
            result = Duel.IsPlayerCanDraw(tp, cardConfig.DRAW_AMOUNT)
            finalTarget = tp
        end
        return result
    end

    Duel.SetTargetPlayer(finalTarget)
    Duel.SetTargetParam(cardConfig.DRAW_AMOUNT)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, finalTarget, cardConfig.DRAW_AMOUNT)

end

function s.activate(e,tp,eg,ep,ev,re,r,rp)

    if cardConfig.DRAW_TARGET ~= 0 then
        local p = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER)
        Duel.Draw(p, cardConfig.DRAW_AMOUNT, REASON_EFFECT)
    else
        Duel.Draw(tp, cardConfig.DRAW_AMOUNT, REASON_EFFECT)
        Duel.Draw(1-tp, cardConfig.DRAW_AMOUNT, REASON_EFFECT)
    end
    
end