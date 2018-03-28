DEFAULT_CHAT_FRAME:AddMessage('Hello');

function ReactiveAlertAddOn_OnLoad()
	 chatmsg("ReactiveAlert is Loaded");
		f_cd = CreateFrame("frame")
		
	 	f = CreateFrame("Frame",nil,UIParent)		
		f:SetFrameStrata("BACKGROUND")
		f:SetWidth(48) -- Set these to whatever height/width is needed 
		f:SetHeight(48) -- for your Texture

		t = f:CreateTexture(nil,"BACKGROUND")
		t:SetTexture("Interface\\Icons\\Ability_MeleeDamage.blp")
		t:SetAllPoints(f)
		f.texture = t		
		
		f:SetPoint("CENTER",0,-150)
		f:Hide()
		f:SetParent(nil)			
		
		onCoolDown = false;
		
		
		playerClass, englishClass = UnitClass("player")		
		
		
		--local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(11585)
		--chatmsg(icon);
		
	 this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED"); 
	 
	 		
end

	
		
		
function ReactiveAlertAddOn_OnEvent(self, event, ...)
	local eventType = select(2, ...)	
	local sourceName = select(4, ...)	
	local MissType = select(12, ...)
	local swingAmount = select(9, ...)
	local spellName = select(10, ...)
	
	
  -- Note, for this example, you could just use 'local type = select(2, ...)'.  The others are included so that it's clear what's available.
	local PlayerName = UnitName("Player");
	if(PlayerName == sourceName and englishClass == "WARRIOR") then
		--chatmsg(eventType .. " " .. spellName .. "id:" .. swingAmount ) 
		if(eventType == "SWING_MISSED" and swingAmount == "DODGE" or eventType == "SPELL_MISSED" and MissType == "DODGE") then
		chatmsg("--- USE OVERPOWER ---");	
		start, duration, enabled = GetSpellCooldown("Overpower")
		chatmsg( start .. " " .. duration )
		if(not onCoolDown) then
		f:Show()		 
		--PlaySound("ReadyCheck", "master");
		end
		total = 4;
		f:SetScript("OnUpdate", Frame_OnUpdate)
		end	
		
		if(eventType == "SPELL_CAST_SUCCESS" and spellName == "Overpower") then
			onCoolDown = true;
			onCoolDown_elapsed = 1;
			f:Hide()
			f:SetParent(nil)
			f_cd:SetScript("OnUpdate",f_cd_OnUpdate)
		end
	end	
	
end

function f_cd_OnUpdate(self, elapsed)
     onCoolDown_elapsed = onCoolDown_elapsed - elapsed
	 
	 if(onCoolDown_elapsed <= 0) then
	 chatmsg("cd araligi");
	 onCoolDown = false;
	 f_cd:SetScript("OnUpdate", nil)
	 
	 end
end

function Frame_OnUpdate(self, elapsed)
	 --chatmsg("Frame_OnUpdate Calisiyor " .. total);
	
	 
	 total = total - elapsed
	 
	 if(total <= 0 ) then
	 chatmsg("bitti");	 
	 f:Hide()
	 f:SetParent(nil)
	 f:SetScript("OnUpdate", nil)
	 end
	 

end

function chatmsg (msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage (msg);
	end
end