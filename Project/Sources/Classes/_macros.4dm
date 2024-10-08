property title : Text
property rgx : cs:C1710._regex
property caret : Text
property _highlighted : Boolean

Class constructor()
	
	This:C1470.title:=Get window title:C450(Frontmost window:C447)
	This:C1470.rgx:=cs:C1710._regex.new()
	
	var $t : Text
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $t)
	This:C1470._highlighted:=Length:C16($t)>0
	
	This:C1470.caret:="<caret/"+">"
	
	// MARK:- [IN/OUT]
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get fullMethodText() : Text
	
	var $t : Text
	
	GET MACRO PARAMETER:C997(Full method text:K5:17; $t)
	
	return $t
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set fullMethodText($code : Text)
	
	SET MACRO PARAMETER:C998(Full method text:K5:17; $code)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setMethodText($text : Text)
	
	SET MACRO PARAMETER:C998(Full method text:K5:17; $text)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get highlightedMethodText() : Text
	
	var $t : Text
	
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $t)
	
	return $t
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set highlightedMethodText($code : Text)
	
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $code)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setHighlightedText($text : Text)
	
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $text)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get code() : Text
	
	var $code : Text
	
	GET MACRO PARAMETER:C997(This:C1470._highlighted ? Highlighted method text:K5:18 : Full method text:K5:17; $code)
	
	return $code
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set code($code : Text)
	
	SET MACRO PARAMETER:C998(This:C1470._highlighted ? Highlighted method text:K5:18 : Full method text:K5:17; $code)
	
	// MARK:-[
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function C_xx2var()
	
	cs:C1710._formatCode.new().C_2var()
	
	// MARK:- 
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Set code and force tokenisation
Function paste($text : Text; $useSelection : Boolean)
	
	$useSelection:=Count parameters:C259>=2 ? $useSelection : This:C1470._highlighted
	SET MACRO PARAMETER:C998($useSelection ? Highlighted method text:K5:18 : Full method text:K5:17; $text)
	
	This:C1470.tokenise()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function split($useSelection : Boolean) : Collection
	
	$useSelection:=Count parameters:C259>=2 ? $useSelection : This:C1470._highlighted
	
	return Split string:C1554($useSelection ? This:C1470.highlightedMethodText : This:C1470.fullMethodText; "\r"; sk trim spaces:K86:2)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Place cursor at the end of the first line
Function cursorOnFirstLine($code : Text) : Text
	
	return Replace string:C233($code; "\r"; This:C1470.caret+"\r"; 1)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Force tokenisation of the foreground method
Function tokenise()
	
	var $name : Text
	var $process; $mode; $origin; $state; $time; $UID : Integer
	
	For ($process; 1; Count tasks:C335; 1)
		
		Try(_O_PROCESS PROPERTIES:C336($process; $name; $state; $time; $mode; $UID; $origin))
		
		If ($origin=Design process:K36:9)
			
			POST EVENT:C467(Key down event:K17:4; Enter:K15:35; Tickcount:C458; 0; 0; 0; $process)
			
			break
			
		End if 
	End for 
	