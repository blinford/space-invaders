extends Node

func save_score(score):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ_WRITE)
	save_file.seek_end()
	save_file.store_line(JSON.stringify({"score":score, "datetime":Time.get_datetime_string_from_system()}))
