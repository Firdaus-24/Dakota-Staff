<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim nip, nama, delete, hub

nip = Request.QueryString("nip")
nama = Request.QueryString("nama")
hub = Request.QueryString("hub")

set delete = Server.CreateObject("ADODB.Command")
delete.ActiveConnection = MM_cargo_STRING

delete.commandText = "DELETE FROM HRD_T_Keluarga1 WHERE Kel1_Nip = '"& nip &"' and Kel1_nama = '"& nama &"' and Kel1_Hubungan = '"& hub &"'"
'Response.Write delete.commandText
delete.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>DATA TERHAPUS</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga1.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
%>

<!--#include file="../../layout/footer.asp"-->