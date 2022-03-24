<% 
if session("username") = "" Or session("appName") <> "HRD" then
	Response.Redirect("http://192.168.50.8/hrd/login.asp")
	' Response.Redirect("http://103.111.190.162/hrd/login.asp")
end if
 %>