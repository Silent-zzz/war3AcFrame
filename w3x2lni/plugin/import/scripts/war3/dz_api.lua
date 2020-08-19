local japi = require 'jass.japi'
local dz = require 'jass.dzapi'
local cj = require 'jass.common'
local dz_api = {}
function dz_api.DzTriggerRegisterMouseEventTrg(trg, status, btn)
	if trg == nil then
		return
	end
	japi.DzTriggerRegisterMouseEvent(trg, btn, status, true, nil)
end
function dz_api.DzTriggerRegisterKeyEventTrg(trg, status, btn)
	if trg == nil then
		return
	end
	japi.DzTriggerRegisterKeyEvent(trg, btn, status, true, nil)
end
function dz_api.DzTriggerRegisterMouseMoveEventTrg(trg)
	if trg == nil then
		return
	end
	japi.DzTriggerRegisterMouseMoveEvent(trg, true, nil)
end
function dz_api.DzTriggerRegisterMouseWheelEventTrg(trg)
	if trg == nil then
		return
	end
	japi.DzTriggerRegisterMouseWheelEvent(trg, true, nil)
end
function dz_api.DzTriggerRegisterWindowResizeEventTrg(trg)
	if trg == nil then
		return
	end
	japi.DzTriggerRegisterWindowResizeEvent(trg, true, nil)
end
function dz_api.DzF2I(i)
	return i
end
function dz_api.DzI2F(i)
	return i
end
function dz_api.DzK2I(i)
	return i
end
function dz_api.DzI2K(i)
	return i
end

function dz_api.DzAPI_Map_IsPlatformVIP(whichPlayer)
	return japi.DzAPI_Map_GetPlatformVIP(whichPlayer) > 0
