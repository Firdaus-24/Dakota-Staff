<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim nama, hubungan, tgll, jk, pendidikan, busaha, jabatan, skeluarga, tmplahir, nip
dim keluarga_cmd

nip = Request.Form("nip")
nama = Request.Form("nama")
hubungan = Request.Form("hubungan")
tmptl = Request.Form("tmptl")
tgll = Request.Form("tgll")
jk = Request.Form("jkelamin")
pendidikan = Request.Form("pendidikan")
busaha = Request.Form("busaha")
jabatan = Request.Form("jabatan")
skeluarga = Request.Form("skeluarga")


if hubungan = "Pilih" And jk = "Pilih" And pendidikan = "Pilih" And busaha = "Pilih" and jabatan = "Pilih" then
    hubungan = ""
    tmptl = ""
    pendidikan = ""
    busaha = ""
    jabatan = ""
end if

Set keluarga_cmd = Server.CreateObject ("ADODB.Command")
keluarga_cmd.ActiveConnection = MM_cargo_STRING

keluarga_cmd.commandText = "SELECT * FROM HRD_T_Keluarga1 WHERE Kel1_Nip = '"& nip &"' and Kel1_nama = '"& nama &"' and Kel1_hubungan = '"& hubungan &"' and Kel1_tempatLahir = '"& tmptl &"' and Kel1_tglLahir = '"& tgll &"' and Kel1_Sex = '"& jk &"' and Kel1_JDdkid = '"& pendidikan &"' and Kel1_UshID = '"& busaha &"' and Kel1_JbtID = '"& jabatan &"' and Kel1_SttKelID = '"& skeluarga &"'"

set keluarga1 = keluarga_cmd.execute

if keluarga1.eof then
    keluarga_cmd.commandText = "INSERT INTO HRD_T_Keluarga1 (Kel1_NIP, Kel1_nama, Kel1_Hubungan, Kel1_TempatLahir, Kel1_tglLahir, Kel1_Sex, Kel1_UshID, Kel1_JbtID, Kel1_SttKelID, Kel1_JDdkID) VALUES ('"& nip &"','"& nama &"', '"& hubungan &"', '"& tmptl &"', '"& tgll &"', '"& jk &"', '"& busaha &"', '"& jabatan &"', '"& skeluarga &"', '"& pendidikan &"')"
    'Response.Write  keluarga_cmd.commandText
    keluarga_cmd.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga1.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga1.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if



 %>
<!--#include file="../../layout/footer.asp"-->