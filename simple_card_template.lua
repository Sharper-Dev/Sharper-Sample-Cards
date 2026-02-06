-- This template includes the basic structure of a card script
local s,id=GetID()
function s.initial_effect(c)

    local e1 = Effect.CreateEffect(c)

    e1:SetDescription(aux.Stringid(id, 0))
    e1:SetCategory()
    e1:SetType()
    e1:SetProperty()
    e1:SetCode()
    e1:SetTarget(s.target)
    e1:SetOperation(s.activate)

    c:RegisterEffect(e1)

end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)

end

function s.activate(e,tp,eg,ep,ev,re,r,rp)
   
end