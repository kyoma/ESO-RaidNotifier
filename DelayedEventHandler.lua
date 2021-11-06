local EventArgumentBag = ZO_Object:Subclass()

function EventArgumentBag:New()
    local object = ZO_Object.New(self)

    object.allEventArgs = {}

    return object
end

function EventArgumentBag:Push(args)
    table.insert(self.allEventArgs, args)
end

function EventArgumentBag:ContainsArgumentWithValue(name, value)
    for _, arguments in ipairs(self.allEventArgs) do
        if arguments[name] == value then
            return true
        end
    end

    return false
end

local Handler = {}

local eventStorage = {}

function Handler.Add(name, arguments, releaseFunction, delayInMs)
    if eventStorage[name] == nil then
        eventStorage[name] = {
            callId = nil,
            argsBag = EventArgumentBag:New(),
        }
    end

    eventStorage[name].argsBag:Push(arguments)

    if eventStorage[name].callId == nil then
        eventStorage[name].callId = zo_callLater(
            function()
                releaseFunction(eventStorage[name].argsBag)
                eventStorage[name] = nil
            end,
            delayInMs
        )
    end
end

RaidNotifier = RaidNotifier or {}
RaidNotifier.DelayedEventHandler = Handler
