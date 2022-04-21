/obj/item/movingmeme
	name = "moving meme"
	desc = "Sterile and airtight."
	icon_state = "latexballon"
	item_state = "lgloves"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 7
	var/datum/socket/socket

/obj/item/movingmeme/Initialize()
	socket = new
	if(socket.connect("127.0.0.1", 7777))
		to_chat(world,"connected succfully")
	else
		to_chat(world,"failed to connect")
	socket.send("Moving meme connected!")
	spawn(5)
		loop()
	return ..()

/obj/item/movingmeme/Destroy()
	QDEL_NULL(socket)
	..()

/obj/item/movingmeme/proc/loop()
	while(TRUE)
		var/data = socket.recv()
		if(!data)
			to_chat(world, "Moving meme disconnected")
			return
		switch(data)
			if("up")
				step(src, NORTH)
			if("down")
				step(src, SOUTH)
			if("left")
				step(src, WEST)
			if("right")
				step(src, EAST)
			else
				socket.send("WHAT DO YOU WANT FROM ME?")
				continue
		socket.send(data)
