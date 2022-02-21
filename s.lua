--Only use this Script if you have atleast 1% Lua Knoledge!

--To uninstall just Update your Server Artifacts!

print('[^3FiveM-Server-Hook^0] Commands : \nhook install\nhook test [Needs Script Restart after Fresh Install]\nhook help')

Hook = {}

Hook.V = {}

Hook.V.SchedulerPath = '//citizen//scripting//lua//scheduler.lua' --Dont Edit this loool

Hook.V.PathToFXServerEXE = 'C://ServerName//ArtifactsFolder' --Your Path to FXServer.exe

Hook.V.AlreadyInstalled = 0

--Here you can Modify Shit that gets Hooked [If you use Payed Scripts maybe Remove the PerformHttpRequest Hook!]
Hook.WriteHooks = [[
    --Made by PIMP_CLS#7979
    --RegisterNetEventHook
    RegisterNetEvent = function(eventName, cb)
        if not ignoreNetEvent[eventName] then
            local tableEntry = eventHandlers[eventName]
    
            if not tableEntry then
                tableEntry = { }
    
                eventHandlers[eventName] = tableEntry
            end
    
            tableEntry.safeForNet = true
        end

        print('[^3RegisterNetEvent^0] '.. eventName)
    
        if cb then
            return AddEventHandler(eventName, cb)
        end
    end
    --TriggerClientEventHooks
    if isDuplicityVersion then
        TriggerClientEvent = function(eventName, playerId, ...)
            local payload = msgpack_pack_args(...)
            print('[^3TriggerClientEvent^0] '..eventName, playerId)
            return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
        end
        
        TriggerLatentClientEvent = function(eventName, playerId, bps, ...)
            local payload = msgpack_pack_args(...)
            print('[^3TriggerLatentClientEvent^0] '..eventName, playerId, bps)
            return TriggerLatentClientEventInternal(eventName, playerId, payload, payload:len(), tonumber(bps))
        end
    end
]]

RegisterCommand('hook', function(source, args)
    if source == 0 then
        if args[1] == 'install' then
            print('[^3Hook^0] Starting!')
            Hook.V.SchedulerFile = io.open(Hook.V.PathToFXServerEXE..Hook.V.SchedulerPath, 'r')
            if Hook.V.SchedulerFile ~= nil then
                print('[^3Hook^0] Scheduler File Opened ^2Succsessfully^0!')
                io.input(Hook.V.SchedulerFile)
                Hook.V.SchedulerContent = io.read('a')
                if string.find(Hook.V.SchedulerContent, 'PIMP_CLS') then
                    Hook.V.AlreadyInstalled = 1
                    print('[^3Hook^0] Hook Already ^2Installed^0!')
                    io.close(Hook.V.SchedulerFile)
                end
            else
                print('[^3Hook^0] ^1ERROR^0 Could not Open Scheduler.lua!')
            end
            if Hook.V.SchedulerFile ~= nil and Hook.V.AlreadyInstalled == 0 then
                print('[^3Hook^0] ^2Installing Hook^0!')
                Hook.V.SchedulerFileNew = io.open(Hook.V.PathToFXServerEXE..Hook.V.SchedulerPath, 'a')
                io.output(Hook.V.SchedulerFileNew)
                io.write('\n'..Hook.WriteHooks)
                io.close(Hook.V.SchedulerFileNew)
            end
        end
        if args[1] == 'test' then
            TriggerClientEvent('Hook:test', -1)
            PerformHttpRequest('www.test-request.com')
            PerformHttpRequest('cipher-panel.me')
            RegisterNetEvent('Hook:test')
        end
        if args[1] == 'help' then
            print('             [^3Hook^0] There is no Support for this Sh1t loool')
            print([[
                ⣀⣠⣤⣤⣤⣤⢤⣤⣄⣀⣀⣀⣀⡀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
                ⠄⠉⠹⣾⣿⣛⣿⣿⣞⣿⣛⣺⣻⢾⣾⣿⣿⣿⣶⣶⣶⣄⡀⠄⠄⠄
                ⠄⠄⠠⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣆⠄⠄
                ⠄⠄⠘⠛⠛⠛⠛⠋⠿⣷⣿⣿⡿⣿⢿⠟⠟⠟⠻⠻⣿⣿⣿⣿⡀⠄
                ⠄⢀⠄⠄⠄⠄⠄⠄⠄⠄⢛⣿⣁⠄⠄⠒⠂⠄⠄⣀⣰⣿⣿⣿⣿⡀
                ⠄⠉⠛⠺⢶⣷⡶⠃⠄⠄⠨⣿⣿⡇⠄⡺⣾⣾⣾🟦⣿⣿⣽⣿⣿
                ⠄⠄⠄⠄⠄⠛⠁⠄⠄⠄⢀⣿⣿⣧⡀⠄⠹⣿⣿⣿🟦⡿⣿⣻⣿
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠛⠟⠇⢀⢰⣿⣿⣿🟦⢿⣽⢿⡏
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠤⣤⣴⣾⣿⣿⣾⣿🟦⠄⢹⡿⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠒⣳⣶⣤⣤⣄⣀⣀⡈⣀⢁⢁⢁⣈⣄⢐⠃⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⣰⣿⣛⣻⡿⣿⣿⣿⣿⣿⣿🟦⣿⡯⠄⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⣬⣽⣿⣻⣿⣿⣿⣿⣿⣿⣿🟦⣿⠁⠄⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⢘⣿⣿⣻⣛⣿⡿⣟⣻⣿⣿🟦⡟⠄⠄⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠛⢛⢿⣿⣿⣿⣿⣿⣿🟦⠁⠄⠄⠄
                ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠉⠉⠉⠈]])
        end
    end
end)
