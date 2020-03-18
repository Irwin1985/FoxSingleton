*====================================================================
* FoxSingleton
*====================================================================
Define Class Singleton As Custom
	Hidden Context
	#Define CLIENT_CLASS "context"
*====================================================================
	Function Init(tcContext As String) As void
		This.Context = tcContext
		Try
			=Removeproperty(_Screen, CLIENT_CLASS)
		Endtry
		_Screen.AddProperty(This.Context, Createobject(This.Context))
	Endfunc
*====================================================================
	Function This_Access(tcAttribute As String) As Object
		Local loReference As Object
		If Inlist(Lower(tcAttribute), CLIENT_CLASS)
			loReference = This
		Else
			loReference = Evaluate("_Screen." + This.Context)
		Endif
		Return loReference
	Endfunc
Enddefine