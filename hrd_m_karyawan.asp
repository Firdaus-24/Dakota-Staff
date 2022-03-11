<html>
<head>
<!-- #include file="Connection.asp" -->

<%

dim karyawan
dim karyawan_cmd

Set karyawan_cmd = Server.CreateObject ("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_cargo_STRING

set cabang_cmd = Server.CreateObject ("ADODB.Command")
cabang_cmd.ActiveConnection = MM_cargo_STRING

set jenjang_cmd = Server.CreateObject ("ADODB.Command")
jenjang_cmd.ActiveConnection = MM_cargo_STRING

set grcode_cmd = Server.CreateObject ("ADODB.Command")
grcode_cmd.ActiveConnection = MM_cargo_STRING

set devisi_cmd = Server.CreateObject ("ADODB.Command")
devisi_cmd.ActiveConnection = MM_cargo_STRING

'karyawan_cmd.commandText ="SELECT * from HRD_M_Karyawan where kry_nama is not null"

'set karyawan = karyawan_cmd.execute

%>			
