extends Node2D

func setvalue(hp: int):
	$hb.value = hp
	if hp == 1:
		$AnimationPlayer.play("low_hp")
