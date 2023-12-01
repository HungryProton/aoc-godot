class_name Day
extends RefCounted


var input: PackedStringArray

func solve(part: int, p_input: String) -> String:
	input = p_input.split("\n")
	match part:
		1: return solve_first()
		2: return solve_second()
	return "ERROR"


func solve_first() -> String:
	return ""


func solve_second() -> String:
	return ""
