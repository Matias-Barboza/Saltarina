extends Node


signal abrir_portal()

export var menu_game_over = "res://juego/menus/MenuGameOver.tscn"
export var nivel_actual = ""


var numero_llaves = 0
var contenedor_llaves
var PersonajePrincipal
var niveles_tutoriales = ["res://juego/niveles/Nivel1.tscn","res://juego/niveles/Nivel2.tscn","res://juego/niveles/Nivel5.tscn"]

onready var recarga_dash = $CapaFrente/HUD/ContenedorRecargaDash


func _ready():
	DatosPlayer.nivel_actual = nivel_actual
# warning-ignore:return_value_discarded
	DatosPlayer.connect("game_over", self, "game_over")
	PersonajePrincipal = get_node_or_null("Saltarina")
	PersonajePrincipal.connect("activar_animacion_recarga_dash", self, "activar_animacion_recarga_dash")
	contenedor_llaves = get_node_or_null("Zanahorias")
	if contenedor_llaves != null:
		numeros_llaves_nivel()
	
	if hay_que_mostrar_tutorial() != -1:
		mostrar_tutorial()



func numeros_llaves_nivel():
	numero_llaves = contenedor_llaves.get_child_count()
	DatosPlayer.contabilizar_llaves(numero_llaves)
	for zanahoria in contenedor_llaves.get_children():
		zanahoria.connect("consumida", self, "llaves_restantes")


func llaves_restantes():
	numero_llaves -= 1
	if numero_llaves == 0:
		emit_signal("abrir_portal")


func game_over():
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)


func activar_animacion_recarga_dash():
	recarga_dash.activar_animacion()


func hay_que_mostrar_tutorial():
	return niveles_tutoriales.find(DatosPlayer.nivel_actual)


func mostrar_tutorial():
	if DatosPlayer.nivel_actual == "res://juego/niveles/Nivel1.tscn" and DatosPlayer.debe_mostrar_tutorial:
		DatosPlayer.debe_mostrar_tutorial = false
		$CapaFrente/TutorialMovimiento.mostrar()

	if DatosPlayer.nivel_actual == "res://juego/niveles/Nivel2.tscn" and DatosPlayer.debe_mostrar_tutorial_salto:
		DatosPlayer.debe_mostrar_tutorial_salto = false
		$CapaFrente/TutorialMovimientoSaltar.mostrar()
	
	if DatosPlayer.nivel_actual == "res://juego/niveles/Nivel5.tscn" and DatosPlayer.debe_mostrar_tutorial_dash:
		DatosPlayer.debe_mostrar_tutorial_dash = false
		$CapaFrente/TutorialDash.mostrar()
