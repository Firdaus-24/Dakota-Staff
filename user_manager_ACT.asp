<!--#include file="Connections/cargo.asp" -->


<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("login.asp")
end if
%>


<title>DAKOTA CARGO | <% response.Write session("username") & " | " & session("cabang") %> 
</title> 

<%


dim deletedRecord

deletedRecord = Request.QueryString("uname")



response.Write(deletedRecord)

dim sql 

sql = "update weblogin set User_aktifYN = 'Y' where username ='"& deletedRecord &"'"

Set Connection = Server.CreateObject("ADODB.Connection")
connection.open MM_cargo_STRING

connection.execute sql

response.Redirect("user_manager.asp")




%>