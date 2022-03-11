<!--#include file="../../connection.asp"-->
<% 
dim jabatan
dim jabatan_cmd

set jabatan_cmd = Server.CreateObject("ADODB.Command")
jabatan_cmd.ActiveConnection = MM_cargo_STRING


 %> 