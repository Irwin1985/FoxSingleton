oRef1 = Createobject("Singleton", "cliente")
oRef2 = Createobject("Singleton", "cliente")
oRef1.NomCli = "Irwin Rodríguez"

Messagebox(oRef1.NomCli)
Messagebox(oRef2.NomCli)

Release oRef1, oRef2
Clear All
Return

*-- Mi clase original
Define Class cliente As Custom
	NomCli = ""
Enddefine


*-- Singleton Class
Define Class Singleton As SingletonTemplate
	Procedure Init(tcOriginClass)
		This.OriginClass = tcOriginClass
		DoDefault()
	Endproc
Enddefine

*-- Singleton Template
Define Class SingletonTemplate As Custom
	OriginClass 		= ""
	#Define True 		.T.
	#Define False 		.F.
	#Define UdPems		5
	#Define UnkNown		"U"

	Procedure Init(tbDoNotCreate)
		If tbDoNotCreate
			Return
		Else &&tbDoNotCreate
		Endif &&tbDoNotCreate

		If !This.checkInstance()
			This.createInstance()
		Else &&!This.checkInstance()
		Endif &&!This.checkInstance()
	Endproc
	Procedure checkInstance
		If !Isnull(This.getInstance())
			Return True
		Else &&!Isnull(This.getInstance())
		Endif &&!Isnull(This.getInstance())

		If !Pemstatus(_Screen,This.OriginClass, UdPems)
			_Screen.AddProperty(This.OriginClass, .Null.)
		Else &&!Pemstatus(_Screen,This.OriginClass, UdPems)
		Endif &&!Pemstatus(_Screen,This.OriginClass, UdPems)
		Return False
	Endproc
	Procedure createInstance
		Local oInstance
		oInstance = Iif(Lower(This.Class) == Lower(This.OriginClass), CreateObject(This.OriginClass, True), CreateObject(This.OriginClass))
		Store oInstance To ("_Screen." + This.OriginClass)
	Endproc
	Procedure getInstance
		Return Iif(Type("_Screen." + This.OriginClass)==UnkNown,.Null.,Eval("_Screen." + This.OriginClass))
	Endproc
	*-- Destroy
	Procedure Destroy
		Try
			lcProp = This.OriginClass
			=Removeproperty(_Screen, lcProp)
		Catch
		Endtry
	Endproc
	*--This_Access(cMember)
	Function This_Access(cMember)
		Return Iif(Inlist(Lower(cMember), "originclass", "checkinstance", "createinstance", "getinstance", "class"), This, Eval("_Screen." + This.OriginClass))
	Endfunc
Enddefine
