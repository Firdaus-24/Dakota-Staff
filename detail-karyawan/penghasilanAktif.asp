<!-- #include file='../connection.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim id, aktif, penghasilanAktif, nip

id = Request.QueryString("id")
aktif = Request.QueryString("aktif")
nip = Request.QueryString("nip")

set penghasilanAktif = Server.CreateObject("ADODB.Command")
penghasilanAktif.activeConnection = MM_Cargo_String


if aktif = "N" then 
    penghasilanAktif.commandText = "UPDATE HRD_T_Salary_Convert SET Sal_AktifYN = 'Y' WHERE Sal_ID ='"& id &"' "
    penghasilanAktif.execute
else 
    penghasilanAktif.commandText = "UPDATE HRD_T_Salary_Convert SET Sal_AktifYN = 'N' WHERE Sal_ID ='"& id &"' "
    penghasilanAktif.execute
end if


Response.Redirect(url&"/detail-karyawan/penghasilan.asp?nip="&nip)

 %>