SUBSYSTEM_DEF(callbacks)
	name = "Callbacks"
	flags = SS_TICKER
	wait = 1
	priority = FIRE_PRIORITY_CHAT
	init_order = INIT_ORDER_CHAT

/datum/controller/subsystem/callbacks/fire()
	process_callbacks()
