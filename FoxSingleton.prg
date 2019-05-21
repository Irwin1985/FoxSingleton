Define Class ClaseUnica As Session
	Hidden Function obtenerInstanciaSingleton
		If !Pemstatus(_Screen, "oClaseUnicaSingleton", 5)
			=AddProperty(_Screen, "oClaseUnicaSingleton", Createobject("ClaseUnicaSingleton"))
		Else &&!Pemstatus(_Screen, "oClaseUnicaSingleton", 5)
		Endif &&!Pemstatus(_Screen, "oClaseUnicaSingleton", 5)
		If Type("_SCREEN.oClaseUnicaSingleton") == "O" And "CLASEUNICASINGLETON"$Upper(_Screen.oClaseUnicaSingleton.BaseClass)
			Return _Screen.oClaseUnicaSingleton
		Else &&Type("_SCREEN.oClaseUnicaSingleton") == "O" And "CLASEUNICASINGLETON"$Upper(_Screen.oClaseUnicaSingleton.BaseClass)
			Throw "Could not create the singleton class."
		Endif &&Type("_SCREEN.oClaseUnicaSingleton") == "O" And "CLASEUNICASINGLETON"$Upper(_Screen.oClaseUnicaSingleton.BaseClass)
	Endfunc

	Procedure getPropiedad(cProp As String)
		Local loSingle As ClaseUnicaSingleton
		loSingle = This.obtenerInstanciaSingleton()
		Return loSingle.getPropiedad()
	Endproc
Enddefine

Define Class ClaseUnicaSingleton As Custom
	Hidden propiedad
	Procedure getPropiedad() As String
		Return This.propiedad
	Endproc

	Procedure setPropiedad(cProp As String)
		This.propiedad = cProp
	Endproc
Enddefine