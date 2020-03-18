*====================================================================
* FoxSingleton Unit Test
*====================================================================
Define Class FoxSingletonTest As FxuTestCase Of FxuTestCase.prg

	#If .F.
		Local This As FoxSingletonTest Of FoxSingletonTest.prg
	#Endif

	icTestPrefix = "test"
	oPerson 	 = .Null.
	oPerson2 	 = .Null.
	Procedure Setup
		Set Path To "FoxSingleton" additive
		Set Procedure To "FoxSingleton" Additive
		This.oPerson  = CreateObject("Singleton", "People")
		This.oPerson2 = CreateObject("Singleton", "People")
	EndProc	
*====================================================================
	Procedure TearDown
		This.oPerson = .Null.
		This.oPerson2 = .Null.
	EndProc
*====================================================================
	Procedure test_should_create_singleton_object
		If This.AssertNotNull(This.oPerson, "failed at oPerson")
			If This.AssertNotNull(This.oPerson2, "failed at oPerson2")
				this.MessageOut("Test succeeded!")
			EndIf
		EndIf
	EndProc
*====================================================================
	Procedure test_should_return_the_same_content_in_both_instances
		This.oPerson.FirstName = "Jhon"
		This.oPerson.LastName  = "Doe"

		This.MessageOut("This.oPerson.FullName: " + This.oPerson.FullName())
		This.MessageOut("This.oPerson2.FullName: " + This.oPerson2.FullName())
		
		This.AssertEquals(This.oPerson.FullName(), This.oPerson2.FullName(), "Result values does not match")
	EndProc
Enddefine

*====================================================================
* This Class is used as a helper class for testing FoxSingleton
*====================================================================
Define Class People As Custom
	FirstName = ""
	LastName  = ""
	
	Procedure fullName as String
		Return This.FirstName + Space(1) + This.LastName
	EndProc
Enddefine
