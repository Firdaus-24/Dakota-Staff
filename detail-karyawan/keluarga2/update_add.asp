<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim keluarga
dim nama, jk, nip, hubungan, tmptl, tgll, pendidikan, busaha, jabatan, skeluarga
dim namae, hubungane, pendidikane, tmptle, tglle, busahae, jabatane, skeluargae

namae = Request.Form("namae")
hubungane = Request.Form("hubungane")
tmptle = Request.Form("tmptle")
tglle = Request.Form("tglle")
jke = Request.Form("jkelamine")
pendidikane = Request.Form("pendidikane")
busahae = Request.Form("busahae")
jabatane = Request.Form("jabatane")
skeluargae = Request.Form("skeluargae")

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

if hubungan <> "Pilih" then
    hubungan = hubungan
else
    hubungan = ""
end if

if jk <> "Pilih" then
    jk = jk
else 
    jk = ""
end if

if pendidikan <> "Pilih" then
    pendidikan = pendidikan
else
    pendidikan = ""
end if

if busaha <> "Pilih" then
    busaha = busaha
else 
    busaha = ""
end if

if  jabatan <> "Pilih" then
    jabatan = jabatan 
else
    jabatan = ""
end if

if  skeluarga <> "Pilih" then
    skeluarga = skeluarga
else 
    skeluarga = ""
end if

tgla = tgll & " 00:00:00" 
tgle = tgll & " 23:59:59" 

set keluarga = Server.CreateObject("ADODB.Command")
keluarga.ActiveConnection = MM_cargo_STRING

keluarga.commandText = "SELECT * FROM HRD_T_Keluarga2 WHERE Kel2_Nip = '"& nip &"' and Kel2_nama = '"& nama &"' and Kel2_hubungan = '"& hubungan &"' and Kel2_tempatLahir = '"& tmptl &"' and Kel2_tglLahir = '"& tgla &"' and Kel2_Sex = '"& jk &"' and Kel2_JDdkid = '"& pendidikan &"' and Kel2_UshID = '"& busaha &"' and Kel2_JbtID = '"& jabatan &"' and Kel2_SttKelID = '"& skeluarga &"'"

set keluarga2 = keluarga.execute

if keluarga2.eof then
    keluarga.commandText = "UPDATE HRD_T_Keluarga2 SET Kel2_nama = '"& nama &"', Kel2_hubungan = '"& hubungan &"', Kel2_tempatLahir = '"& tmptl &"', Kel2_tglLahir = '"& tgll &"', Kel2_Sex = '"& jk &"', Kel2_JDdkid = '"& pendidikan &"', Kel2_UshID = '"& busaha &"', Kel2_JbtID = '"& jabatan &"', Kel2_SttKelID = '"& skeluarga &"' WHERE Kel2_Nip = '"& nip &"' and Kel2_nama = '"& namae &"' and Kel2_hubungan = '"& hubungane &"' and Kel2_tempatLahir = '"& tmptle &"' and Kel2_tglLahir = '"& tglle &"' and Kel2_Sex = '"& jke &"' and Kel2_JDdkid = '"& pendidikane &"' and Kel2_UshID = '"& busahae &"' and Kel2_JbtID = '"& jabatane &"' and Kel2_SttKelID = '"& skeluargae &"'"
    keluarga.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga2.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga2.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!--#include file="../../layout/footer.asp"-->