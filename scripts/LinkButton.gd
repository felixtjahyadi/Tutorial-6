extends LinkButton

export(String) var scene_to_load

func _on_New_Game_pressed():
	Transition.change_scene(str("res://scenes/" + scene_to_load + ".tscn"))
