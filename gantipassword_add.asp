<!-- #include file='connection.asp' -->
<!-- #include file="md5.asp" -->
<% 
dim username,serverid, login_cmd,login
dim passwordLama, passwordBaru, ulang, eror, salah, berhasil 

username = Request.Form("username")
serverid = Request.Form("serverid")
passwordLama = md5(Request.Form("passwordLama"))
passwordBaru = md5(Request.Form("passwordBaru"))
ulang = md5(Request.Form("ulang")) 'ketikan ulang user

' cek password username 
set login_cmd = Server.CreateObject("ADODB.Command")
login_cmd.activeConnection = mm_cargo_string

login_cmd.commandText = "SELECT webLogin.username, webLogin.ServerID, webLogin.realName, webLogin.password FROM webLogin WHERE (webLogin.User_aktifYN = 'Y') AND (webLogin.username = '"& username &"') and (webLogin.ServerID = '"& serverid &"') and webLogin.Password = '"& passwordLama &"'"
' Response.Write login_cmd.commandText & "<br>"
set login = login_cmd.execute
    
    ' Response.Redirect("gantipassword.asp?msgError="& msgError &"&username="&username&"&serverid="&serverid)
if login.eof then
    Response.Redirect("gantipassword.asp?msgError=p&username="&username&"&serverid="&serverid)
elseIf passwordBaru <> ulang then
    Response.Redirect("gantipassword.asp?msgError=q&username="&username&"&serverid="&serverid)
else
    login_cmd.commandTExt = "UPDATE webLogin SET password = '"& passwordBaru &"' WHERE (webLogin.User_aktifYN = 'Y') AND (webLogin.username = '"& username &"') AND (webLogin.password = '"& passwordLama &"') AND (webLogin.ServerID = '"& serverid &"')"

    login_cmd.execute

    msgOK = "q" 
    Response.Redirect("gantipassword.asp?msgOK="&msgOK&"&username="&username&"&serverid="&serverid)
      
end if

 %>