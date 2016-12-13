Class MyApp.Main Extends %CSP.Page
{


ClassMethod OnPage() As %Status
{
	&html<<!docktype html>
<html>
<head>
<style>
html,
body,
#main {
	width: 100%;
	height: 100%;
	padding: 0px;
	margin: 0px;
}
</style>
</head>
<body>
<div id='main'>
	<h1>Hello you are on:</h1>
	<h3>#(%request.GatewayInstanceName)#</h3>
</div>
</body>
</html>>
	quit $$$OK
}


}