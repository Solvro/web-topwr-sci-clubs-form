import "package:enum_map/enum_map.dart";
import "package:flutter/material.dart";

import "../features/bottom_nav_bar/bottom_nav_bar_icon.icons.dart";
import "../features/iparking/i_parking_icons.icons.dart";

part "nav_bar_config.g.dart";

@unmodifiableEnumMap
enum NavBarEnum {
  home(BottomNavBarIcon.home_icon, 26, "Home"),
  mapp(BottomNavBarIcon.map_icon, 20, "Map"),
  parkings(IParkingIcons.directions_car, 19, "Parkings"),
  faculties(BottomNavBarIcon.faculty_icon, 26, "Faculties"),
  sciCircles(BottomNavBarIcon.sci_circle_icon, 20, "Scientific Circles"),
  info(BottomNavBarIcon.info_icon, 20, "Info");

  const NavBarEnum(this.icon, this.size, this.label);

  final IconData icon;
  final double size;
  final String label;
}
