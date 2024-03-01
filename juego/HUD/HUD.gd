extends Control


onready var contenedor_vidas = $ContenedorVidas/Cantidad
onready var etiqueta_zanahorias_llaves = $ContenedorLlaves/Cantidad
onready var etiqueta_monedas_oro = $ContenedorMonedasOro/Cantidad
onready var etiqueta_monedas_plata = $ContenedorMonedasPlata/Cantidad
onready var etiqueta_monedas_bronce = $ContenedorMonedasBronce/Cantidad


func _ready():
# warning-ignore:return_value_discarded
	DatosPlayer.connect("actualizar_datos", self, "actualizar_hud")
	actualizar_hud()


func actualizar_hud():
	contenedor_vidas.text = "%s" % DatosPlayer.vidas
	etiqueta_monedas_oro.text = "%s" % DatosPlayer.monedas_oro
	etiqueta_monedas_plata.text = "%s" % DatosPlayer.monedas_plata
	etiqueta_monedas_bronce.text = "%s" % DatosPlayer.monedas_bronce
	etiqueta_zanahorias_llaves.text = "%s" % DatosPlayer.llaves
