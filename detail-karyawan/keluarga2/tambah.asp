<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim nama, hubungan, jabatan, pendidikan, skeluarga, tmptl, tgll, busaha,jk
dim pkeluarga2

nip = Request.Form("nip")
nama = Request.Form("nama")
hubungan = Request.Form("hubungan")
tmptl = Request.Form("tmptl")
tgll = Request.Form("tgll")
jk = Request.Form("jk")
pendidikan = Request.Form("pendidikan")
busaha = Request.Form("busaha")
jabatan = Request.Form("jabatan")
skeluarga = Request.Form("skeluarga")

tgle = tgll & " 00:00:00"


set keluarga = Server.CreateObject("ADODB.COmmand")
keluarga.ActiveConnection = MM_cargo_STRING

set pkeluarga2 = Server.CreateObject("ADODB.COmmand")
pkeluarga2.ActiveConnection = MM_cargo_STRING

pkeluarga2.commandText = "SELECT * FROM HRD_T_Keluarga2 WHERE Kel2_Nip = '"& nip &"' and Kel2_nama = '"& nama &"' and Kel2_hubungan = '"& hubungan &"' and Kel2_tempatLahir = '"& tmptl &"' and Kel2_tglLahir = '"& tgll &"' and Kel2_Sex = '"& jk &"' and Kel2_JDdkID = '"& pendidikan &"' and Kel2_UshID = '"& busaha &"' and Kel2_JbtID = '"& jabatan &"' and Kel2_SttKelID = '"& skeluarga &"'"
set pkeluarga2 = pkeluarga2.execute

if pkeluarga2.eof then
        keluarga.commandText = "INSERT INTO HRD_T_Keluarga2 (Kel2_NIP, Kel2_nama, Kel2_Hubungan, Kel2_TempatLahir, Kel2_tglLahir, Kel2_Sex, Kel2_UshID, Kel2_JbtID, Kel2_SttKelID, Kel2_JDdkID) VALUES ('"& nip &"','"& nama &"', '"& hubungan &"', '"& tmptl &"', '"& tgle &"', '"& jk &"', '"& busaha &"', '"& jabatan &"', '"& skeluarga &"', '"& pendidikan &"')"
        
        keluarga.execute

        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga2.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga2.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 
 %>
<!--#include file="../../layout/footer.asp"-->