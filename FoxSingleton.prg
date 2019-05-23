*---------------------------------------------------------------------------------------------------------------*
*
* @title:		Librería FoxSingleton
* @description:	Singleton Pattern made easy with FoxSingleton
* @version:		1.2
* @author:		Irwin Rodríguez
* @email:		rodriguez.irwin@gmail.com
* @license:		MIT
* @inspired_by:	http://www.victorespina.com.ve/wiki/index.php?title=SingletonPattern_(VFP)
*
*
* -------------------------------------------------------------------------
* Version Log:
* Release 2019-05-22	v.1.2		- Official Release at https://github.com/Irwin1985/FoxSingleton
*---------------------------------------------------------------------------------------------------------------*

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
