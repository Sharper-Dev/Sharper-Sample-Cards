--[[
Made by SharperDev
This script just has remove field cards effect.
You can set:
The minimum and maximum cards to remove
The remove position
The cards to be targeted (player, opponent or both)
]]

-- Ban Cards Spell
local cardConfig = {
    MIN_CARDS = 1,
    MAX_CARDS = 2,
    REMOVE_TARGETS = 0, -- -1 = Opponent | 0 = Both | 1 = Player
    REMOVE_POSITION = POS_FACEUP
}
local s,id=GetID()
function s.initial_effect(c)

    local e1 = Effect.CreateEffect(c)

    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    e1:SetOperation(s.activate)

    c:RegisterEffect(e1)

end

function s.filter(c)
	return c:IsAbleToRemove()
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and s.filter and chkc~=e:GetHandler() end
    local targets = {
        player = (cardConfig.REMOVE_TARGETS >= 0) and LOCATION_ONFIELD or 0, 
        opponent = (cardConfig.REMOVE_TARGETS <= 0) and LOCATION_ONFIELD or 0
    }
    if chk==0 then return Duel.IsExistingTarget(s.filter,tp,targets.player,targets.opponent,cardConfig.MIN_CARDS,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,s.filter,tp,targets.player,targets.opponent,cardConfig.MIN_CARDS,cardConfig.MAX_CARDS,e:GetHandler())

    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end

function s.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetTargetCards(e)
    Duel.Remove(tc,cardConfig.REMOVE_POSITION,REASON_EFFECT)
end