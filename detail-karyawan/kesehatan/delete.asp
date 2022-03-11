<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim delete, nip, id

nip = Request.QueryString("nip")
id = Request.QueryString("id")

set delete = Server.CreateObject("ADODB.Command")
delete.ActiveConnection = MM_cargo_STRING

delete.commandText = "DELETE FROM HRD_T_Kesehatan WHERE Kes_Nip = '"& nip &"' and Kes_ID = '"& id &"'"

delete.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>DATA TERHAPUS</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/Kesehatan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
%>
<!--#include file="../../layout/footer.asp"-->