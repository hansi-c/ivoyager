# huds_manager.gd
# This file is part of I, Voyager
# https://ivoyager.dev
# *****************************************************************************
# Copyright (c) 2017-2021 Charlie Whitfield
# "I, Voyager" is a registered trademark of Charlie Whitfield
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# *****************************************************************************
# Manages visibility of HUD elements.

extends Node
class_name HUDsManager

signal show_huds_changed()

# public - read-only except at project init
var show_orbits := true
var show_names := true # exclusive w/ show_symbols
var show_symbols := false # exclusive w/ show_symbols

const PERSIST_AS_PROCEDURAL_OBJECT := false
const PERSIST_PROPERTIES := ["show_orbits", "show_names", "show_symbols"]


func set_show_orbits(is_show: bool) -> void:
	show_orbits = is_show
	emit_signal("show_huds_changed")

func set_show_names(is_show: bool) -> void:
	show_names = is_show
	if is_show and show_symbols:
		set_show_symbols(false)
	else:
		emit_signal("show_huds_changed")

func set_show_symbols(is_show: bool) -> void:
	show_symbols = is_show
	if is_show and show_names:
		set_show_names(false)
	else:
		emit_signal("show_huds_changed")

func project_init() -> void:
	Global.connect("gui_refresh_requested", self, "_gui_refresh")

func _gui_refresh() -> void:
	emit_signal("show_huds_changed")

