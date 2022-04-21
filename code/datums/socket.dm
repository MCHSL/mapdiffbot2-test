/proc/enable_sockets()
	return call("byond-extools.dll", "init_sockets")()

/datum/socket
	var/__accept_cb_src
	var/__accept_cb_proc

/datum/socket/proc/__register_socket()
/datum/socket/proc/__deregister_socket()
/datum/socket/proc/__check_has_data()
/datum/socket/proc/__wait_for_data()
/datum/socket/proc/__retrieve_data()
/datum/socket/proc/__check_can_accept()
/datum/socket/proc/__wait_accept()
/datum/socket/proc/__accept()


/datum/socket/New()
	__register_socket()

/datum/socket/Del()
	//world << "Deleting socket"
	__deregister_socket()

//addr is a string with IP or domain, port is a number
/datum/socket/proc/connect(addr, port)

//returns TRUE on success, FALSE on failure (e.g. disconnect)
/datum/socket/proc/send(data)

//returns the received data as a string. Returns up to `len` bytes as a string, or sleeps until there's data in the buffer.
/datum/socket/proc/recv(len)
	if(!__check_has_data())
		__wait_for_data()
	return __retrieve_data()

/datum/socket/proc/accept()
	if(!__check_can_accept())
		__wait_accept()
	return __accept()

/datum/socket/proc/__accept_loop()
	set waitfor = 0

	while(TRUE)
		var/datum/socket/s = accept()
		__invoke_callback(s)

/datum/socket/proc/__invoke_callback(datum/socket/cli)
	if(__accept_cb_src)
		call(__accept_cb_src, __accept_cb_proc)(cli)
	else
		call(__accept_cb_proc)(cli)

/datum/socket/proc/listen(addr, port, callback_src, callback_path)
	__accept_cb_src = callback_src
	__accept_cb_proc = callback_path
	__accept_loop()
	return __listen(addr, port, callback_src, callback_path)

/datum/socket/proc/__listen(addr, port, callback_src, callback_path)

//disconnect the socket
/datum/socket/proc/close()

/proc/__create_socket()
	return new /datum/socket()
