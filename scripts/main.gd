extends Node3D
@onready var uv_light_izq_sup: OmniLight3D = $PivotArmario/Armario/UVLightIzqSup
@onready var uv_light_der_sup: OmniLight3D = $PivotArmario/Armario/UVLightDerSup
@onready var uv_light_izq_inf: OmniLight3D = $PivotArmario/Armario/UVLightIzqInf
@onready var uv_light_der_inf: OmniLight3D = $PivotArmario/Armario/UVLightDerInf
@onready var fan_der_inf: Node3D = $PivotArmario/Armario/FanDerInf
@onready var fan_mid_inf: Node3D = $PivotArmario/Armario/FanMidInf
@onready var fan_izq_inf: Node3D = $PivotArmario/Armario/FanIzqInf
@onready var fan_der_sup: Node3D = $PivotArmario/Armario/FanDerSup
@onready var fan_mid_sup: Node3D = $PivotArmario/Armario/FanMidSup
@onready var fan_izq_sup: Node3D = $PivotArmario/Armario/FanIzqSup
@onready var fan_izq_lat: Node3D = $PivotArmario/Armario/FanIzqLat
@onready var fan_der_lat: Node3D = $PivotArmario/Armario/FanDerLat

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

func _on_hud_vent_lat_der(toggle: bool) -> void:
	if toggle:
		fan_der_lat.fan_on()
	else:
		fan_der_lat.fan_off()

func _on_hud_vent_lat_izq(toggle: bool) -> void:
	if toggle:
		fan_izq_lat.fan_on()
	else:
		fan_izq_lat.fan_off()

func _on_hud_vent_post_inf_der(toggle: bool) -> void:
	if toggle:
		fan_der_inf.fan_on()
	else:
		fan_der_inf.fan_off()

func _on_hud_vent_post_inf_izq(toggle: bool) -> void:
	if toggle:
		fan_izq_inf.fan_on()
	else:
		fan_izq_inf.fan_off()

func _on_hud_vent_post_inf_medio(toggle: bool) -> void:
	if toggle:
		fan_mid_inf.fan_on()
	else:
		fan_mid_inf.fan_off()

func _on_hud_vent_post_sup_der(toggle: bool) -> void:
	if toggle:
		fan_der_sup.fan_on()
	else:
		fan_der_sup.fan_off()

func _on_hud_vent_post_sup_izq(toggle: bool) -> void:
	if toggle:
		fan_izq_sup.fan_on()
	else:
		fan_izq_sup.fan_off()

func _on_hud_vent_post_sup_medio(toggle: bool) -> void:
	if toggle:
		fan_mid_sup.fan_on()
	else:
		fan_mid_sup.fan_off()

#func _on_hud_vent_sup_der(toggle: bool) -> void:
	#if toggle:
		#fan_der_sup.fan_on()
	#else:
		#fan_der_sup.fan_off()
#
#func _on_hud_vent_sup_izq(toggle: bool) -> void:
	#if toggle:
		#fan_izq_sup.fan_on()
	#else:
		#fan_izq_sup.fan_off()
