<!-- #include file='../../connection.asp' -->
' <% 
' tgla = Request.Form("tgla")

' set wilayah = Server.CreateObject("ADODB.Command")
' wilayah.activeConnection = MM_Cargo_string

' wilayah.commandText = "SELECT Agen_ID, Agen_Nama, Agen_Propinsi, Agen_Kota FROM dbo.GLB_M_Agen WHERE (Agen_AktifYN = 'Y') AND (Agen_Nama NOT LIKE '%XX%')"
'  %>