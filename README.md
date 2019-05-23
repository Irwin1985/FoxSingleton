# FoxSingleton ![](images/prg.gif)  
Singleton Pattern made easy with Visual FoxPro.

**NOTE:** This library was inspired by **[SingletonPattern(VFP) from Victor Espina](http://www.victorespina.com.ve/wiki/index.php?title=SingletonPattern_(VFP))**.

### Project Manager

**Irwin Rodríguez** (Toledo, Spain)

### Latest Release

**[FoxSingleton](/README.md)** - v.1.2 - Release 2019-05-22 23:07:16


# Example
<hr>
<pre>
   * --------------------------------------------------------------------------------- *
   * 1. Save FoxSingleton anywhere in your project's path.
   * 2. Declare FoxSingleton in your main.prg declaration procedures.
   *    eg. Set Procedure to "FoxSingleton.prg" Additive   
   *
   * 3. Create an instance of "Singleton" class passing your class name as parameter.
   * --------------------------------------------------------------------------------- *
   
   *!* This is your class
   Define Class Person As Custom
      name = ""
      age = 0
      email = ""
   EndDefine
   
   *!* Now create a Person object
   oPerson1 = CreateObject("Singleton", "Person")
   oPerson2 = CreateObject("Singleton", "Person")
   
   oPerson1.name = "Jhon Doe"
   ?oPerson2.name &&Prints 'Jhon Doe'
   Release oPerson1, oPerson2   
</pre>