end
function dz_api.DzAPI_Map_Global_GetStoreString(key)
	return japi.RequestExtraStringData(36, cj.GetLocalPlayer(), key, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_Global_StoreString(key, value)
	japi.RequestExtraStringData(37, cj.GetLocalPlayer(), key, value, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_Global_ChangeMsg(trig)
	japi.DzTriggerRegisterSyncData(trig, "DZGAU", true)
end
function dz_api.DzAPI_Map_ServerArchive(whichPlayer, key)
	return japi.RequestExtraStringData(38, whichPlayer, key, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_SaveServerArchive(whichPlayer, key, value)
	japi.RequestExtraBooleanData(39, whichPlayer, key, value, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_IsRPGQuickMatch()
	return japi.RequestExtraBooleanData(40, nil, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_GetMallItemCount(whichPlayer, key)
	return japi.RequestExtraIntegerData(41, whichPlayer, key, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_ConsumeMallItem(whichPlayer, key, count)
	return japi.RequestExtraBooleanData(42, whichPlayer, key, nil, false, count, 0, 0)
end
function dz_api.DzAPI_Map_EnablePlatformSettings(whichPlayer, option, enable)
	return japi.RequestExtraBooleanData(43, whichPlayer, nil, nil, enable, option, 0, 0)
end
function dz_api.DzAPI_Map_IsBuyReforged(whichPlayer)
	return japi.RequestExtraBooleanData(44, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.GetPlayerServerValueSuccess(whichPlayer)
	if japi.DzAPI_Map_GetServerValueErrorCode(whichPlayer) == 0 then
		return true
	else
		return false
	end
end
function dz_api.DzAPI_Map_StoreIntegerEX(whichPlayer, key, value)
	key = "I" .. (key or "")
	japi.RequestExtraBooleanData(39, whichPlayer, key, cj.I2S(value), false, 0, 0, 0)
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredIntegerEX(whichPlayer, key)
	local value
	key = "I" .. (key or "")
	value = cj.S2I(japi.RequestExtraStringData(38, whichPlayer, key, nil, false, 0, 0, 0))
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_StoreInteger(whichPlayer, key, value)
	key = "I" .. (key or "")
	japi.DzAPI_Map_SaveServerValue(whichPlayer, key, cj.I2S(value))
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredInteger(whichPlayer, key)
	local value
	key = "I" .. (key or "")
	value = cj.S2I(japi.DzAPI_Map_GetServerValue(whichPlayer, key))
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_CommentTotalCount1(whichPlayer, id)
	return japi.RequestExtraIntegerData(52, whichPlayer, nil, nil, false, id, 0, 0)
end
function dz_api.DzAPI_Map_StoreReal(whichPlayer, key, value)
	key = "R" .. (key or "")
	japi.DzAPI_Map_SaveServerValue(whichPlayer, key, cj.R2S(value))
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredReal(whichPlayer, key)
	local value
	key = "R" .. (key or "")
	value = cj.S2R(japi.DzAPI_Map_GetServerValue(whichPlayer, key))
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_StoreBoolean(whichPlayer, key, value)
	key = "B" .. (key or "")
	if value then
		japi.DzAPI_Map_SaveServerValue(whichPlayer, key, "1")
	else
		japi.DzAPI_Map_SaveServerValue(whichPlayer, key, "0")
	end
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredBoolean(whichPlayer, key)
	local value
	key = "B" .. (key or "")
	key = japi.DzAPI_Map_GetServerValue(whichPlayer, key)
	if key == "1" then
		value = true
	else
		value = false
	end
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_StoreString(whichPlayer, key, value)
	key = "S" .. (key or "")
	japi.DzAPI_Map_SaveServerValue(whichPlayer, key, value)
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredString(whichPlayer, key)
	return japi.DzAPI_Map_GetServerValue(whichPlayer, "S" .. (key or ""))
end
function dz_api.DzAPI_Map_StoreStringEX(whichPlayer, key, value)
	key = "S" .. (key or "")
	japi.RequestExtraBooleanData(39, whichPlayer, key, value, false, 0, 0, 0)
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_GetStoredStringEX(whichPlayer, key)
	return japi.RequestExtraStringData(38, whichPlayer, "S" .. (key or ""), nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_GetStoredUnitType(whichPlayer, key)
	local value
	key = "I" .. (key or "")
	value = cj.S2I(japi.DzAPI_Map_GetServerValue(whichPlayer, key))
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_GetStoredAbilityId(whichPlayer, key)
	local value
	key = "I" .. (key or "")
	value = cj.S2I(japi.DzAPI_Map_GetServerValue(whichPlayer, key))
	key = nil
	whichPlayer = nil
	return value
end
function dz_api.DzAPI_Map_FlushStoredMission(whichPlayer, key)
	japi.DzAPI_Map_SaveServerValue(whichPlayer, key, nil)
	key = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_Ladder_SubmitIntegerData(whichPlayer, key, value)
	japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, cj.I2S(value))
end
function dz_api.DzAPI_Map_Stat_SubmitUnitIdData(whichPlayer, key, value)
	if value == 0 then
	--call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
	else
		japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, cj.I2S(value))
	end
end
function dz_api.DzAPI_Map_Stat_SubmitUnitData(whichPlayer, key, value)
	japi.DzAPI_Map_Stat_SubmitUnitIdData(whichPlayer, key, cj.GetUnitTypeId(value))
end
function dz_api.DzAPI_Map_Ladder_SubmitAblityIdData(whichPlayer, key, value)
	if value == 0 then
	--call DzAPI_Map_Ladder_SetStat(whichPlayer,key,"0")
	else
		japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, cj.I2S(value))
	end
end
function dz_api.DzAPI_Map_Ladder_SubmitItemIdData(whichPlayer, key, value)
	local S
	if value == 0 then
		S = "0"
	else
		S = cj.I2S(value)
		japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, S)
	end
	--call DzAPI_Map_Ladder_SetStat(whichPlayer,key,S)
	S = nil
	whichPlayer = nil
end
function dz_api.DzAPI_Map_Ladder_SubmitItemData(whichPlayer, key, value)
	japi.DzAPI_Map_Ladder_SubmitItemIdData(whichPlayer, key, cj.GetItemTypeId(value))
end
function dz_api.DzAPI_Map_Ladder_SubmitBooleanData(whichPlayer, key, value)
	if value then
		japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, "1")
	else
		japi.DzAPI_Map_Ladder_SetStat(whichPlayer, key, "0")
	end
end
function dz_api.DzAPI_Map_Ladder_SubmitTitle(whichPlayer, value)
	japi.DzAPI_Map_Ladder_SetStat(whichPlayer, value, "1")
end
function dz_api.DzAPI_Map_Ladder_SubmitPlayerRank(whichPlayer, value)
	japi.DzAPI_Map_Ladder_SetPlayerStat(whichPlayer, "RankIndex", cj.I2S(value))
end
function dz_api.DzAPI_Map_Ladder_SubmitPlayerExtraExp(whichPlayer, value)
	japi.DzAPI_Map_Ladder_SetStat(whichPlayer, "ExtraExp", cj.I2S(value))
end
function dz_api.DzAPI_Map_PlayedGames(whichPlayer)
	return japi.RequestExtraIntegerData(45, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_CommentCount(whichPlayer)
	return japi.RequestExtraIntegerData(46, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_FriendCount(whichPlayer)
	return japi.RequestExtraIntegerData(47, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_IsConnoisseur(whichPlayer)
	return japi.RequestExtraBooleanData(48, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_IsBattleNetAccount(whichPlayer)
	return japi.RequestExtraBooleanData(49, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_IsAuthor(whichPlayer)
	return japi.RequestExtraBooleanData(50, whichPlayer, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_CommentTotalCount()
	return japi.RequestExtraIntegerData(51, nil, nil, nil, false, 0, 0, 0)
end
function dz_api.DzAPI_Map_Statistics(whichPlayer, eventKey, eventType, value)
	japi.RequestExtraBooleanData(34, whichPlayer, eventKey, "", false, value, 0, 0)
end
function dz_api.DzAPI_Map_Returns(whichPlayer, label)
	return japi.RequestExtraBooleanData(53, whichPlayer, nil, nil, false, label, 0, 0)
end
function dz_api.DzAPI_Map_ContinuousCount(whichPlayer, id)
	return japi.RequestExtraIntegerData(54, whichPlayer, nil, nil, false, id, 0, 0)
end
-- IsPlayer,                      //是否为玩家
function dz_api.DzAPI_Map_IsPlayer(whichPlayer)
	return japi.RequestExtraBooleanData(55, whichPlayer, nil, nil, false, 0, 0, 0)
end
-- MapsTotalPlayed,               //所有地图的总游戏时长
function dz_api.DzAPI_Map_MapsTotalPlayed(whichPlayer)
	return japi.RequestExtraIntegerData(56, whichPlayer, nil, nil, false, 0, 0, 0)
end
-- MapsLevel,                    //指定地图的地图等级
function dz_api.DzAPI_Map_MapsLevel(whichPlayer, mapId)
	return japi.RequestExtraIntegerData(57, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeGold,              //所有地图的金币消耗
function dz_api.DzAPI_Map_MapsConsumeGold(whichPlayer, mapId)
	return japi.RequestExtraIntegerData(58, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeLumber,            //所有地图的木材消耗
function dz_api.DzAPI_Map_MapsConsumeLumber(whichPlayer, mapId)
	return japi.RequestExtraIntegerData(59, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeLv1,               //消费 1-199
function dz_api.DzAPI_Map_MapsConsumeLv1(whichPlayer, mapId)
	return japi.RequestExtraBooleanData(60, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeLv2,               //消费 200-499
function dz_api.DzAPI_Map_MapsConsumeLv2(whichPlayer, mapId)
	return japi.RequestExtraBooleanData(61, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeLv3,               //消费 500~999
function dz_api.DzAPI_Map_MapsConsumeLv3(whichPlayer, mapId)
	return japi.RequestExtraBooleanData(62, whichPlayer, nil, nil, false, mapId, 0, 0)
end
-- MapsConsumeLv4,               //消费 1000+
function dz_api.DzAPI_Map_MapsConsumeLv4(whichPlayer, mapId)
	return japi.RequestExtraBooleanData(63, whichPlayer, nil, nil, false, mapId, 0, 0)
end