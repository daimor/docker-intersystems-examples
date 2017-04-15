Class DSWMDX2JSON.Installer 
{

XData setup [ XMLNamespace = INSTALLER ]
{
<Manifest>
    <Var Name="Namespace" Value="MDX2JSON"/>
    <Var Name="Import" Value="0"/>

    <If Condition='(##class(Config.Namespaces).Exists("${Namespace}")=0)'>
      <Log Text="Creating namespace ${Namespace}" Level="0"/>
      <Namespace Name="${Namespace}" Create="yes" Code="${Namespace}" Ensemble="" Data="${Namespace}">
        <Configuration>
          <Database Name="${Namespace}"
            Dir="${MGRDIR}/${Namespace}"
            Create="yes"
            Resource="%DB_${Namespace}"
            PublicPermissions="RW"
            MountAtStartup="true"/>
        </Configuration>
      </Namespace>
      <Log Text="End Creating namespace ${Namespace}" Level="0"/>
    </If>

    <Namespace Name="${Namespace}">
      <Import File="/tmp/deps/Cache-MDX2JSON-master/MDX2JSON/" Flags="ck" Recurse="1"/>
    </Namespace>

    <Namespace Name="${CURRENTNS}">
      <Import File="/tmp/deps/Cache-MDX2JSON-master/MDX2JSON/Installer.cls.xml" Flags="ck"/>

      <Import File="/tmp/deps/deepseeweb.xml" Flags="ck"/>

      <RunInstall Class="MDX2JSON.Installer" Method="setup"/>

      <RunInstall Class="DSW.Installer" Method="setup"/>
    </Namespace>
</Manifest>
}

ClassMethod setup(
    ByRef pVars, 
    pLogLevel As %Integer = 3, 
    pInstaller As %Installer.Installer, 
    pLogger As %Installer.AbstractLogger
  ) As %Status [ CodeMode = objectgenerator, Internal ]
{
	do %code.WriteLine($char(9)_"set pVars(""CURRENTCLASS"")="""_%classname_"""")
	do %code.WriteLine($char(9)_"set pVars(""CURRENTNS"")="""_$namespace_"""")
  #; Let our XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

}