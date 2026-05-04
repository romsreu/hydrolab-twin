extends Node3D

@onready var uv_light_izq_sup: OmniLight3D = $PivotArmario/Armario/UVLightIzqSup
@onready var uv_light_der_sup: OmniLight3D = $PivotArmario/Armario/UVLightDerSup
@onready var uv_light_izq_inf: OmniLight3D = $PivotArmario/Armario/UVLightIzqInf
@onready var uv_light_der_inf: OmniLight3D = $PivotArmario/Armario/UVLightDerInf


func _on_hud_uv_sup_izq(toggle: bool) -> void:
	if toggle:
		uv_light_izq_sup.show()
	else:
		uv_light_izq_sup.hide()


func _on_hud_uv_sup_der(toggle: bool) -> void:
	if toggle:
		uv_light_der_sup.show()
	else:
		uv_light_der_sup.hide()


func _on_hud_uv_inf_izq(toggle: bool) -> void:
	if toggle:
		uv_light_izq_inf.show()
	else:
		uv_light_izq_inf.hide()


func _on_hud_uv_inf_der(toggle: bool) -> void:
	if toggle:
		uv_light_der_inf.show()
	else:
		uv_light_der_inf.hide()
