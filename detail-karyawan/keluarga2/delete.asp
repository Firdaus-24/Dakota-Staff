<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->

<% 
dim delete, name, nip

name = Request.QueryString("name")
nip = Request.QueryString("nip")

set delete = Server.CreateObject("ADODB.Command")
delete.ActiveConnection = MM_cargo_STRING

delete.commandText = "DELETE FROM HRD_T_Keluarga2 WHERE Kel2_nip = '"& nip &"' and Kel2_nama = '"& name &"'"
' Response.Write delete.commandText
delete.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>DATA TERHAPUS</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga2.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
%>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>
<!--#include file="../../layout/footer.asp"-->