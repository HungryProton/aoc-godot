extends Day


func solve_first() -> String:
	var sum := 0
	var limit = Vector3i(12, 13, 14)
	
	for line in input:
		var data: GameData = get_data(line)
		var is_valid := true
		
		for s in data.sets:
			if s.x > limit.x or s.y > limit.y or s.z > limit.z:
				is_valid = false
		
		if is_valid:
			sum += data.id
		
	return str(sum)


func solve_second() -> String:
	var sum := 0

	for line in input:
		var data: GameData = get_data(line)
		var max := Vector3i.ONE * -1
		
		for s in data.sets:
			for i in 3:
				if s[i] > max[i]:
					max[i] = s[i]

		sum += max.x * max.y * max.z

	return str(sum)


func get_data(line: String) -> GameData:
	var data := GameData.new()

	var tokens := line.split(":")
	var id_tokens = tokens[0].split(" ", false)
	var set_tokens = tokens[1].split(";", false)
	
	data.id = id_tokens[1].to_int()
	for t in set_tokens:
		var set_data := Vector3i.ZERO
		var color_tokens := t.split(",", false)

		for c in color_tokens:
			var color_data := c.split(" ", false)
			match color_data[1]:
				"red":
					set_data.x = color_data[0].to_int()
				"green":
					set_data.y = color_data[0].to_int()
				"blue":
					set_data.z = color_data[0].to_int()
		
		data.sets.push_back(set_data)
	
	return data


class GameData:
	var id: int
	var sets: Array[Vector3i]
