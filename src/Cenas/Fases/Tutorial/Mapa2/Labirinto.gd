extends Node2D

var first = false
# Vai para a próxima área
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa3/Combate.tscn")

# Seta a fala ao entrar no mapa
func _ready():
	$Jose/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'dellson',
				'falas': [
					'Eu fiquei com preguiça de terminar essa área, então fiz o upload de um mapa da Internet mesmo. Espero que você não fique assustado…',
					'hehe'
				]
			},
	])

# Seta a hint ao sair da primeira area 2D
func _on_TutorialMapa2Fala1_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Jose/Camera2D/CanvasLayer/Hint.sendHint('Vá até o final do labirinto')


func _on_TuroalMapa2Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if first == false:
		$Jose/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'BOO!!',
						'Errei o timing?',
						'… Enfim, quando você se deparar com um lugar o qual não consegue passar, pressione ESPAÇO para atravessar pequenos obstáculos.'
					]
				}
			])
		first = true
	
