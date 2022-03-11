<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- #include file='../../layout/header.asp' -->
<% 
dim bulan, tahun, nsakit, nomor, lama, nip
dim psakit, sakit, stmt

nip = Request.Form("nip")
'nomor = Request.Form("nomor")
nsakit = Request.Form("nsakit")
bulan = Request.Form("bulan")
tahun = Request.Form("tahun")
lama = Request.Form("lama")

nomora = left(nip,3)
if bulan < 10 then
    bulan = "0" & bulan
else 
    bulan = bulan
end if

nomor = nomora & bulan & tahun
'Response.Write nomor

stmt = "sp_ADDHRD_T_Kesehatan '" + nomor + "','"& nip &"','"& nsakit &"','"& bulan &"','"& tahun &"','"& lama &"', 0"

set psakit = Server.CreateObject("ADODB.Command")
psakit.ActiveConnection = MM_cargo_STRING

psakit.commandText = "SELECT * FROM HRD_T_Kesehatan WHERE Kes_ID = '"& nomor &"' and Kes_nip = '"& nip &"' and Kes_PenyID = '"& nsakit &"' and Kes_bulan = '"& bulan &"' and Kes_tahun = '"& tahun &"' and Kes_Lama = '"& lama &"'"
set sakit = psakit.execute

if sakit.eof then
    psakit.commandText = stmt
    'Response.Write psakit.commandText
    psakit.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/Kesehatan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else 
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/Kesehatan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!--#include file="../../layout/footer.asp"-->