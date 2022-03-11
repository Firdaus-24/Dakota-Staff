<!-- #include file='../../connection.asp' -->
<% 
dim tambah, exe

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_String

set exe = Server.CreateObject("ADODB.Command")
exe.activeConnection = MM_Cargo_String
 %>