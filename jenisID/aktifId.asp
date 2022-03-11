<!--#include file="includes/query.asp"-->
<% 

dim codeY, codeN

codeY = Request.QueryString("codeY")
codeN = Request.QueryString("codeN")

divisi_cmd.commandText = "UPDATE HRD_M_Divisi SET Div_AktifYN = 'Y' WHERE Div_Code = '" & codeY & "' "
divisi_cmd.prepared = true
set divisi = divisi_cmd.execute


divisi_cmd.commandText = "UPDATE HRD_M_Divisi SET Div_AktifYN = 'N' WHERE Div_Code = '" & codeN & "' "
divisi_cmd.prepared = true
set divisi = divisi_cmd.execute

Response.Redirect ("index.asp")

 %> 