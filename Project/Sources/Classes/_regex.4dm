property success : Boolean  // True = search has found an occurrence; Otherwise, False.
property matches : Collection  // All matches found: collection of objects {index, string, position, length}.
property searchTime : Integer
property errors : Collection

property _target : Text:=""
property _pattern : Text:=""
property _startTime : Integer

Class constructor($target; $pattern : Text)
	
	This:C1470._init()
	
	If (Count parameters:C259>=1)
		
		This:C1470.target:=$target
		
		If (Count parameters:C259>=2)
			
			This:C1470.pattern:=$pattern
			
		End if 
	End if 
	
	// MARK:-
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get target() : Text
	
	return This:C1470._target
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set target($target)
	
	This:C1470._setTarget($target)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Sets the string where will be perform the search.
	// Could be a text or a disk file
Function setTarget($target) : cs:C1710._regex
	
	This:C1470._setTarget($target)
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _setTarget($target)
	
	Case of 
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is text:K8:3)
			
			This:C1470._target:=$target
			
			//…………………………………………………………………………………………
		: (Value type:C1509($target)=Is object:K8:27)
			
			If (OB Class:C1730($target).name="File")
				
				If ($target.exists)
					
					This:C1470._target:=$target.getText()
					
				Else 
					
					// File not found.
					This:C1470._pushError(Current method name:C684; -43; "File not found.")
					
				End if 
				
			Else 
				
				// Argument types are incompatible.
				This:C1470._pushError(Current method name:C684; 54; "The \"target\" object is not a 4D.File.")
				
			End if 
			
			//…………………………………………………………………………………………
			
		: (Value type:C1509($target)=Is BLOB:K8:12)
			
			This:C1470._target:=Convert to text:C1012($target; "UTF-8")
			This:C1470.success:=Bool:C1537(OK)
			
			//…………………………………………………………………………………………
		Else 
			
			// Argument types are incompatible.
			This:C1470._pushError(Current method name:C684; 54; "The \"target\" argument  must be Text, a Blob or 4D.File.")
			
			//…………………………………………………………………………………………
	End case 
	
	// MARK:-
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get pattern() : Text
	
	return This:C1470._pattern
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set pattern($pattern : Text)
	
	This:C1470._pattern:=$pattern
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Sets the regular expression to use.
Function setPattern($pattern : Text) : cs:C1710._regex
	
	This:C1470._pattern:=$pattern
	
	return This:C1470
	
	// MARK:-
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns True if the pattern matches the target.
	// .match({start: Integer ;}{all : Boolean}) : Boolean
