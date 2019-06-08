*====================================================================
* FoxSingleton Unit Test
*====================================================================
Define Class FoxSingletonTest As FxuTestCase Of FxuTestCase.prg

	#If .F.
		Local This As FoxSingletonTest Of FoxSingletonTest.prg
	#Endif

	icTestPrefix = "test"

	Procedure Setup
		Set Path To "FoxSingleton;"
		Set Procedure To "FoxSingleton" Additive
		Public Person as People
		Person = CreateObject("Singleton", "People")
		
*====================================================================
	Procedure TearDown
		Set Path To
		Set Procedure To
		Release Person
			
*====================================================================
	Procedure test_should_create_a_person_object_as_singleton
		This.AssertNotNull(Person, "oPerson is not a valid object")
	
*====================================================================
	Procedure test_should_return_the_same_content_in_both_instances
		Person.FirstName = 'Jhon'
		Person.LastName  = 'Doe'

		oPerson2 = CreateObject("Singleton", "People")
		This.MessageOut("Person.FullName: " + Person.FullName())
		This.MessageOut("oPerson2.FullName: " + oPerson2.FullName())
		
		This.AssertEquals(Person.FullName(), oPerson2.FullName(), "Result values does not match")
		Release oPerson2

*====================================================================
Enddefine

*====================================================================
* This Class is used as a helper class for testing FoxSingleton
*====================================================================
Define Class People As Custom
	FirstName = ""
	LastName  = ""
	
	Procedure fullName as String
		Return This.FirstName + Space(1) + This.LastName
		
	*====================================================================		
Enddefine
