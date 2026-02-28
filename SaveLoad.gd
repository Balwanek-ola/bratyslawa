extends Node

var high_score: int = 0

func ready():
	pass

func _save():
	var config = ConfigFile.new()
	config.set_value("General", "high_score", high_score)
	config.save("user://save.cfg")
	print("save")


func _load():
	var config = ConfigFile.new()
	var result = config.load("user://save.cfg")
	#Global.loadsave = true
	
	if  result == OK:
		high_score = config.get_value("General", "high_score", high_score)
	else: 
		print("no save")
