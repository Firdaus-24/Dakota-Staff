<!-- #include file="includes/query.asp" -->
<!--#include file="layout/header.asp"-->
<%
dim nama

nama = trim(replace(request.form("nama"),"'",""))

' validasi
if nama = "" then 
    Response.Write "Anda belum memasukan Nama Divisi!!!"
end if


divisi_cmd.commandText ="exec sp_AddHRD_M_Divisi '"& nama &"' "
set divisi = divisi_cmd.execute



Response.redirect("index.asp")

 %> 
<!--#include file="layout/footer.asp"-->