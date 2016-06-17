Class MyApp.ECPClientInstaller 
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>
	<Var Name="ServerName" Value="SERVER"/>
	<Var Name="ServerAddr" Value="10.211.55.2"/>
	<Var Name="ServerPort" Value="56774"/>
	<Var Name="Namespace" Value="MYAPP"/>
	<Var Name="DBName" Value="MYAPP"/>
	<Var Name="RemoteDBPath" Value="/opt/MYAPP/DB/"/>
	<Var Name="CSPApp" Value="/myapp"/>
	<Var Name="CSPAppDir" Value="/opt/myapp"/>
	<Var Name="CSPAppRouter" Value="MyApp.Router"/>

	<SystemSetting 
	    Name="Config.config.routines"
	    Value="32"/>

	<SystemSetting 
	    Name="Config.config.globals8kb"
	    Value="256"/>

	<Invoke Class="${CURRENTCLASS}" Method="SetupECPClient" CheckStatus="true">
		<Arg Value="${ServerName}"/>
		<Arg Value="${ServerAddr}"/>
		<Arg Value="${ServerPort}"/>
	</Invoke>

	<Invoke Class="${CURRENTCLASS}" Method="RemoteDatabase" CheckStatus="true">
		<Arg name="DatabaseName" Value="${DBName}"/>
		<Arg name="ServerName" Value="${ServerName}"/>
		<Arg name="Directory" Value="${RemoteDBPath}"/>
	</Invoke>

	<Namespace Name="${Namespace}" Create="yes" Code="${DBName}" Data="${DBName}">
		<Configuration>
			<CSPApplication Url="${CSPApp}" Directory="${CSPAppDir}" Description=""/>

		</Configuration>
	</Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, 
   pInstaller As %Installer.Installer, 
   pLogger As %Installer.AbstractLogger) 
   As %Status [ CodeMode = objectgenerator, Internal ]
{
	do %code.WriteLine($char(9)_"set pVars(""CURRENTCLASS"")="""_%classname_"""")
	do %code.WriteLine($char(9)_"set pVars(""CURRENTNS"")="""_$namespace_"""")
    #; Let our XGL document generate code for this method. 
    Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod SetupECPClient(ServerName As %String, ServerAddr As %String, ServerPort As %Integer) As %Status
{
	new $namespace
	set $namespace = "%SYS"

	set props("Address") = ServerAddr
	set props("Port") = ServerPort

	quit ##class(Config.ECPServers).Create(ServerName, .props)
}

ClassMethod RemoteDatabase(DatabaseName As %String, ServerName As %String, Directory As %String) As %Status
{
	new $namespace
	set $namespace = "%SYS"

	set props("Server") = ServerName
	set props("Directory") = Directory

	quit ##class(Config.Databases).Create(DatabaseName, .props)
}

}