local logEnabled = false

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, type)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source, type)
end)