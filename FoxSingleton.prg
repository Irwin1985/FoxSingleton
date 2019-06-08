*====================================================================
* FoxSingleton
*====================================================================
Define Class Singleton As Helper
	Procedure Init(tcOriginClass)
		This.OriginClass = tcOriginClass
		DoDefault()
*====================================================================
Enddefine

*====================================================================
* Helper Class
*====================================================================
Define Class Helper As Custom
	OriginClass 		= ""

	#Define True 		.T.
	#Define False 		.F.
	#Define UdPems		5
	#Define UnkNown		"U"

	Procedure Init(tbDoNotCreate)
		If tbDoNotCreate
			Return
		Endif

		If !This.checkInstance()
			This.createInstance()
		Endif

*====================================================================
	Procedure checkInstance
		If !Isnull(This.getInstance())
			Return True
		Endif

		If !Pemstatus(_Screen,This.OriginClass, UdPems)
			_Screen.AddProperty(This.OriginClass, .Null.)
		Endif
		Return False

*====================================================================
	Procedure createInstance
		Local oInstance
		oInstance = Iif(Lower(This.Class) == Lower(This.OriginClass), Createobject(This.OriginClass, True), Createobject(This.OriginClass))
		Store oInstance To ("_Screen." + This.OriginClass)

*====================================================================
	Procedure getInstance
		Return Iif(Type("_Screen." + This.OriginClass)==UnkNown,.Null.,Eval("_Screen." + This.OriginClass))

*====================================================================
	Procedure Destroy
		Try
			lcProp = This.OriginClass
			=Removeproperty(_Screen, lcProp)
		Catch
		Endtry

*====================================================================

	Procedure This_Access(cMember)
		Return Iif(Inlist(Lower(cMember), "originclass", "checkinstance", "createinstance", "getinstance", "class"), This, Eval("_Screen." + This.OriginClass))

*====================================================================
Enddefine
