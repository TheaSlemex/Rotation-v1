start = 1
pohon = {}
waktu = {}
fossil = {}
off = {}
on = {}
rekapWaktu = ""
showlistNow = 1
kuntul = 0
loop = 0
waktuHidup = os.time()
license = Main["License"]
seedid = Main.Bot[getBot().name:upper()]["Seed Item Id"]
blockId = seedid - 1
worlds = Main.Bot[getBot().name:upper()]["World Farm List"]
doorId = Main.Bot[getBot().name:upper()]["Farm Door Id"]
worldSeed = Main.Bot[getBot().name:upper()]["World Save Seed"]
saveidSeed = Main.Bot[getBot().name:upper()]["Door World Seed"]
totalWorld = #Main.Bot[getBot().name:upper()]["World Farm List"]
posX = Main.Bot[getBot().name:upper()]["Position Put And Break"][1]
posY = Main.Bot[getBot().name:upper()]["Position Put And Break"][2]
upgradeBp = Main.Bot[getBot().name:upper()]["Upgrade Backpack"]
startFrom = Main.Bot[getBot().name:upper()]["Rotation Start From"]
editWebhooks = Main.Bot[getBot().name:upper()]["Edit Webhook Message"]
messageId = Main.Bot[getBot().name:upper()]["Message Id"]
webhook = Main.Bot[getBot().name:upper()]["Webhook Url"]
looping = WorldSetting["Looping World"]
cutName = WorldSetting["Cut Name World"]
worldPack = WorldSetting["World Pack"]
saveidPack = WorldSetting["Door Pack"]
patokanPack = WorldSetting["Patokan Pack"]
patokanSeed = WorldSetting["Patokan Seed"]
delayBreak = DelaySetting["Delay Break"]
delayPut = DelaySetting["Delay Place"]
delayHt = DelaySetting["Delay Harvest"]
delayPlant = DelaySetting["Delay Plant"]
namePack = PackSetting["Pack Name"]
hargaPack = PackSetting["Pack Price"]
idPack = PackSetting["Pack Item Id"]
buyBreak = PackSetting["Buy After Break"]
mingemBuy = PackSetting["Minimum Gems"]
batasBuy = PackSetting["Max Item"]
resetTime = WebhookSetting["Reset Time"]
customShow = WebhookSetting["Custom Show"]
showList = WebhookSetting["Show List"]
webhookOffline = WebhookSetting["Webhook Offline"]
trashList = TrashSetting["Trash Item"]
maxTrash = TrashSetting["Maximum Item"]
Activity = ""

if editWebhooks == true then
    editWebhook = "true"
else
    editWebhook = "false"
end


if (showList-1) >= totalWorld then
    customShow = false
end

if editWebhook == "true" then
    webhookUrl = webhook.."/messages/"..messageId
else
    webhookUrl = webhook
end

function countworlds()
    totalworld = 0
    progres = 0
    for O, Y in pairs(worlds) do
        if Y ~= nil then
            totalworld = totalworld + 1
		end
    end		  
	for O, S in pairs(worlds) do
        if S ~= nil then
			progres = progres + 1
		end
	    if S:upper() == (getBot()).world:upper() then
			break
		end
	end
	worldnumber = progres .. "/" .. totalworld
end

