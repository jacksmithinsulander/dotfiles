require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set escdelay 0')
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set theme dark-16')
end)
