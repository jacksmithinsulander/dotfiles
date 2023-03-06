require('vis')

leader = '<Space>'

vis.events.subscribe(vis.events.INIT, function()
	vis:command('set escdelay 0')
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set theme dark-16')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set relativenumbers')
	vis:command('set colorcolumn 80')
end)

vis:map(vis.modes.NORMAL, ':G', ':!./test.sh')
