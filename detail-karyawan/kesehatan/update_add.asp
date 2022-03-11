<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim nip, nomor, nsakit, bulan, tahun, lama

nip = Request.Form("nip")
nomor = Request.Form("nomor")
nsakit = Request.Form("nsakit")
bulan = Request.Form("bulan")
tahun = Request.Form("tahun")
lama = Request.Form("lama")

set update = Server.CreateObject("ADODB.Command")
update.ActiveConnection = MM_cargo_STRING

update.commandText = "UPDATE HRD_T_kesehatan SET Kes_PenyID = '"& nsakit &"', Kes_bulan = '"& bulan &"', Kes_tahun = '"& tahun &"', Kes_lama = '"& lama &"' WHERE Kes_ID = "& nomor &" and Kes_Nip = '"& nip &"'"
update.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/Kesehatan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

 %>
 <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>
<!--#include file="../../layout/footer.asp"-->