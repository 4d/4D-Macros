Class extends macros

Class constructor
	
	Super:C1705()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Replace declaration lines using the old “(_o_)C_xxx(...)” syntax with the new one “var ... : type”.
Function C_2var() : Boolean
	
	var $pattern : Text:="(?-msi)(?<!//)(?<!//\\s){C_}\\((?![\\w\\s]+;\\s*\\$\\{?\\d+\\}?)([^\\)]*)\\)"
	
	var $code : Text:=This:C1470.fullMethodText
	
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(604))).substitute("var \\1 : Blob")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(305))).substitute("var \\1 : Boolean")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(1488))).substitute("var \\1 : Collection")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(307))).substitute("var \\1 : Date")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(283))).substitute("var \\1 : Integer")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(1216))).substitute("var \\1 : Object")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(286))).substitute("var \\1 : Picture")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(301))).substitute("var \\1 : Pointer")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(285))).substitute("var \\1 : Real")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(284))).substitute("var \\1 : Text")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(306))).substitute("var \\1 : Time")
	$code:=This:C1470.rgx.setTarget($code).setPattern(Replace string:C233($pattern; "{C_}"; Command name:C538(1683))).substitute("var \\1")
	
	This:C1470.fullMethodText:=This:C1470.cursorOnFirstLine($code)
	
	return This:C1470.rgx.errors.length=0