<!--#include file="../../connection.asp"-->
<!-- #include file='../../constend/constanta.asp' -->
<% 
dim nomor, id_cmd, nip
nomor = request.queryString("nomor")
id = request.queryString("id")
nip = request.queryString("nip")

' Response.Write id & "<br>"
' Response.Write nip  & "<br>"
' Response.Write nomor

set id_cmd = server.createObject("ADODB.Command")
id_cmd.activeConnection = MM_Cargo_string

if id = "N" then 
    id_cmd.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_AktifYN = 'Y' WHERE ICS_ID = '"& nomor &"'"
    id_cmd.execute
    'Response.Write id_cmd.commandText
else 
    id_cmd.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_AktifYN = 'N' WHERE ICS_ID = '"& nomor &"'"
    id_cmd.execute
end if

'Response.Write "url/cutiSakitIzin.asp?nip=" & trim(nip)
Response.redirect("../cutiSakitIzin.asp?nip=" & trim(nip))

 %> 