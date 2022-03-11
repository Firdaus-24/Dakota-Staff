<!--#include file="includes/query.asp"-->

<% 

dim code, nama, offset, angka, aktifId, updateid, utime

code = Request.form("code")
nama = Request.form("nama")
offset = Request.QueryString("offset")
angka = Request.QueryString("angka")
aktifId = Request.QueryString("aktifId")
updateId = Request.QueryString("updateId")
utime = Request.QueryString("uTime")



if trim(code) = ""  or isNull(code) or trim(code)= "0"  then 
    code = 0
end if

if cint(code) <> 0 then
    divisi_cmd.commandText = "update HRD_M_Divisi set Div_Nama = '"& nama &"' WHERE Div_Code = '"& code &"'"
    divisi_cmd.execute
end if

Response.redirect ("index.asp")
 %> 

 <!--#include file="layout/footer.asp"-->