function worldTime()
    rekapWaktu = ""
    if customShow then
        for i = showList,1,-1 do
            newList = showlistNow - i
            if newList <= 0 then
                newList = newList + totalWorld
            end
            if cutName == true then
                resultcutName = worlds[newList]:upper():sub(#worlds[newList]-3,#worlds[newList])
                if getBot().world:upper() == worlds[newList]:upper() then
                    rekapWaktu = rekapWaktu.."\n"..resultcutName:upper().." | "..(waktu[worlds[newList]] or "No Data").." | "..(pohon[worlds[newList]] or "No Data").." | "..(fossil[world] or "0").." Fossil".." | Now"
                else
                    rekapWaktu = rekapWaktu.."\n"..resultcutName:upper().." | "..(waktu[worlds[newList]] or "No Data").." | "..(pohon[worlds[newList]] or "No Data").." | "..(fossil[world] or "0").." Fossil"
                end
            else
                if getBot().world:upper() == worlds[newList]:upper() then
                    rekapWaktu = rekapWaktu.."\n"..worlds[newList]:upper().." | "..(waktu[worlds[newList]] or "No Data").." | "..(pohon[worlds[newList]] or "No Data").." | "..(fossil[world] or "0").." Fossil".." | Now"
                else
                   rekapWaktu = rekapWaktu.."\n"..worlds[newList]:upper().." | "..(waktu[worlds[newList]] or "No Data").." | "..(pohon[worlds[newList]] or "No Data").." | "..(fossil[world] or "0").." Fossil"
                end
            end
        end
    else
        for _,world in pairs(worlds) do
            if cutName == true then
                resultcutName = world:upper():sub(#world-3,#world)
                if getBot().world == world then
                    rekapWaktu = rekapWaktu.."\n"..resultcutName:upper().." | "..(waktu[world] or "No Data").." | "..(pohon[world] or "No Data").." | "..(fossil[world] or "0").." Fossil".." | Now"
                else
                    rekapWaktu = rekapWaktu.."\n"..resultcutName:upper().." | "..(waktu[world] or "No Data").." | "..(pohon[world] or "No Data").." | "..(fossil[world] or "0").." Fossil"
                end
            else
               if getBot().world == world then
                    rekapWaktu = rekapWaktu.."\n"..world:upper().." | "..(waktu[world] or "No Data").." | "..(pohon[world] or "No Data").." | "..(fossil[world] or "0").." Fossil".." | Now"
                else
                    rekapWaktu = rekapWaktu.."\n"..world:upper().." | "..(waktu[world] or "No Data").." | "..(pohon[world] or "No Data").." | "..(fossil[world] or "0").." Fossil"
                end
            end
        end
    end
end

function powershell(o)
    countworlds()
    sleep(100)
    waktuSc = os.time() - waktuHidup
    worldTime()
    sleep(100)
    if cutName == true then
        resultWorld = getBot().world:sub(#getBot().world-3,#getBot().world)
    else
        resultWorld = getBot().world
    end
    local script = [[
        $webHookUrl = "]]..webhookUrl..[["
        $titleObj = "Pikeri Rotation"
        $desc = '<:megaphone:1055467413463896144> **Information**
]]..o..[['
        $cpu = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average).Average
        $CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
        $Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)
        $ram = [math]::Round($Memory, 0)
        $footerObj = [PSCustomObject]@{
            text = 'Pikeri#0716
]]..os.date("%a %d %b, %Y at %H:%M %p")..[['
        }
        $thumbnailObj = [PSCustomObject]@{
            url = "https://media.discordapp.net/attachments/1064072121426399272/1064090892497072148/images.jpg"
        }
        $fieldArray = @(
            @{
                name = "<:player:1007595580253536257> Name"
                value = "<a:arrowyellow:983237528037498940> ]]..getBot().name..[[ (]]..getBot().level..[[/125)"
                inline = "true"
            }
            @{
                name = "<:status:1007595490600288326> Status"
                value = "<a:arrowyellow:983237528037498940> ]]..getBot().status..[[ (]]..getPing()..[[Ms)"
                inline = "true"
            }
            @{
                name = "<:captcha:1045349267071586324> Captcha"
                value = "<a:arrowyellow:983237528037498940> ]]..getBot().captcha..[["
                inline = "true"
            }
            @{
                name = "<:100gems:1007595715838607401> Gems"
                value = "<a:arrowyellow:983237528037498940> ]]..findItem(112)..[[/]]..mingemBuy..[["
                inline = "true"
            }
            @{
                name = "<:emoji_76:1018295410072244296> World Order (]]..loop..[[ Loop)"
                value = "<a:arrowyellow:983237528037498940> ]]..resultWorld:upper()..[[ (]]..worldnumber..[[)"
                inline = "true"
            }
            @{
                name = "<:ubi:1007595142888312902> Cpu & Ram"
                value = "<a:arrowyellow:983237528037498940> $cpu% | $ram%"
                inline = "true"
            }
            @{
                name = "<:growtopia_clock:1011929976628596746> World List"
                value = "**]]..rekapWaktu..[[**"
                inline = "false"
            }
            @{
                name = "<:growtopia_clock:1011929976628596746> Uptime"
                value = "<a:arrowyellow:983237528037498940> ]]..math.floor(waktuSc/86400)..[[ Days ]]..math.floor(waktuSc%86400/3600)..[[ Hours ]]..math.floor(waktuSc%86400%3600/60)..[[ Minutes"
                inline = "false"
            }
        )
        $embedObject = @{
            title = $titleObj
            description = $desc
            color = "0000001"
            fields = $fieldArray
            footer = $footerObj
            thumbnail = $thumbnailObj
        }
        $embedArray = @($embedObject)
        $payload = @{
            embeds = $embedArray
        }
        $edit = "]]..editWebhook..[["
        if ($edit -match "true") {
            $Method = "Patch"
        } else {
            $Method = "Post"
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method $Method -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end

function loginInfo()
    local script = [[
        $webHookUrl = "]]..webhookOffline..[["
        $titleObj = "Pikeri Rotation"
        $footerObj = [PSCustomObject]@{
            text = 'Pikeri#0716
]]..os.date("%a %d %b, %Y at %H:%M %p")..[['
        }
        $thumbnailObj = [PSCustomObject]@{
            url = "https://media.discordapp.net/attachments/1064072121426399272/1064090892497072148/images.jpg"
        }
        $fieldArray = @(
            @{
                name = "<:status:1055465801097957446> Status
                value = "<:arrow:1041677730044989500> ]]..getBot().name..[[ status ]]..getBot().status..[["
                inline = "false"
            }
            @{
                name = "<:world:1055465741262008423> World"
                value = "<:arrow:1041677730044989500> ]].. getBot().world..[["
                inline = "false"
            }
        )
        $embedObject = @{
            title = $titleObj
            color = "0000001"
            fields = $fieldArray
            footer = $footerObj
            thumbnail = $thumbnailObj
        }
        $embedArray = @($embedObject)
        $payload = @{
            embeds = $embedArray
            content = "@everyone"
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end

function rest(txt)
    local script = [[
        $webHookUrl = "]]..webhookOffline..[["
        $titleObj = "Pikeri Rotation"
        $footerObj = [PSCustomObject]@{
            text = 'Pikeri#0716
]]..os.date("%a %d %b, %Y at %H:%M %p")..[['
        }
        $thumbnailObj = [PSCustomObject]@{
            url = "https://media.discordapp.net/attachments/1064072121426399272/1064090892497072148/images.jpg"
        }
        $fieldArray = @(
            @{
                name = "<:status:1055465801097957446> Information"
                value = "<:arrow:1041677730044989500> **]]..txt..[[**"
                inline = "false"
            }
        )
        $embedObject = @{
            title = $titleObj
            color = "0000001"
            fields = $fieldArray
            footer = $footerObj
            thumbnail = $thumbnailObj
        }
        $embedArray = @($embedObject)
        $payload = @{
            embeds = $embedArray
            content = "@everyone"
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end
  
function scanseed() 
    local count = 0
    for _, obj in pairs(getObjects()) do
        if obj.id == seedid then
            count = count + obj.count
        end
    end
    return count
end

function cekWorld(world)
    fossil[world] = 0
    for _, til in pairs(getTiles()) do
        if til.fg == 3918 then
            fossil[world] = fossil[world] + 1
        end
    end
end

function tree() 
    local count = 0
    for _, til in pairs(getTiles()) do
        if til.fg == seedid and til.ready then
            count = count + 1
        end
    end
    return count
end
        
function relogin(world,id,x,y)
    if getBot().status ~= "online" then
        loginInfo()
        sleep(100)
        while true do
            connect()
            sleep(3000)
            if getBot().status == "online" then
                break
            end
        end
        loginInfo()
        sleep(100)
                
        if getBot().status == "online" and getBot().world ~= world:upper() then
            while getBot().status == "online" and getBot().world ~= world do
                sendPacket(3,"action|join_request\nname|".. world.. "\ninvitedWorld|0")
                sleep(5000)
            end
        end
                
        if getBot().status == "online" and getBot().world == world:upper() then
            while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
                sendPacket(3,"action|join_request\nname|".. world.. "|".. id.. "\ninvitedWorld|0")
                sleep(1000)
            end
        end
                
        if x and y and getBot().status == "online" and getBot().world == world:upper() then
            while math.floor(getBot().x / 32) ~= x and math.floor(getBot().y / 32) ~= y do
                findPath(x,y)
                sleep(100)
            end
        end
    end

    while getBot().captcha:find("Couldn't") or getBot().captcha:find("Wrong") do
        disconnect() 
        sleep(10000)
        while true do
            connect() 
            sleep(3000)
            if getBot().status == "online" then
                break
            end
        end
                
        if getBot().status == "online" and getBot().world ~= world:upper() then
            while getBot().status == "online" and getBot().world ~= world:upper() do
                sendPacket(3,"action|join_request\nname|".. world.. "\ninvitedWorld|0")
                sleep(5000)
            end
        end
                
        if getBot().status == "online" and getBot().world == world:upper() then
            while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
                sendPacket(3,"action|join_request\nname|".. world.. "|".. id.. "\ninvitedWorld|0")
                sleep(1000)
            end
        end
                
        if x and y and getBot().status == "online" and getBot().world == world:upper() then
            while math.floor(getBot().x / 32) ~= x and math.floor(getBot().y / 32) ~= y do
                findPath(x,y)
                sleep(100)
            end
        end
    end
end
--[[
function restTime()
    for _, offline in pairs(off) do
        setBool("Auto Reconnect", false)
        if os.date("%H:%M", os.time() + utcTime * 60 * 60) == offline then
            rest("Time offline, bot will be offline...")
            disconnect()
            sleep(1500)
            for _, online in pairs(on) do
                while os.date("%H:%M", os.time() + utcTime * 60 * 60) == online do
                    connect()
                    sleep(5000)
                    if getBot().status == "online" then
                        break
                    end
                end
                rest("Offline time has passed, now bot is online...")
                setBool("Auto Reconnect", true)
            end
        end
    end
end
]]--
--[[
function restTime()
    for _, time in pairs(offline) do
        if os.date("%H:%M", os.time() + utcTime * 60 * 60) == time then
            rest("Time offline, the bot will be offline...")
            disconnect()
            sleep(sleepOffline)
            while os.date("%H:%M", os.time() + utcTime * 60 * 60) ~= time do
                rest("Offline time has passed, the bot will be online soon...")
                connect()
                sleep(5000)
                if getBot().status == "online" then
                    break
                end
            end
        end
    end
end
]]--

function trashSampah() 
    for _, trash in pairs(trashList) do
        if findItem(trash) >= maxTrash then
            sendPacket(2, "action|trash\n|itemID|"..trash)
            sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|"..trash.."|\ncount|"..maxTrash)
            sleep(100)
        end
    end
end
        
function pindah(world,id)
    n = 0
    nuke = false
    while getBot().status == "online" and getBot().world ~= world:upper() do
        sendPacket(3,"action|join_request\nname|".. world.. "\ninvitedWorld|0")
        sleep(5000)
        if n == 20 then
            nuke = true
            break
        else
            n = n + 1
        end
    end
    
    if not nuke then
        while getBot().status == "online" and getTile(math.floor(getBot().x / 32), math.floor(getBot().y / 32)).fg == 6 do
            sendPacket(3,"action|join_request\nname|".. world.. "|".. id.. "\ninvitedWorld|0")
            sleep(2500)
        end
    end
end
 
function puncha(px, py)
    punch(px,py)
    pkt = {}
    pkt.type = 0
    pkt.flags = 2608
    pkt.pos_x = getBot().x
    pkt.pos_y = getBot().y
    pkt.int_x = math.floor(getBot().x / 32) + px
    pkt.int_y = math.floor(getBot().y / 32) + py
    sendPacketRaw(pkt)
end

function placea(pid, px, py)
    place(pid,px,py)
    pkt = {}
    pkt.type = 0
    pkt.flags = 3104
    pkt.int_data = pid
    pkt.pos_x = getBot().x
    pkt.pos_y = getBot().y
    pkt.int_x = math.floor(getBot().x / 32) + px
    pkt.int_y = math.floor(getBot().y / 32) + py
    sendPacketRaw(pkt)
end
    
function round(n)
    return n % 1 > 0.5 and math.ceil(n) or math.floor(n)
end
        
function dropPack(x,y,jumlah)
    local count = 0
    local stak = 0
    for _, obj in pairs(getObjects()) do
        if round(obj.x / 32) == x and math.floor(obj.y / 32) == y then
            count = count + obj.count
            stak = stak + 1
        end
    end
            
    if stak < 20 and count <= (4000 - jumlah) then
        return true
    end
    return false
end
        
function dropSeed(x,y,jumlah)
    local count = 0
    for _,obj in pairs(getObjects()) do
        if round(obj.x / 32) == x and math.floor(obj.y / 32) == y then
            count = count + obj.count
        end
    end  

    if count <= (4000 - jumlah) then
        return true
    end
    return false
end

function narohPack()
    for _, pack in pairs(idPack) do
        for _, til in pairs(getTiles()) do
            if til.fg == patokanPack or til.bg == patokanPack then
                if dropPack(til.x,til.y,findItem(pack)) then
                    while math.floor(getBot().x / 32) ~= (til.x-1) or math.floor(getBot().y / 32) ~= til.y do
                        findPath(til.x-1,til.y)
                        sleep(1000)
                        relogin(worldPack,saveidPack)
                        sleep(100)
                    end
                    while findItem(pack) > 0 and dropPack(til.x,til.y,findItem(pack)) do
                        sendPacket(2,"action|drop\nitemID|" .. pack)
                        sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|" .. pack .. "|\ncount|" .. findItem(pack))
                        sleep(500)
                        relogin(worldPack,saveidPack)
                        sleep(100)
                    end
                end
                if findItem(pack) == 0 then
                    break
                end
            end
        end
    end
end
        
function buyPack()
    pindah(worldPack,saveidPack)
    sleep(100)
    relogin(worldPack,saveidPack)
    sleep(100)
    collectSet(false,3) 
    sleep(100)
    if getBot().slots == 16 or getBot().slots == 26 or getBot().slots == 36 then
        for z = 1, upgradeBp do
            if findItem(112) > 100 then
                sendPacket(2,"action|buy\nitem|upgrade_backpack")
                sleep(500)
            end
        end
    end 
            
    while findItem(112) >= hargaPack do
        for a = 0, batasBuy do
            sendPacket(2,"action|buy\nitem|".. namePack)
            sleep(500)
            kuntul = kuntul + 1
            relogin(worldPack,saveidPack)
            sleep(100)
            if findItem(112) < hargaPack then
                break
            end
        end
        narohPack() 
        sleep(100)
    end
    powershell("Dropped "..kuntul.." Pack...")
    sleep(100)
end
        
function narohSeed() 
    pindah(worldSeed,saveidSeed)
    sleep(100)
    relogin(worldSeed,saveidSeed)
    sleep(100)
    collectSet(false,3)
    sleep(100)
    for _, til in pairs(getTiles()) do
        if til.fg == patokanSeed or til.bg == patokanSeed then
            if dropSeed(til.x,til.y,100) then
                while math.floor(getBot().x / 32) ~= (til.x-1) or math.floor(getBot().y / 32) ~= til.y do
                    findPath(til.x-1,til.y)
                    sleep(1000)
                    relogin(worldSeed,saveidSeed,til.x-1,til.y)
                    sleep(100)
                end
                while findItem(seedid) >= 100 and dropSeed(til.x,til.y,100) do
                    sendPacket(2,"action|drop\nitemID|" .. seedid)
                    sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|" .. seedid .. "|\ncount|" .. 100)
                    sleep(500)
                    relogin(worldSeed,saveidSeed,til.x-1,til.y)
                    sleep(100)
                end
            end
            if findItem(seedid) < 100 then
                break
            end
        end
    end
    powershell("Dropped "..scanseed(seedid).." Seed...")
    sleep(100)
end

function harvest(world)
    powershell("Harvesting "..tree().." Ready Tree")
    sleep(100)
    for _, tile in pairs(getTiles()) do
        if tile.fg == seedid and tile.ready then
            pohon[world] = pohon[world] + 1
            findPath(tile.x,tile.y)
            while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).ready do
                puncha(0,0)
                sleep(delayHt)
                relogin(world,doorId,tile.x,tile.y)
            end
        end
        if findItem(seedid-1) >= 190 then
            break
        end
    end
end
           
function Pnb(world)
    powershell("Breaking "..findItem(blockId).." Block")
    sleep(100)
    findPath(posX,posY)
    sleep(100)
    while findItem(blockId) > 0 do
        while getTile(math.floor(getBot().x / 32) - 1, math.floor(getBot().y / 32)).fg == 0 and getTile(math.floor(getBot().x / 32) - 1, math.floor(getBot().y / 32)).bg == 0 do
            placea(blockId,-1,0)
            sleep(delayPut)
            relogin(world,doorId,posX,posY)
        end
                
        while getTile(math.floor(getBot().x / 32) - 1, math.floor(getBot().y / 32)).fg ~= 0 or getTile(math.floor(getBot().x / 32) - 1, math.floor(getBot().y / 32)).bg ~= 0 do
            puncha(-1,0)
            sleep(delayBreak)
            relogin(world,doorId,posX,posY)
        end
        relogin(world,doorId,posX,posY)
    end
    trashSampah()
    sleep(100)
    if buyBreak and findItem(112) >= mingemBuy then
        buyPack()
        sleep(100)
        pindah(world,doorId)
        sleep(100)
        relogin(world,doorId)
        sleep(100)
        collectSet(true,3)
        sleep(100)
    end
end

function detekPohon(itemid) 
    local count = 0
    for _, til in pairs(getTiles()) do
        if til.fg == itemid and til.ready then
            count = count + 1
        end
    end
    return count
end
              
function Plant(world)
    collectSet(true,3)
    sleep(100)
    pohon[world] = 0
    while detekPohon(seedid) > 0 do
        harvest(world)
        sleep(100)
        Pnb(world)
        sleep(100)
        powershell("Planting "..findItem(seedId).." Seed")
        sleep(100)
        for _, tile in pairs(getTiles()) do
            if tile.flags ~= 0 and tile.y ~= 0 and getTile(tile.x,tile.y-1).fg == 0 then
                findPath(tile.x, tile.y-1)
                while getTile(tile.x, tile.y-1).fg == 0 and getTile(tile.x, tile.y).flags ~= 0 do
                    placea(seedid,0,0)
                    sleep(delayPlant)
                    relogin(world,doorId,tile.x,tile.y-1)
                end
            end
            if findItem(seedid) == 0 then
                break
            end
        end
        
        if findItem(seedid) >= 100 then
            narohSeed()
            sleep(100)
            pindah(world,doorId)
            sleep(100)
            collectSet(true,3)
            sleep(100)
        end
    end
    
    if detekPohon(seedid) < 1 then
        while findItem(seedid-1) > 0 do
            Pnb(world)
            sleep(100)
            for _, tile in pairs(getTiles()) do
                if tile.flags ~= 0 and tile.y ~= 0 and getTile(tile.x,tile.y-1).fg == 0 then
                    findPath(tile.x, tile.y-1)
                    while getTile(tile.x, tile.y-1).fg == 0 and getTile(tile.x, tile.y).flags ~= 0 do
                        place(seedid,0,0)
                        sleep(delayPlant)
                        relogin(world,doorId,tile.x,tile.y-1)
                    end
                end
                
                if findItem(seedid) == 0 then
                    break
                end
            end
        
            if findItem(seedid) >= 100 then
                narohSeed()
                sleep(100)
                pindah(world,doorId)
                sleep(100)
                collectSet(true,3)
                sleep(100)
            end
            
            if findItem(seedid-1) == 0 then
                break
            end
        end
    end
end

function logWindow(text)
  os.execute("PowerShell -Command \"Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('" .. text .. "','Pikeri Rotation Message','OK','Asterisk')\"")
end

res = ""
val = {104, 116, 116, 112, 115, 58, 47, 47, 103, 108, 111, 98, 97, 108, 45, 108, 105, 99, 101, 110, 115, 101, 46, 105, 116, 115, 108, 99, 46, 114, 101, 112, 108, 46, 99, 111, 47, 108, 105, 99, 101, 110, 115, 101, 47, 36, 76, 105, 99}
for i = 1, #val do
    res = res..string.char(val[i])
end

function checkLicense()
    local script = [[
        $Lic = "]]..license..[["
        $HWID = (Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\ -Name MachineGuid).MachineGUID
        $Valid = "C:\Users\" + $env:UserName + "\AppData\Local\true.txt"
        $InValid = "C:\Users\" + $env:UserName + "\AppData\Local\false.txt"
        $url = "]]..res..[["
        $body = @{
            hwid = $HWID
        }

        If (Test-Path $Valid) {
            Remove-Item $Valid
        }

        If (Test-Path $InValid) {
            Remove-Item $InValid
        }

        try {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $check = Invoke-RestMethod -Uri $url -Body ($body | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
            if ($check -match "$HWID") {
                New-Item $Valid -type file
                Add-Content -Path $Valid -Value "$check"
            }else{
                New-Item $InValid -type file
                Add-Content -Path $InValid -Value "$check"
            }
        } catch {
            New-Item $InValid -type file
            Add-Content -Path $InValid -Value "$HWID"
            return
        }
    ]]
    local pipe = io.popen("powershell -NoLogo -WindowStyle Hidden -ExecutionPolicy Bypass -command -", "w")
    pipe:write(script)
    pipe:close()
end

checkLicense()

function file(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local username = os.getenv('USERNAME');
if file("C:\\Users\\" .. username .. "\\AppData\\Local\\true.txt") then
    os.remove("C:\\Users\\" .. username .. "\\AppData\\Local\\true.txt")
    logWindow("License Valid, Have Fun Guys")
    if getBot().status ~= "online" then
        loginInfo()
        sleep(100)
        while true do
            connect() 
            sleep(3000)
            if getBot().status == "online" then
                break
            end
        end
        loginInfo()
        sleep(100)
    end
    
    while getBot().status == "online" and getBot().world ~= worlds[startFrom] do
        sendPacket(3,"action|join_request\nname|"..worlds[startFrom].. "\ninvitedWorld|0")
        sleep(10000)
        if getBot().world == worlds[startFrom] then
            break
        end
    end
        
    while true do
        for index, world in pairs(worlds) do
            pindah(world,doorId)
            sleep(100)
            relogin(world,doorId)
            sleep(100)
            if not nuke then
                worldTime() 
                sleep(100)
                cekWorld(world)
                sleep(100)
                waktuHt = os.time()
                powershell("Harvesting "..tree().." Tree...")
                sleep(100)    
                Plant(world)
                sleep(100)
                waktuHt2 = os.time() - waktuHt
                waktu[world] = math.floor(waktuHt2/3600).." Hours "..math.floor(waktuHt2%3600/60).." Minutes"
                sleep(100)
                powershell("Worlds Done, Time : "..math.floor(waktuHt2%86400/3600).." Hours "..math.floor(waktuHt2%86400%3600/60).." Minutes")
                sleep(100)
                if looping then
                    if startFrom < #worlds then
                        startFrom = startFrom + 1
                    else
                        if resetTime then
                            pohon = {}
                            waktu = {}
                        end
                        startFrom = 1
                    end
                end
            else
                waktu[world] = "NUKED"
                pohon[world] = "NUKED"
                nuke = false
                sleep(5000)
            end
            
            if not buyBreak and findItem(122) >= hargaPack then
                buyPack()
                sleep(200)
                pindah(world,doorId)
                sleep(200)
                relogin(world,doorId)
                sleep(200)
                collectSet(true,3)
                sleep(100)
            end
        end
    
        if not looping then
            powershell("The World Is Done, Removing Bot...")
            sleep(100)
            removeBot(getBot().name)
            sleep(2000)
            break
        end
        
        loop = loop + 1
    end
elseif file("C:\\Users\\" .. username .. "\\AppData\\Local\\false.txt") then
    os.remove("C:\\Users\\" .. username .. "\\AppData\\Local\\false.txt")
    logWindow("License Denied, Please Contact Pikeri#0716")
    sleep(10000)
end
