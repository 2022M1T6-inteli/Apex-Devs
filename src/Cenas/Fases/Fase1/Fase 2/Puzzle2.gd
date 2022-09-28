extends Node2D
# CÓDIGO EM PRODUÇÃO - NÃO PLANEJAMOS ENTREGAR NA SPRINT 4.
# ESSE CÓDIGO AINDA NÃO FOI FINALIZADO, PORTANTO AINDA IRÁ SER COMPLETO E REFATORADO
onready var camera = $Player/Camera
var isOnPlayerCamera = true
var enteredSwordsmanArea = false
var enteredGalloArea = false
var enteredSwordArea = false
var enteredDellsonArea = false

var onSword = false
var onSwordsman = false
var talkedSwords = false
var talkedWithSwordsman = false
var talkedWithGallo = false
var change = 0
var hasSword

# Envia os diálogos do swordsman
func sendSwordsmanDialog():
	if !talkedWithSwordsman:
		$Player/Camera/CanvasLayer/Hint.sendHint("Recupere a espada do espadachim nas ilhas ao Sul")
		$Swordsman.setInteraction(0)
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "swordsman",
				"falas": [
					'Olá, player!',
					'Eu não sei o que ocorreu direito, do nada um terremoto aconteceu e tem água por tudo agora!',
					'No meio do desastre, minha espada voou para o Sul daqui. Vi que você está construindo seu caminho entre as ilhas, com a ajuda de minha espada conseguiremos sair daqui!'
				]
			},
			{
				"personagem": "dellson",
				"falas": [
					"Você escutou o cara... atrás da espada dele!"
				]
			},
			{
				"personagem": "swordsman",
				"falas": [
					"E... eu vou com você, tudo bem? Não quero ficar sozinho aqui hehe"
				]
			}
		])

func sendGalloDialog():
	if !talkedWithGallo:
		talkedWithGallo = true
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "gallo",
				"falas": [
					"Po pó pó pó."
				]	
			},
			{
				"personagem": "dellson",
				"falas": [
					"O Gallo mandou saudações e espera poder ajudar você nessa aventura."
				]	
			},
			{
				"personagem": "gallo",
				"falas": [
					"Có có ri có"
				]
			},
			{
				"personagem": "dellson",
				"falas": [
					"O Gallo disse que voce precisa se atentar, perceber que ao longo do caminho seu roteiro pode ter que mudar, e será preciso estar preparado para mudanças!"
				]	
			},
		])
	else:
		if hasSword:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po pó po po!"
					]	
				}
			])
		else:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po pó po po....",
						"Po pó pó."
					]	
				}
			])

func sendDellsonDialog():
	$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
		{
			"personagem": "dellson",
			"falas": [
				"Eai amigão, tudo bem?",
				"Agora quero te dar os parabéns por concluir a fase 2 com sucesso, sei que não deve ter sido uma tarefa fácil, tiveram alguns obstáculos para chegar até aqui, mas esses obstáculos serviram como lições.",
				"Espero que você tenha compreendido que um roteiro prévio é sempre útil para atingir um objetivo, mesmo que ocorram empecilhos, o guia mesmo sofrendo alterações ajuda você a se organizar e se planejar. Espero que com essa fase você tenha compreendido isso.",
				'Isso que acabei de resumir para você, no modelo de produto é chamado de “Roadmap”.'
			]
		}
	])

# Pega a espada do cenário
func getSword():
	if talkedWithSwordsman:
		hasSword = true
		$Sword.queue_free()
		$Player/Camera/CanvasLayer/Hint.sendHint("Atravesse até o próximo lado")

func _process(delta):
	$Player/Camera/CanvasLayer/WoodCountFrame/WoodCountLabel.text = " x " + str(GlobalFase2.wood)
	GlobalFase2.paralax($Player,$Swordsman)
	GlobalFase2.paralax($Player,$Sword)	
	if Input.is_action_just_pressed("V"):
		if isOnPlayerCamera:
			camera.zoom = Vector2(1.2,1.2)
			isOnPlayerCamera = false
		else:
			camera.zoom = Vector2(0.3,0.3)
			isOnPlayerCamera = true
			
	if Input.is_action_just_pressed("interact") && onSword && talkedSwords:
		GlobalFase2.hasSword = true
		$Sword.visible = false
		$Sword/Sword.monitoring = false
		$Sword.collision_layer = 16
		$Sword.collision_mask = 16
		
	if Input.is_action_just_pressed("interact") && onSwordsman:
		$Swordsman/missionBub.visible = false
		talkedSwords = true

func _on_Area2D_body_entered(body):
	if change%2 == 1:
		camera.zoom.x = 1
		camera.zoom.y = 1
		change += 1

# Ao entrar na área de ação do Swordsman, ativa o estado de ação do NPC e registra que o jogador está dentro da área
func _on_Swordsman2_area_entered(area):
	enteredSwordsmanArea = true
	$Swordsman.setState(1)

# Ao sair da área de ação do Swordsman, desativa o estado de ação do NPC e registra que o jogador saiu de dentro da área
func _on_Swordsman2_area_exited(area):
	enteredSwordsmanArea = false
	$Swordsman.setState(0)

func _ready():
	GlobalOptions.setItemsToHideOnDialog([
		$Player/Camera/CanvasLayer/Hint,
		$Player/Camera/CanvasLayer/WeaponFrame,
		$Player/Camera/CanvasLayer/WoodCountFrame
	])
	
	$Swordsman.setInteraction(1)
	$Player/Camera/CanvasLayer/Hint.sendHint("Colete madeira, construa pontes e atravesse até o outro lado")	
	$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
		{
			"personagem": "dellson",
			"falas": [
				"Jovem padawan, agora você deve continuar sua jornada, em busca do conhecimento, deve superar os obstáculos e chegar do outro lado do desfiladeiro."
			]
		},
		{
			"personagem": "jose",
			"falas": [
				"Ora, Dellson, como passerei por todas essas ilhas? Mesmo que eu conseguisse pular, não seria forte o bastante."
			]
		},
		{
			"personagem": "dellson",
			"falas": [
				"Você tem um machado e existem árvores, é só você cortá-las e construir pontes improvisadas com elas.",
				"Lembre-se de planejar o caminho e o material disponível, pense em como as árvores estão dispostas e que uma árvore rende apenas duas pontes, o improviso pode ser sua ruína.",
				"Visualizar, planejar, gerir recursos e possibilidades... Tudo isso é roadmap.",
				"Agora leve-nos para o outro lado"
			]
		}
	])

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if enteredSwordsmanArea:
			sendSwordsmanDialog()
		elif enteredSwordArea:
			$Sword.queue_free()
			hasSword = true
		elif enteredGalloArea:
			sendGalloDialog()
		elif enteredDellsonArea:
			sendDellsonDialog()
			
	return event
	
func _on_actionArea_area_entered(area):
	enteredSwordArea = true
	$Sword.setState(1)


func _on_actionArea_area_exited(area):
	enteredSwordArea = false
	$Sword.setState(0)


func _on_GalloArea_area_entered(area):
	enteredGalloArea = true
	$Gallo.setState(1)
	
func _on_GalloArea_area_exited(area):
	enteredGalloArea = false
	$Gallo.setState(0)
