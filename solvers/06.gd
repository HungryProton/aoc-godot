extends Day





func solve_first() -> String:
	var races: Array[Vector2i] = []
	var times := input[0].split(":", false)[1].split(" ", false)
	var dist := input[1].split(":", false)[1].split(" ", false)
	for i in times.size():
		races.push_back(Vector2i(times[i].to_int(), dist[i].to_int()))
	
	var margin := -1
	
	for r in races:
		var valid_times := 0
		for i in r.x:
			var remaining_time: int = r.x - i
			var distance: int = remaining_time * i
			if distance > r.y:
				valid_times += 1

		if margin < 0:
			margin = valid_times
		elif valid_times > 0:
			margin *= valid_times
	
	return str(margin)


func solve_second() -> String:
	var time_str := ""
	for t in input[0].split(":", false)[1].split(" ", false):
		time_str += t
	
	var dst_str := ""
	for d in input[1].split(":", false)[1].split(" ", false):
		dst_str += d
	
	var time := time_str.to_int()
	var record_distance := dst_str.to_int()

	var valid_times := 0
	for i in time:
		var remaining_time: int = time - i
		var distance: int = remaining_time * i
		if distance > record_distance:
			valid_times += 1

	return str(valid_times)
