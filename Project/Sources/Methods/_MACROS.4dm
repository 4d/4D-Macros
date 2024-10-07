//%attributes = {"invisible":true,"shared":true}
#DECLARE($action : Text)

var $macro : cs:C1710._macros:=cs:C1710._macros.new()
var $success : Boolean:=True:C214

Case of 
		
		//______________________________________________________
	: (OB Instance of:C1731($macro[$action]; 4D:C1709.Function))
		
		$macro[$action]()
		
		//______________________________________________________
	Else 
		
		$success:=False:C215
		
		//______________________________________________________
End case 

If (Not:C34($success))  //error
	
	BEEP:C151
	
End if 