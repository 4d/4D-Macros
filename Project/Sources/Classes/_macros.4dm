property title : Text
property method : Text
property highlighted : Text
property withSelection : Boolean
property lineTexts : Collection
property rgx : cs:C1710._regex
property caret : Text

Class constructor()
	
	This:C1470.title:=Get window title:C450(Frontmost window:C447)
	This:C1470.rgx:=cs:C1710._regex.new()
	
	var $t : Text
	
	// The complete method code
	GET MACRO PARAMETER:C997(Full method text:K5:17; $t)
	This:C1470.method:=$t
	
	// The selected code
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $t)
	This:C1470.highlighted:=$t
	This:C1470.withSelection:=Length:C16($t)>0
	
	This:C1470.caret:="<caret/"+">"
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function C_xx2var()
	
	cs:C1710._formatCode.new().C_2var()
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function split($useSelection : Boolean)
	
	var $target : Text
	
	If (Count parameters:C259>=1)
		
		$target:=$useSelection ? This:C1470.highlighted : This:C1470.method
		
	Else 
		
		$target:=This:C1470.withSelection ? This:C1470.highlighted : This:C1470.method
		
	End if 
	
	This:C1470.lineTexts:=Split string:C1554($target; "\r"; sk trim spaces:K86:2)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setMethodText($text : Text)
	
	SET MACRO PARAMETER:C998(Full method text:K5:17; $text)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setHighlightedText($text : Text)
	
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $text)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function paste($text : Text; $useSelection : Boolean)
	
	var $target : Integer
	
	$useSelection:=Count parameters:C259>=2 ? $useSelection : This:C1470.withSelection
	$target:=$useSelection ? Highlighted method text:K5:18 : Full method text:K5:17
	
	SET MACRO PARAMETER:C998($target; $text)
	
	If (Structure file:C489=Structure file:C489(*))
		
		return 
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
Function tokenise()
	
	var $name : Text
	var $processNumber; $mode; $origin; $state; $time; $UID : Integer
	
	For ($processNumber; 1; Count tasks:C335; 1)
		
		Try(_O_PROCESS PROPERTIES:C336($processNumber; $name; $state; $time; $mode; $UID; $origin))
		
		If ($origin=Design process:K36:9)
			
			POST EVENT:C467(Key down event:K17:4; Enter:K15:35; Tickcount:C458; 0; 0; 0; $processNumber)
			
			break
			
		End if 
	End for 
	