extends Node


signal actualizar_datos()
signal game_over()


var vidas = 3
var llaves = 0
var monedas_oro = 0
var monedas_plata = 0
var monedas_bronce = 0
var nivel_actual = ""
var puntaje = 0
var debe_mostrar_tutorial = true
var debe_mostrar_tutorial_salto = true
var debe_mostrar_tutorial_dash  = true

func reset():
	vidas = 3
	monedas_oro = 0
	monedas_plata = 0
	monedas_bronce = 0


func generar_puntaje():
	var valor_oro = monedas_oro * 10
	var valor_plata = monedas_plata * 5
	var valor_bronce = monedas_bronce * 2
	puntaje = valor_oro + valor_plata + valor_bronce
	
	return puntaje


func restar_vidas():
	vidas -= 1
	if vidas == 0:
		emit_signal("game_over")
	
	emit_signal("actualizar_datos")


func restar_llaves():
	llaves -= 1
	emit_signal("actualizar_datos")


func contabilizar_llaves(valor):
	llaves = valor
	emit_signal("actualizar_datos")


func sumar_moneda(moneda):
	match moneda:
		"bronce":
			monedas_bronce += 1
		"plata":
			monedas_plata += 1
		"oro":
			monedas_oro += 1
		_:
			print("Error")
	
	emit_signal("actualizar_datos")
