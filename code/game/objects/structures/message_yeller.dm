/obj/structure/message_yeller
	name = "message yeller"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "The frame of a meat spike."
	density = TRUE
	anchored = TRUE

	var/datum/socket/listener

/obj/structure/message_yeller/Initialize()
	. = ..()
	listener = new
	if(listener.listen("127.0.0.1", "3445", src, .proc/accept_client))
		say("LISTENING!!")
	else
		say("FAILED TO LISTEN!!!")

/obj/structure/message_yeller/proc/accept_client(datum/socket/cli)
	say("NEW CONSCIOUSNESS!!")
	while(TRUE)
		var/data = cli.recv()
		if(!data)
			break
		say(data + "!!")
