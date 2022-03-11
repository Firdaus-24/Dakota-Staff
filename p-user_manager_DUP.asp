<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%> 

<!--#include file="Connections/cargo.asp" -->
<!-- #include file="md5.asp" -->


<%

Dim Username, vuname
Dim Password
Dim Surename
Dim Location, vagen, vkd

dim agen
dim agen_cmd
dim perwakilan
dim perwakilan_cmd

dim ifExist
dim ifExist_cmd
dim user
dim user_cmd

username = request.Form("username")
vuname = request.Form("vuname")
password = md5(trim(request.Form("password2")))
location = request.Form("agen")
vagen = request.Form("vagen")
vkd = request.Form("vkd")
vpt = request.Form("vpt")
surename = request.Form("surename")


if (trim(username)=trim(vuname)) and (trim(location)=trim(vagen)) then
	Response.Write("Username Pada Cabang Tersebut Sudah Terdaftar")
else


set agen_cmd = server.CreateObject("ADODB.command")
agen_cmd.activeConnection = MM_cargo_String

agen_cmd.commandText = "select * from GLB_M_agen where agen_aktifYN = 'Y' and agen_nama = '"& location &"'"
agen_cmd.prepared = true
set agen = agen_cmd.execute

set perwakilan_cmd = server.CreateObject("ADODB.Command")
perwakilan_cmd.activeConnection = MM_Cargo_string

perwakilan_cmd.commandtext = "select * from GLB_M_Perwakilan where Perwakilan_AktifYN = 'Y' and perwakilan_nama = '"& location &"'"
perwakilan_cmd.prepared = true
set perwakilan = perwakilan_cmd.execute

set user_cmd = server.CreateObject("ADODB.Command")
user_cmd.activeConnection = MM_Cargo_String

if agen.eof then
ServID = perwakilan.Fields.Item("perwakilan_ID").value
response.write ServID

'Login Proses untuk Perwakilan Dakota Buana Semesta
user_cmd.commandtext = "INSERT INTO WebLogin (username,password,user_AktifYN,ServerID,realName,LastLogin,LastIPLogin,PT_ID) VALUES ('"& username &"','"& password &"','Y','"& ServID &"', '"& surename &"','"& month(date) & "/" & day(date) & "/" & year(date) &"','192.168.22.3', '"& vpt &"' )"
user_cmd.execute

'		Response.Redirect("serverSelector.asp")



else

servID = agen.fields.item("agen_ID").value
'response.write servID

'Login Proses untuk agen/cabang/counter Dakota Buana Semesta
user_cmd.commandtext = "INSERT INTO WebLogin (username,password,user_AktifYN,ServerID,realName,LastLogin,LastIPLogin,PT_ID) VALUES ('"& username &"','"& password &"','Y','"& ServID &"', '"& surename &"','"& month(date) & "/" & day(date) & "/" & year(date) &"','192.168.22.3', '"& vpt &"' )"

user_cmd.execute
	
'		Response.Redirect("serverSelector.asp")
end if

'Response.Write(user_cmd.commandtext) & "<br><br>" 
 
 
'---------------------------------------------------------Web Right--------------------------------
set insertR = server.CreateObject("ADODB.Command")
insertR.activeConnection = MM_Cargo_String

set right_cmd = server.CreateObject("ADODB.Command")
right_cmd.activeConnection = MM_Cargo_String
right_cmd.commandtext = "SELECT appIDRights FROM WebRights WHERE (Username = '"& vuname &"') AND (ServerID = "& vkd &") GROUP BY appIDRights ORDER BY appIDRights"
set rights = right_cmd.execute
do while not rights.eof
 
	'response.Write(rights.fields.item("appIDRights") &" - "& username &" - "& ServID ) &"<br>"
	'response.Write(rights.fields.item("appIDRights") &" - "& vuname &" - "& vkd ) &"<br>"
	insertR.commandtext = "INSERT INTO WebRights (appIDRights, Username, ServerID) VALUES ('"& rights.fields.item("appIDRights") &"', '"& username &"', '"& ServID &"')"
	'response.Write(insertR.commandtext) &"<br>"
	insertR.execute
 
 rights.movenext
 loop
 
 
 Response.Redirect("user_manager.asp")

end if
%>

