<!-- #include file='nconnection.asp' -->
<!-- #include file="md5.asp" -->
<% 
dim username, password, cabang
dim login_cmd, login

username = Request.Form("username")
password = md5(Request.Form("password"))
cabang = Request.Form("cabang")

set login_cmd = Server.CreateObject("ADODB.Command")
login_cmd.activeConnection = MM_Cargo_String

set personallogin_cmd = Server.CreateObject("ADODB.Command")
personallogin_cmd.activeConnection = MM_Cargo_String

login_cmd.commandText = "SELECT webLogin.username, webLogin.ServerID, webLogin.realName, GLB_M_Agen.Agen_CabangID, GLB_M_Agen.Agen_Nama FROM webLogin INNER JOIN GLB_M_Agen ON webLogin.ServerID = GLB_M_Agen.Agen_ID WHERE (webLogin.User_aktifYN = 'Y') AND (webLogin.username = '"& username &"') AND (webLogin.password = '"& password &"') AND (webLogin.ServerID = '"& cabang &"')"
' Response.Write login_cmd.commandText
set login = login_cmd.execute



if login.eof then
    personallogin_cmd.commandText = "SELECT Kry_nip FROM HRD_M_Karyawan WHERE Kry_pass_login_loading_barang = '"& password &"' AND Kry_AktifYN = 'Y' AND Kry_Nip = '"& username &"' "
    ' Response.Write personallogin_cmd.commandText & "<br>"
    set personallogin = personallogin_cmd.execute
    
    if personallogin.eof then 
        if cabang = "" then
            Response.redirect ("personal/login.asp")
        else    
            Response.redirect ("login.asp")
        end if

    else
        session("nip") = personallogin("Kry_nip") 
        Response.Redirect("personal/index.asp")
    end if 

else
    login_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& username &"') AND (ServerID = '"& cabang &"')"
    set rights = login_cmd.execute


	
   do while not rights.eof
		session(rights("appIDRights")) = true
				
		rights.moveNext
	loop

    Session("username")= username
	session("cabang") = login("agen_nama")
	session("server-id") = cabang
    session("appName") = "HRD"
	
		if session("username") = "administrator" then
		    response.Redirect("hakakses/")
		else
		    Response.redirect ("dashboard.asp")
		end if
end if
 %>
 
 
 <% 


 %>