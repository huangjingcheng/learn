-----------------------------------------------
--文件：   init.lua  游戏里的所有的网络相关写在这样
--作者：   蓝面包(wc24@qq.com)
--时间：   2016-11-03 14:50:15
--功能：   Command
-----------------------------------------------
local zeromvc = require "zeromvc.zeromvc"
local ZeroHttp=require("zeromvc.net.ZeroHttp")
local __Class = zeromvc.classCommand(...)
function __Class:init()
end

function __Class:execute(gd,getVoFn)
	-------------------
	--再包装一层
	-------------------
	cc.exports.httpNet=ZeroHttp:new()
	self.zero.server=sc
	cc.exports.newCS=function ()
		local vo={}
		vo.urlVo=getVoFn()
		vo.info=gd.cs:new()
		vo.add=function (vo,callback,isbehind,state)
			state=state or 1
			local callbackTable
			if isbehind then
				callbackTable=vo.urlVo.behindFn
			else
				callbackTable=vo.urlVo.beforeFn
			end
			if type(callback)=="function" then
				callbackTable[state]=callback
			else
				callbackTable[state]=function ()
					self:command(callback)
				end
			end
		end
		vo.send=function (vo,isWaiting)
			if isWaiting==nil then
				isWaiting=true
			else
				isWaiting=false
			end
			zeroDebug("send",vo.info)
			vo.urlVo.send = vo.info;  --TODO huangjincheng
			local timeProxy = self.zero:getProxy("game.time.TimeProxy")
			local banerProxy = self.zero:getProxy("game.baner.BanerProxy")
    		local dest={}
    		table.merge(dest, vo.info)
    		if tonumber(banerProxy.mse) > 0 then
     			dest.rsn=tools.encryptTime(timeProxy:getTime()).."~"..math.random(10000000,99999999)
    		else
    			dest.rsn=tools.encryptTime(timeProxy:getTime())
    		end
     		vo.info = dest
     		local data = tonumber(banerProxy.mse) > 0 and tools.encryptData(json.encode(vo.info),tonumber(banerProxy.mse)) or json.encode(vo.info)
			vo.urlVo.data=data
			vo.urlVo.isWaiting=isWaiting
			httpNet:load(vo.urlVo)
			if isWaiting then
				self.zero:command(GameKey.WAITING,true)
			end
		end
		vo.moni=function (vo,data)
			self:parse(vo.urlVo,data)
		end
		return vo
	end
	local player = king:getProxy("game.player.PlayerProxy")
	local function okHd(sender,type,vo,state,data)
		if vo.isWaiting then
			self.zero:command(GameKey.WAITING,false)
		end
		player.testHttpData = json.decode(data)
		UICommon.saveHttpError()
		zeroDebug("server",22222)
		zeroDebug("server",data)
		self:parse(vo,data)
	end
	local function noHd(sender,type,vo,state,data)
		if vo.isWaiting then
			self.zero:command(GameKey.WAITING,false)
		end
		trace(vo.url,state,"失败")
	end
	httpNet:addEvent(ZeroHttp.SUCCESS,okHd)
	httpNet:addEvent(ZeroHttp.FAIL,noHd)
end

local setSCforAll
local setSCArrayforAll
local setSCforUp
local setSCArrayforUp
local function setEnum(t,k,v)
-----------------黄牛专业修改-----------------
t[k]=v+1
-- if type(v)=="number" then
-- 	t[k]=v+1
-- else
-- 	t[k]=v
-- end
-----------------黄牛专业修改-----------------
end
setSCforAll = function (obj,val,path)
	obj:revert(false)
	for k,v in pairs(val) do
		if obj[k]~=nil then
			if gd.metaType(obj[k])==gd.TYPE.HASH then
				if type(v)=="table" then
					setSCforAll(obj[k],v,path.."."..k);
				else
					zeroWarn("协议格式出错:"..path.."."..k)
				end
			elseif gd.metaType(obj[k])==gd.TYPE.ARRAY then				
				if type(v)=="table" then
					setSCArrayforAll(obj[k],v,path.."."..k);
				else
					zeroWarn("协议格式出错:"..path.."."..k)
				end
			elseif gd.metaType(obj[k])==gd.TYPE.ENUM then
				setEnum(obj,k,v)
			else
				obj[k]=v
			end

		end
	end
end
setSCArrayforAll =  function (obj,val,path)
	obj:revert(false)
	for k,v in ipairs(val) do
		obj:add()
		if gd.metaType(obj[k])==gd.TYPE.HASH then
			setSCforAll(obj[k],v,path.."."..k);
		elseif gd.metaType(obj[k])==gd.TYPE.ARRAY then
			setSCArrayforAll(obj[k],v,path.."."..k);
		elseif gd.metaType(obj[k])==gd.TYPE.ENUM then
			setEnum(obj,k,v)
		else
			obj[k]=v
		end
	end
end

setSCforUp = function (obj,val,path)
	if type(val)~="table"then
		zeroWarn("协议格式出错:"..path)
	else
		for k,v in pairs(val) do
			if obj[k]~=nil then
				if gd.metaType(obj[k])==gd.TYPE.HASH then
					setSCforUp(obj[k],v,path.."."..k);
				elseif gd.metaType(obj[k])==gd.TYPE.ARRAY then
					setSCArrayforUp(obj[k],v,path.."."..k);
				elseif gd.metaType(obj[k])==gd.TYPE.ENUM then
					setEnum(obj,k,v)
				else
					obj[k]=v
				end

			end
		end
	end
end
setSCArrayforUp =  function (obj,val,path)
	for k,v in ipairs(val) do
		if type(v)~="table" or v.id==nil then
			zeroWarn("方法u只有更新带有id的table为子项的数组")
		else
			local item=v.idx~=nil and obj:getBy("idx",v.idx) or obj:getBy("id",v.id)
			if item==nil then
				item=obj:add()
			end
			local a,b = string.find(path,"hangUpSystem",0)
			if a and a > 0 then
				setSCforAll(item,v,path.."."..k);
			else
				setSCforUp(item,v,path.."."..k);
			end
		end
	end
end

function __Class:parse(vo,data)
	if data~=nil then
		zeroDebug("server",data)
		local useData=json.decode(data)
		zeroDebug("server",useData)
		writeFile(vo.url,vo.send,useData)
		if useData~=nil and type(useData)=="table" then
			if useData.a~=nil then
				setSCforAll(sc,useData.a,"root")
			end
			if  useData.u~=nil then		
				setSCforUp(sc,useData.u,"root")
			end
			local beforeFn=vo.beforeFn[useData.s or 1]
			if beforeFn~=nil then
				beforeFn()
			end
			local beforeAllFn=vo.beforeFn["all"]
			if beforeAllFn~=nil then
				beforeAllFn()
			end
			sc:flush();
			local behindFn=vo.behindFn[useData.s or 1]
			if behindFn~=nil then
				behindFn()
			end
			local behindAllFn=vo.behindFn["all"]
			if behindAllFn~=nil then
				behindAllFn()
			end
		else
			zeroWarn("json协议出错")
		end
	end
end
function writeFile(url,send,server,mode)
	mode = mode or "a"
	local path = os.getenv("CLIENTPATH") or "D:\\clientLog.txt"
	local file = io.open(path, mode)
	local data = {}
	data.url = url
	data.send = send
	data.server = server
	if file then
		if file:write(json.encode(data).."\n") == nil then return false end
		io.close(file)
		return true
	else
		return false
	end
end
return __Class