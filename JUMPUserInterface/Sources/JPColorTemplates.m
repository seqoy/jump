/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "JPColorTemplates.h"

@implementation JPColor(ColorTemplates)

  
+(JPColor*)lightGray {
	return [JPColor initWithGrayScale:85 opacity:100];
}   
+(JPColor*)darkGray {
	return [JPColor initWithGrayScale:170 opacity:100];
}
+(JPColor*)clearColor {
	return [JPColor initWithRed:0 G:0 B:0 opacity:0];
}  
+(JPColor*)fuschia {
	return [JPColor initWithRed:0xFF G:0x00 B:0xFF opacity:100];
}
+(JPColor*)transparent {
	return [JPColor clearColor];
}
+(JPColor*)aliceblue {
	return [JPColor initWithCSS:@"#F0F8FF"];
}
+(JPColor*)antiquewhite {
	return [JPColor initWithCSS:@"#FAEBD7"];
}
+(JPColor*)aqua {
	return [JPColor initWithCSS:@"#00FFFF"];
}
+(JPColor*)aquamarine {
	return [JPColor initWithCSS:@"#7FFFD4"];
}
+(JPColor*)azure {
	return [JPColor initWithCSS:@"#F0FFFF"];
}
+(JPColor*)beige {
	return [JPColor initWithCSS:@"#F5F5DC"];
}
+(JPColor*)bisque {
	return [JPColor initWithCSS:@"#FFE4C4"];
}
+(JPColor*)black {
	return [JPColor initWithCSS:@"#000000"];
}
+(JPColor*)blanchedalmond {
	return [JPColor initWithCSS:@"#FFEBCD"];
}
+(JPColor*)blue {
	return [JPColor initWithCSS:@"#0000FF"];
}
+(JPColor*)blueviolet {
	return [JPColor initWithCSS:@"#8A2BE2"];
}
+(JPColor*)brown {
	return [JPColor initWithCSS:@"#A52A2A"];
}
+(JPColor*)burlywood {
	return [JPColor initWithCSS:@"#DEB887"];
}
+(JPColor*)cadetblue {
	return [JPColor initWithCSS:@"#5F9EA0"];
}
+(JPColor*)chartreuse {
	return [JPColor initWithCSS:@"#7FFF00"];
}
+(JPColor*)chocolate {
	return [JPColor initWithCSS:@"#D2691E"];
}
+(JPColor*)coral {
	return [JPColor initWithCSS:@"#FF7F50"];
}
+(JPColor*)cornflowerblue {
	return [JPColor initWithCSS:@"#6495ED"];
}
+(JPColor*)cornsilk {
	return [JPColor initWithCSS:@"#FFF8DC"];
}
+(JPColor*)crimson {
	return [JPColor initWithCSS:@"#DC143C"];
}
+(JPColor*)cyan {
	return [JPColor initWithCSS:@"#00FFFF"];
}
+(JPColor*)darkblue {
	return [JPColor initWithCSS:@"#00008B"];
}
+(JPColor*)darkcyan {
	return [JPColor initWithCSS:@"#008B8B"];
}
+(JPColor*)darkgoldenrod {
	return [JPColor initWithCSS:@"#B8860B"];
}
+(JPColor*)darkgray {
	return [JPColor initWithCSS:@"#A9A9A9"];
}
+(JPColor*)darkgreen {
	return [JPColor initWithCSS:@"#006400"];
}
+(JPColor*)darkgrey {
	return [JPColor initWithCSS:@"#A9A9A9"];
}
+(JPColor*)darkkhaki {
	return [JPColor initWithCSS:@"#BDB76B"];
}
+(JPColor*)darkmagenta {
	return [JPColor initWithCSS:@"#8B008B"];
}
+(JPColor*)darkolivegreen {
	return [JPColor initWithCSS:@"#556B2F"];
}
+(JPColor*)darkorange {
	return [JPColor initWithCSS:@"#FF8C00"];
}
+(JPColor*)darkorchid {
	return [JPColor initWithCSS:@"#9932CC"];
}
+(JPColor*)darkred {
	return [JPColor initWithCSS:@"#8B0000"];
}
+(JPColor*)darksalmon {
	return [JPColor initWithCSS:@"#E9967A"];
}
+(JPColor*)darkseagreen {
	return [JPColor initWithCSS:@"#8FBC8F"];
}
+(JPColor*)darkslateblue {
	return [JPColor initWithCSS:@"#483D8B"];
}
+(JPColor*)darkslategray {
	return [JPColor initWithCSS:@"#2F4F4F"];
}
+(JPColor*)darkslategrey {
	return [JPColor initWithCSS:@"#2F4F4F"];
}
+(JPColor*)darkturquoise {
	return [JPColor initWithCSS:@"#00CED1"];
}
+(JPColor*)darkviolet {
	return [JPColor initWithCSS:@"#9400D3"];
}
+(JPColor*)deeppink {
	return [JPColor initWithCSS:@"#FF1493"];
}
+(JPColor*)deepskyblue {
	return [JPColor initWithCSS:@"#00BFFF"];
}
+(JPColor*)dimgray {
	return [JPColor initWithCSS:@"#696969"];
}
+(JPColor*)dimgrey {
	return [JPColor initWithCSS:@"#696969"];
}
+(JPColor*)dodgerblue {
	return [JPColor initWithCSS:@"#1E90FF"];
}
+(JPColor*)firebrick {
	return [JPColor initWithCSS:@"#B22222"];
}
+(JPColor*)floralwhite {
	return [JPColor initWithCSS:@"#FFFAF0"];
}
+(JPColor*)forestgreen {
	return [JPColor initWithCSS:@"#228B22"];
}
+(JPColor*)fuchsia {
	return [JPColor initWithCSS:@"#FF00FF"];
}
+(JPColor*)gainsboro {
	return [JPColor initWithCSS:@"#DCDCDC"];
}
+(JPColor*)ghostwhite {
	return [JPColor initWithCSS:@"#F8F8FF"];
}
+(JPColor*)gold {
	return [JPColor initWithCSS:@"#FFD700"];
}
+(JPColor*)goldenrod {
	return [JPColor initWithCSS:@"#DAA520"];
}
+(JPColor*)gray {
	return [JPColor initWithCSS:@"#808080"];
}
+(JPColor*)green {
	return [JPColor initWithCSS:@"#008000"];
}
+(JPColor*)greenyellow {
	return [JPColor initWithCSS:@"#ADFF2F"];
}
+(JPColor*)grey {
	return [JPColor initWithCSS:@"#808080"];
}
+(JPColor*)honeydew {
	return [JPColor initWithCSS:@"#F0FFF0"];
}
+(JPColor*)hotpink {
	return [JPColor initWithCSS:@"#FF69B4"];
}
+(JPColor*)indianred {
	return [JPColor initWithCSS:@"#CD5C5C"];
}
+(JPColor*)indigo {
	return [JPColor initWithCSS:@"#4B0082"];
}
+(JPColor*)ivory {
	return [JPColor initWithCSS:@"#FFFFF0"];
}
+(JPColor*)khaki {
	return [JPColor initWithCSS:@"#F0E68C"];
}
+(JPColor*)lavender {
	return [JPColor initWithCSS:@"#E6E6FA"];
}
+(JPColor*)lavenderblush {
	return [JPColor initWithCSS:@"#FFF0F5"];
}
+(JPColor*)lawngreen {
	return [JPColor initWithCSS:@"#7CFC00"];
}
+(JPColor*)lemonchiffon {
	return [JPColor initWithCSS:@"#FFFACD"];
}
+(JPColor*)lightblue {
	return [JPColor initWithCSS:@"#ADD8E6"];
}
+(JPColor*)lightcoral {
	return [JPColor initWithCSS:@"#F08080"];
}
+(JPColor*)lightcyan {
	return [JPColor initWithCSS:@"#E0FFFF"];
}
+(JPColor*)lightgoldenrodyellow {
	return [JPColor initWithCSS:@"#FAFAD2"];
}
+(JPColor*)lightgray {
	return [JPColor initWithCSS:@"#D3D3D3"];
}
+(JPColor*)lightgreen {
	return [JPColor initWithCSS:@"#90EE90"];
}
+(JPColor*)lightgrey {
	return [JPColor initWithCSS:@"#D3D3D3"];
}
+(JPColor*)lightpink {
	return [JPColor initWithCSS:@"#FFB6C1"];
}
+(JPColor*)lightsalmon {
	return [JPColor initWithCSS:@"#FFA07A"];
}
+(JPColor*)lightseagreen {
	return [JPColor initWithCSS:@"#20B2AA"];
}
+(JPColor*)lightskyblue {
	return [JPColor initWithCSS:@"#87CEFA"];
}
+(JPColor*)lightslategray {
	return [JPColor initWithCSS:@"#778899"];
}
+(JPColor*)lightslategrey {
	return [JPColor initWithCSS:@"#778899"];
}
+(JPColor*)lightsteelblue {
	return [JPColor initWithCSS:@"#B0C4DE"];
}
+(JPColor*)lightyellow {
	return [JPColor initWithCSS:@"#FFFFE0"];
}
+(JPColor*)lime {
	return [JPColor initWithCSS:@"#00FF00"];
}
+(JPColor*)limegreen {
	return [JPColor initWithCSS:@"#32CD32"];
}
+(JPColor*)linen {
	return [JPColor initWithCSS:@"#FAF0E6"];
}
+(JPColor*)magenta {
	return [JPColor initWithCSS:@"#FF00FF"];
}
+(JPColor*)maroon {
	return [JPColor initWithCSS:@"#800000"];
}
+(JPColor*)mediumaquamarine {
	return [JPColor initWithCSS:@"#66CDAA"];
}
+(JPColor*)mediumblue {
	return [JPColor initWithCSS:@"#0000CD"];
}
+(JPColor*)mediumorchid {
	return [JPColor initWithCSS:@"#BA55D3"];
}
+(JPColor*)mediumpurple {
	return [JPColor initWithCSS:@"#9370DB"];
}
+(JPColor*)mediumseagreen {
	return [JPColor initWithCSS:@"#3CB371"];
}
+(JPColor*)mediumslateblue {
	return [JPColor initWithCSS:@"#7B68EE"];
}
+(JPColor*)mediumspringgreen {
	return [JPColor initWithCSS:@"#00FA9A"];
}
+(JPColor*)mediumturquoise {
	return [JPColor initWithCSS:@"#48D1CC"];
}
+(JPColor*)mediumvioletred {
	return [JPColor initWithCSS:@"#C71585"];
}
+(JPColor*)midnightblue {
	return [JPColor initWithCSS:@"#191970"];
}
+(JPColor*)mintcream {
	return [JPColor initWithCSS:@"#F5FFFA"];
}
+(JPColor*)mistyrose {
	return [JPColor initWithCSS:@"#FFE4E1"];
}
+(JPColor*)moccasin {
	return [JPColor initWithCSS:@"#FFE4B5"];
}
+(JPColor*)navajowhite {
	return [JPColor initWithCSS:@"#FFDEAD"];
}
+(JPColor*)navy {
	return [JPColor initWithCSS:@"#000080"];
}
+(JPColor*)oldlace {
	return [JPColor initWithCSS:@"#FDF5E6"];
}
+(JPColor*)olive {
	return [JPColor initWithCSS:@"#808000"];
}
+(JPColor*)olivedrab {
	return [JPColor initWithCSS:@"#6B8E23"];
}
+(JPColor*)orange {
	return [JPColor initWithCSS:@"#FFA500"];
}
+(JPColor*)orangered {
	return [JPColor initWithCSS:@"#FF4500"];
}
+(JPColor*)orchid {
	return [JPColor initWithCSS:@"#DA70D6"];
}
+(JPColor*)palegoldenrod {
	return [JPColor initWithCSS:@"#EEE8AA"];
}
+(JPColor*)palegreen {
	return [JPColor initWithCSS:@"#98FB98"];
}
+(JPColor*)paleturquoise {
	return [JPColor initWithCSS:@"#AFEEEE"];
}
+(JPColor*)palevioletred {
	return [JPColor initWithCSS:@"#DB7093"];
}
+(JPColor*)papayawhip {
	return [JPColor initWithCSS:@"#FFEFD5"];
}
+(JPColor*)peachpuff {
	return [JPColor initWithCSS:@"#FFDAB9"];
}
+(JPColor*)peru {
	return [JPColor initWithCSS:@"#CD853F"];
}
+(JPColor*)pink {
	return [JPColor initWithCSS:@"#FFC0CB"];
}
+(JPColor*)plum {
	return [JPColor initWithCSS:@"#DDA0DD"];
}
+(JPColor*)powderblue {
	return [JPColor initWithCSS:@"#B0E0E6"];
}
+(JPColor*)purple {
	return [JPColor initWithCSS:@"#800080"];
}
+(JPColor*)red {
	return [JPColor initWithCSS:@"#FF0000"];
}
+(JPColor*)rosybrown {
	return [JPColor initWithCSS:@"#BC8F8F"];
}
+(JPColor*)royalblue {
	return [JPColor initWithCSS:@"#4169E1"];
}
+(JPColor*)saddlebrown {
	return [JPColor initWithCSS:@"#8B4513"];
}
+(JPColor*)salmon {
	return [JPColor initWithCSS:@"#FA8072"];
}
+(JPColor*)sandybrown {
	return [JPColor initWithCSS:@"#F4A460"];
}
+(JPColor*)seagreen {
	return [JPColor initWithCSS:@"#2E8B57"];
}
+(JPColor*)seashell {
	return [JPColor initWithCSS:@"#FFF5EE"];
}
+(JPColor*)sienna {
	return [JPColor initWithCSS:@"#A0522D"];
}
+(JPColor*)silver {
	return [JPColor initWithCSS:@"#C0C0C0"];
}
+(JPColor*)skyblue {
	return [JPColor initWithCSS:@"#87CEEB"];
}
+(JPColor*)slateblue {
	return [JPColor initWithCSS:@"#6A5ACD"];
}
+(JPColor*)slategray {
	return [JPColor initWithCSS:@"#708090"];
}
+(JPColor*)slategrey {
	return [JPColor initWithCSS:@"#708090"];
}
+(JPColor*)snow {
	return [JPColor initWithCSS:@"#FFFAFA"];
}
+(JPColor*)springgreen {
	return [JPColor initWithCSS:@"#00FF7F"];
}
+(JPColor*)steelblue {
	return [JPColor initWithCSS:@"#4682B4"];
}
+(JPColor*)tan {
	return [JPColor initWithCSS:@"#D2B48C"];
}
+(JPColor*)teal {
	return [JPColor initWithCSS:@"#008080"];
}
+(JPColor*)thistle {
	return [JPColor initWithCSS:@"#D8BFD8"];
}
+(JPColor*)tomato {
	return [JPColor initWithCSS:@"#FF6347"];
}
+(JPColor*)turquoise {
	return [JPColor initWithCSS:@"#40E0D0"];
}
+(JPColor*)violet {
	return [JPColor initWithCSS:@"#EE82EE"];
}
+(JPColor*)wheat {
	return [JPColor initWithCSS:@"#F5DEB3"];
}
+(JPColor*)white {
	return [JPColor initWithCSS:@"#FFFFFF"];
}
+(JPColor*)whitesmoke {
	return [JPColor initWithCSS:@"#F5F5F5"];
}
+(JPColor*)yellow {
	return [JPColor initWithCSS:@"#FFFF00"];
}
+(JPColor*)yellowgreen {
	return [JPColor initWithCSS:@"#9ACD32"];
}


@end