Function match($start; $all : Boolean) : Boolean
	
	var $i; $index : Integer
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	If (Count parameters:C259>=1)
		
		If (Value type:C1509($start)=Is boolean:K8:9)
			
			$all:=$start
			$start:=1
			
		Else 
			
			$start:=Num:C11($start)
			
		End if 
		
	Else 
		
		$start:=1
		
	End if 
	
	This:C1470._init()
	
	Repeat 
		
		var $match : Boolean:=Try(Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $pos; $len))
		
		If (Last errors:C1799.length=0)
			
			If ($match)
				
				This:C1470.success:=True:C214
				
				For ($i; 0; Size of array:C274($pos); 1)
					
					This:C1470.matches.push({\
						index: $index; \
						data: Substring:C12(This:C1470._target; $pos{$i}; $len{$i}); \
						position: $pos{$i}; \
						length: $len{$i}\
						})
					
					If ($len{$i}=0)
						
						$match:=($i>0)
						
						If ($match)
							
							$match:=($pos{$i}#$pos{$i-1})
							
						End if 
					End if 
					
					If ($pos{$i}>0)
						
						$start:=$pos{$i}+$len{$i}
						
					End if 
				End for 
				
				If (Not:C34($all))
					
					break  // Stop after the first match
					
				End if 
			End if 
			
			$index+=1
			
		Else 
			
			This:C1470._pushError(Current method name:C684; Last errors:C1799[0].errCode; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			
			return 
			
		End if 
	Until (Not:C34($match))
	
	This:C1470.searchTime:=This:C1470._elapsedTime()
	
	return This:C1470.success
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns a collection of extracted substrings
	// .extract({groups: Integer}) : Collection
	// .extract({groups: Text}) : Collection
	// .extract({groups: Collection}) : Collection
Function extract($groups) : Collection
	
	var $i; $index; $indx : Integer
	
	This:C1470._init()
	
	Case of 
			
			//___________________________________
		: ($groups=Null:C1517)
			
			$groups:=[]
			
			//___________________________________
		: (Value type:C1509($groups)=Is longint:K8:6)\
			 | (Value type:C1509($groups)=Is real:K8:4)
			
			$groups:=[String:C10($groups)]
			
			//___________________________________
		: (Value type:C1509($groups)=Is text:K8:3)
			
			$groups:=Split string:C1554($groups; " ")
			
			//___________________________________
		: (Value type:C1509($groups)=Is collection:K8:32)
			
			// Transform into text if necessary
			var $v
			
			For each ($v; $groups)
				
				$groups[$i]:=String:C10($v)
				$i+=1
				
			End for each 
			
			//___________________________________
		Else 
			
			// Argument types are incompatible.
			This:C1470._pushError(Current method name:C684; 54; "The \"groups\" argument must be an integer, a text or a collection.")
			
			return 
			
			//___________________________________
	End case 
	
	ARRAY LONGINT:C221($len; 0)
	ARRAY LONGINT:C221($pos; 0)
	
	var $start : Integer:=1
	
	Repeat 
		
		var $match : Boolean:=Try(Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $pos; $len))
		
		If (Last errors:C1799.length=0)
			
			If ($match)
				
				This:C1470.success:=True:C214
				
				var $current : Integer:=0
				
				For ($i; 0; Size of array:C274($pos); 1)
					
					var $groupIndex : Integer:=$groups.length>0 ? $groups.indexOf(String:C10($current)) : $current
					
					If ($groupIndex>=0)
						
						If ($i>0)\
							 | ($index=0)
							
							If (This:C1470.matches.query("data = :1 & pos = :2"; Substring:C12(This:C1470._target; $pos{$i}; $len{$i}); $pos{$i}).pop()=Null:C1517)
								
								This:C1470.matches.push({\
									index: $indx; \
									data: Substring:C12(This:C1470._target; $pos{$i}; $len{$i}); \
									pos: $pos{$i}; \
									len: $len{$i}\
									})
								
								$indx+=1
								
							End if 
						End if 
					End if 
					
					If ($pos{$i}>0)
						
						$start:=$pos{$i}+$len{$i}
						
					End if 
					
					$current+=1
					
				End for 
			End if 
			
		Else 
			
			This:C1470._pushError(Current method name:C684; Last errors:C1799[0].errCode; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			
			return 
			
		End if 
		
		$index+=1
		
	Until (Not:C34($match))
	
	This:C1470.searchTime:=This:C1470._elapsedTime()
	
	return This:C1470.matches.extract("data")
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Replace matching substrings with the replacement text.
Function substitute($replacement : Text; $count : Integer; $position : Integer) : Text
	
	var $replacedText : Text
	var $i; $index : Integer
	var $o : Object
	
	ARRAY LONGINT:C221($len; 0)
	ARRAY LONGINT:C221($pos; 0)
	
	// TODO:Manage count and position
	
	var $backup : Text:=$replacement
	
	This:C1470._init()
	
	var $start : Integer:=1
	
	Repeat 
		
		var $match : Boolean:=Try(Match regex:C1019(This:C1470._pattern; This:C1470._target; $start; $pos; $len))
		
		If (Last errors:C1799.length=0)
			
			If ($match)
				
				var $sub : Integer:=0
				
				For ($i; 0; Size of array:C274($pos); 1)
					
					If ($pos{$i}>0)
						
						$start:=$pos{$i}+$len{$i}
						
					End if 
					
					If ($len{$i}=0)
						
						$match:=($i>0)
						
						If ($match)
							
							$match:=($pos{$i}#$pos{$i-1})
							
						End if 
					End if 
					
					If ($match)
						
						This:C1470.matches.push({\
							index: $index; \
							data: Substring:C12(This:C1470._target; $pos{$i}; $len{$i}); \
							pos: $pos{$i}; \
							len: $len{$i}; \
							_subpattern: $sub\
							})
						
						$sub+=1
						$index+=1
						
					Else 
						
						break
						
					End if 
				End for 
			End if 
			
		Else 
			
			This:C1470._pushError(Current method name:C684; Last errors:C1799[0].errCode; "Error while parsing pattern \""+This:C1470._pattern+"\"")
			
			return 
			
		End if 
	Until (Not:C34($match))
	
	$replacedText:=This:C1470._target
	
	If (This:C1470.matches.length>0)
		
		$index:=This:C1470.matches.length-1
		
		Repeat 
			
			$o:=This:C1470.matches[$index]
			
			If ($o._subpattern#0)
				
				var $subexpression : Text:="\\"+String:C10($o._subpattern)
				
				If (Position:C15($subexpression; $replacement)>0)
					
					$replacement:=Replace string:C233($replacement; $subexpression; $o.data)
					
				End if 
				
			Else 
				
				$replacedText:=Delete string:C232($replacedText; $o.pos; $o.len)
				$replacedText:=Insert string:C231($replacedText; $replacement; $o.pos)
				$replacement:=$backup
				
			End if 
			
			$index-=1
			
		Until ($index=-1)
		
		For each ($o; This:C1470.matches)
			
			OB REMOVE:C1226($o; "_subpattern")
			
		End for each 
	End if 
	
	This:C1470.searchTime:=This:C1470._elapsedTime()
	
	return $replacedText
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns True if the pattern matches at the start of the string
Function lookingAt() : Boolean
	
	This:C1470._init()
	
	var $match : Boolean:=Try(Match regex:C1019(This:C1470._pattern; This:C1470._target; 1; *))
	This:C1470.success:=(Last errors:C1799.length=0) && ($match)
	
	This:C1470.searchTime:=This:C1470._elapsedTime()
	
	return This:C1470.success
	
	// MARK:-
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get lastError() : Object
	
	If (This:C1470.errorsnull)\
		 && (This:C1470.errors.length>0)
		
		return This:C1470.errors[This:C1470.errors.length-1]
		
	End if 
	
	// MARK:-[INTEGRATED USEFUL REGEX]
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Returns the number of words in a string
Function countWords($target : Text) : Integer
	
	This:C1470.target:=$target || This:C1470.target
	This:C1470.pattern:="(?mi-s)((?:[^[:punct:]\\$\\s[:cntrl:]'‘’]+[’'][^[:punct:]\\$\\s[:cntrl:]'‘’]+)|[^[:punct:]\\s[:cntrl:]'‘’\\$]+)"
	
	return This:C1470.extract().length
	
	// === === === === === === === === === === === === === === === === === === === === === === === === === ===
	// Validating an e-mail address
Function validateMail($target : Text) : Boolean
	
	This:C1470.target:=$target || This:C1470.target
	This:C1470.pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,}"+")+)$"
	
	return This:C1470.match()
	
	// MARK:-
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _init() : Integer
	
	This:C1470.success:=False:C215
	This:C1470.errors:=[]
	This:C1470.matches:=[]
	This:C1470._startTime:=Milliseconds:C459
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _pushError($method : Text; $code : Integer; $desc : Text)
	
	This:C1470.success:=False:C215
	
	This:C1470.errors.push({\
		code: $code; \
		method: $method; \
		desc: $desc\
		})
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _elapsedTime() : Integer
	
	return Milliseconds:C459-This:C1470._startTime