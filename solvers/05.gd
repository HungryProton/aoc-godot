extends Day


var _seeds: Array[int] = []
var _maps: Array[Map] = []


func solve_first() -> String:
	_parse_input()
	var closest := -1
	
	for i in _seeds:
		var value: int = i;
		for m in _maps:
			value = m.remap_value(value)
		if closest == -1 or value < closest:
			closest = value
	
	return str(closest)


func solve_second() -> String:
	var time_start = Time.get_ticks_msec()
	_parse_input()
	_maps.reverse()
	
	var smallest_location: int = -1
	var highest_location: int = -1
	for m in _maps:
		for range in m.ranges:
			if range.dst_end > highest_location:
				highest_location = range.dst_end
			if smallest_location == -1 or range.dst_start < smallest_location:
				smallest_location = range.dst_start
	
	print("Searching from ", smallest_location, " to ", highest_location)

	# Check the full range every X elements. Once you find a seed, stop and
	# try again with that location as the upper boundary until it converge.
	var closest := highest_location
	var previous := -1
	
	while closest != previous:
		previous = closest
		var chunk_count: int = min(10000000, closest) # TMP - magic number that could definitely be lower
		for chunk in chunk_count:
			var idx := floori(chunk * max(1, (closest / chunk_count)))
			var seed_value := idx
			for m in _maps:
				seed_value = m.remap_value_reverse(seed_value)
			if _is_seed(seed_value):
				closest = idx
				break
	
	print("Time: ", (Time.get_ticks_msec() - time_start) / 1000.0 )
	return str(closest)


func _is_seed(value) -> bool:
	for i in range(0, _seeds.size() - 1, 2):
		var start: int = _seeds[i]
		var end: int = start + _seeds[i + 1]
		if value >= start and value <= end:
			return true
	return false


func _parse_input() -> void:
	# Parse seeds
	_seeds.clear()
	var first_line: String = input[0]
	input.remove_at(0)

	var s := first_line.split(":", false)
	for token in s[1].split(" ", false):
		_seeds.push_back(token.to_int())

	# Parse maps
	var map: Map
	for line in input:
		if line.is_empty():
			map = Map.new()
			_maps.push_back(map)
			continue
		
		if map.id.is_empty():
			map.id = line.split(" ")[0]
			continue
		
		var s2 := line.split(" ")
		map.add_range(s2[0].to_int(), s2[1].to_int(), s2[2].to_int())


class CustomRange:
	# Inclusive
	var src_start: int
	var src_end: int
	var dst_start: int
	var dst_end: int
	
	func has(value: int) -> bool:
		return value >= src_start and value <= src_end
	
	func has_reverse(value: int) -> bool:
		return value >= dst_start and value <= dst_end
	
	func remap_value(value: int) -> int:
		return dst_start + (value - src_start)
	
	func remap_reverse(value: int) -> int:
		return src_start + (value - dst_start)
	
	func _to_string() -> String:
		return "src: " + str(src_start) + "," + str(src_end) + " - dst: " + str(dst_start)


class Map:
	var id: String = ""
	var ranges: Array[CustomRange] = []
	
	func add_range(dst: int, src: int, length: int) -> void:
		var r = CustomRange.new()
		r.src_start = src
		r.src_end = src + length - 1
		r.dst_start = dst
		r.dst_end = dst + length - 1
		ranges.push_back(r)

	func remap_value(value: int) -> int:
		for r in ranges:
			if r.has(value):
				return r.remap_value(value)
		return value
	
	func remap_value_reverse(value: int) -> int:
		for r in ranges:
			if r.has_reverse(value):
				return r.remap_reverse(value)
		return value

	func _to_string() -> String:
		return id + ":" + str(ranges)
