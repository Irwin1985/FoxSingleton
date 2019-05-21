oRef1 = Createobject("clienteClass")
oRef2 = Createobject("clienteClass")
oRef1.NomCli = "Irwin Rodríguez"
MESSAGEBOX(oRef1.NomCli)
MESSAGEBOX(oRef2.NomCli)
RELEASE ALL
CLEAR ALL
return

Define Class clienteClass As SingletonPattern
	className = "clienteClass"
	nomcli = ""
Enddefine

Define Class SingletonPattern As Custom
	*
	className = ""

	* Constructor
	* El parametro plInstance es utilizado por el metodo createInstance() en el caso
	* de que la clase real sea una subclase de SingletonPattern, para indicar que se
	* debe crear la instancia directamente
	Procedure Init(plInstanceMode)
		If plInstanceMode
			Return
		Endif
		If Empty(This.className)      && Si no se indica una clase real se asume
			This.className = This.Class  && esta misma clase
		Endif
		If Not This.checkInstance()   && Se verifica si ya existe una instancia de
			This.createInstance()        && la clase. Si no es si, se crea
		Endif
	Endproc

	* checkInstance
	* Determina si ya existe una instancia creada para la clase real
	Procedure checkInstance
		If Not Isnull(This.getInstance())   && Si podemos obtener una referencia a la instancia
			Return .T.                         && es porque la misma existe
		Endif
		If !Pemstatus(_Screen,This.className, 5)    && Si no existe la propiedad asociada a la clase
			_Screen.AddProperty(This.className, Null)  && en _Screen, se crea
		Endif
		Return .F.
	Endproc

	* createInstance
	* Crea una instancia de la clase real
	Procedure createInstance
		Local oInstance
		If Lower(This.Class) == Lower(This.className)   && La clase real es una subclase directa de SingletonPattern ?
			oInstance = Create(This.className, .T.)
		Else
			oInstance = Create(This.className)
		Endif
		Store oInstance To ("_Screen." + This.className)
	Endproc

	* getInstance
	* Devuelve una referencia a la instancia unica de la clase real
	Procedure getInstance
		If !Pemstatus(_Screen,This.className,5) Or Type("_Screen." + This.className)<>"O"
			Return Null
		Endif
		Return Eval("_Screen." + This.className)
	Endproc

	* releaseInstance
	* Libera la instancia unica de la clase real
	Procedure releaseInstance
		If This.checkInstance()
			Store Null To ("_Screen." + This.className)
		Endif
	Endproc

	* Accesor para la propiedad THIS
	* Este accesor decide si devuelve una referencia al controlador Singleton o a la clase real
	Procedure THIS_Access(cMember)
		If Inlist(Lower(cMember),"classname","checkinstance","createinstance","getinstance","class")
			Return This
		Else
			Return Eval("_Screen." + This.className)
		Endif
	Endproc
Enddefine
