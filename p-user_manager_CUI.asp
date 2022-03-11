<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%> 

<!--#include file="Connections/cargo.asp" -->
<!-- #include file="md5.asp" -->


<%

Dim Username
Dim Password
Dim Surename
Dim Location

dim agen
dim agen_cmd
dim perwakilan
dim perwakilan_cmd

dim ifExist
dim ifExist_cmd
dim user
dim user_cmd

username = request.Form("username")
password = md5(trim(request.Form("password2")))
location = request.Form("agen")
surename = request.Form("surename")

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
user_cmd.commandtext = "update WebLogin set realname = '"& surename &"', password = '"& password &"', ServerID = '"& servID &"'  where username = '"& username &"'"

user_cmd.prepared=true
user_cmd.execute

		Response.Redirect("serverSelector.asp")



else

servID = agen.fields.item("agen_ID").value
'response.write servID

'Login Proses untuk agen/cabang/counter Dakota Buana Semesta
user_cmd.commandtext = "update WebLogin set realname = '"& surename &"', password = '"& password &"', ServerID = '"& servID &"'  where username = '"& username &"'"

user_cmd.prepared=true
user_cmd.execute
	
		Response.Redirect("serverSelector.asp")
end if

response.Write user_cmd.commandText 
%>

