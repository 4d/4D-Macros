//%attributes = {"invisible":true,"shared":true}
#DECLARE($action : Text)

var $success : Boolean
var $macro : cs:C1710.macros:=cs:C1710.macros.new()

If (OB Instance of:C1731($macro[$action]; 4D:C1709.Function))
	
	$success:=$macro[$action]()
	
End if 

If (Not:C34($success))  // Error
	
	BEEP:C151
	
End if 