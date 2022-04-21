SUBSYSTEM_DEF(redis_reader)
	name = "Redis Reader"
	wait = 5 SECONDS //Roll for new guests but don't do it too fast.
	init_order = INIT_ORDER_DEFAULT

/datum/controller/subsystem/redis_reader/Initialize(timeofday)
	to_chat(world, "Connect: [rustg_redis_connect("redis://127.0.0.1/")]")
	to_chat(world, "Connect: [rustg_redis_connect("redis://127.0.0.1/")]")
	to_chat(world, "Subscribe: [rustg_redis_subscribe("bepis")]")
	return ..()

/datum/controller/subsystem/redis_reader/fire()
	var/messages = rustg_redis_get_messages()
	to_chat(world, "Messages: [messages]")
	rustg_redis_publish("bepis", "Hello to you too")
