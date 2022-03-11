<!-- #include file="../connection.asp"-->
<!--#include file="../layout/header.asp"-->
<%
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
%>
<% 
dim cari, awal, akhir, karyawan_cmd, karyawana

awal = trim(Request.form("cari-absenAwal"))
akhir = trim(Request.form("cari-absenAkhir"))
cari = Request.form("tombolCari-absen")

Set karyawan_cmd = Server.CreateObject ("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_cargo_STRING

karyawan_cmd.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Absensi.Abs_NIP, CONVERT(varchar(10), dbo.HRD_T_Absensi.Abs_datetime, 120) AS Abs_datetime, dbo.GLB_M_Agen.Agen_Nama FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.GLB_M_Agen LEFT OUTER JOIN dbo.HRD_T_Absensi ON dbo.GLB_M_Agen.Agen_ID = dbo.HRD_T_Absensi.Abs_AgenID ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Absensi.Abs_NIP WHERE (dbo.HRD_M_Karyawan.Kry_NIP = '"& nip &"') AND (Abs_datetime BETWEEN '"& awal &"' AND '"& akhir &"') GROUP BY dbo.HRD_M_Karyawan.Kry_NIP, dbo.HRD_T_Absensi.Abs_NIP, CONVERT(varchar(10), dbo.HRD_T_Absensi.Abs_datetime, 120), dbo.GLB_M_Agen.Agen_Nama Order BY Abs_datetime DESC"

set karyawan = karyawan_cmd.execute

'Response.Write karyawan

 %> 
<!--#include file="../layout/footer.asp"-->
