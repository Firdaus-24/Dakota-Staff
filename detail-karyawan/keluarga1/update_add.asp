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
jk = Request.Form("jkelamin")
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

keluarga.commandText = "SELECT * FROM HRD_T_Keluarga1 WHERE Kel1_Nip = '"& nip &"' and Kel1_nama = '"& nama &"' and Kel1_hubungan = '"& hubungan &"' and Kel1_tempatLahir = '"& tmptl &"' and Kel1_tglLahir = '"& tgla &"' and Kel1_Sex = '"& jk &"' and Kel1_JDdkid = '"& pendidikan &"' and Kel1_UshID = '"& busaha &"' and Kel1_JbtID = '"& jabatan &"' and Kel1_SttKelID = '"& skeluarga &"'"

set keluarga1 = keluarga.execute

if keluarga1.eof then
    keluarga.commandText = "UPDATE HRD_T_Keluarga1 SET Kel1_nama = '"& nama &"', Kel1_hubungan = '"& hubungan &"', Kel1_tempatLahir = '"& tmptl &"', Kel1_tglLahir = '"& tgll &"', Kel1_Sex = '"& jk &"', Kel1_JDdkid = '"& pendidikan &"', Kel1_UshID = '"& busaha &"', Kel1_JbtID = '"& jabatan &"', Kel1_SttKelID = '"& skeluarga &"' WHERE Kel1_Nip = '"& nip &"' and Kel1_nama = '"& namae &"' and Kel1_hubungan = '"& hubungane &"' and Kel1_tempatLahir = '"& tmptle &"' and Kel1_tglLahir = '"& tglle &"' and Kel1_Sex = '"& jke &"' and Kel1_JDdkid = '"& pendidikane &"' and Kel1_UshID = '"& busahae &"' and Kel1_JbtID = '"& jabatane &"' and Kel1_SttKelID = '"& skeluargae &"'"
    keluarga.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga1.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/keluarga1.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!--#include file="../../layout/footer.asp"-->