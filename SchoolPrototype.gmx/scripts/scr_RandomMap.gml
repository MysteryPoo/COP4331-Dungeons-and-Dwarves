/// scr_RandomMap()
var MapList;
MapList[6] = "rm_Big5";
MapList[5] = "rm_Big4";
MapList[4] = "rm_Big1";
MapList[3] = "rm_Avoidance";
MapList[2] = "rm_Maze";
MapList[1] = "rm_MontyHall";
MapList[0] = "rm_Bridge";
var _Map = irandom( array_length_1d( MapList ) - 1 );
return MapList[ _Map ];
