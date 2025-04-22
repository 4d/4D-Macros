property title:=Get window title:C450(Frontmost window:C447)

// 📦 Delegates
property rgx:=cs:C1710._regex.new()

//⚠️ Make a concatenation to prevent 4D from interpreting the ‘caret’ tag in this code
property caret:="<caret/"+">"

property _highlighted : Boolean

Class constructor()
	
	var $t : Text
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $t)
	This:C1470._highlighted:=Length:C16($t)>0
	
	
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
	
	// MARK:-[MACROS]
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function C_xx2var() : Boolean
	
	return cs:C1710._modernize.new().C_2var()
	
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
	
	$code:=$code || This:C1470.fullMethodText
	
	return Replace string:C233($code; "\r"; This:C1470.caret+"\r"; 1)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Place cursor at the end of the first line
Function cursorAtEnd($code : Text; $newLineAtTheEnd : Boolean) : Text
	
	$code:=$code || This:C1470.fullMethodText
	
	If ($newLineAtTheEnd)
		
		$code:=This:C1470.newLineAtTheEnd($code)
		
	End if 
	
	return $code+This:C1470.caret
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// If necessary, add an empty line at the end of the method
Function newLineAtTheEnd($code : Text) : Text
	
	$code:=$code || This:C1470.fullMethodText
	
	If ($code[[Length:C16($code)]]#"\r")
		
		$code+="\r"
		
	End if 
	
	return $code
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Force tokenisation of the foreground method
Function tokenise()
	
	var $name : Text
	var $process; $mode; $origin; $state; $time; $UID : Integer
	
	For ($process; 1; Count tasks:C335; 1)
		
		If (Process info:C1843($process).type=Design process:K36:9)
			
			POST EVENT:C467(Key down event:K17:4; Enter:K15:35; Tickcount:C458; 0; 0; 0; $process)
			
			break
			
		End if 
	End for 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
/*
Launch the “test_macro” method of the host database if it exists.
If not, suggest to create it.
*/
Function test_macro() : Boolean
	
	var $method:="test_macro"
	
	ARRAY TEXT:C222($_t; 0)
	METHOD GET NAMES:C1166($_t; $method; *)
	
	If (Size of array:C274($_t)>0)
		
		return Formula from string:C1601($method; sk execute in host database:K88:5).call()
		
	Else 
		
		CONFIRM:C162("The \""+$method+"\" method doesn't exist.\r\rWould you like to create it?")
		
		If (Bool:C1537(OK))
			
			METHOD SET CODE:C1194($method; File:C1566("/RESOURCES/test_macro.4dm").getText(); *)
			METHOD OPEN PATH:C1213($method; 12; *)
			
			return True:C214
			
		End if 
	End if 
	