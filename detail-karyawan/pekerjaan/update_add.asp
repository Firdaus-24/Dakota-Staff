<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <!-- #include file='../../layout/header.asp' -->
<% 
dim pekerjaan_cmd, pekerjaan
dim namapt, namapt1, usaha, usaha1, jabatan, jabatan1, bln1, blna1, thn1, thna1, bln2, blna2, thna2, referensi, referensi1, akeluar, akeluar1, nip

nip = Request.Form("nip")
namapt = Request.Form("namapt")
namapt1 = Request.Form("namapt1")
bln1 = Request.Form("bln1")
blna1 = Request.Form("blna1")
thn1 = Request.Form("thn1")
thna1 = Request.Form("thna1")
bln2 = Request.Form("bln2")
blna2 = Request.Form("blna2")
thn2 = Request.Form("thn2")
thna2 = Request.Form("thna2")
referensi = Request.Form("referensi")
referensi1 = Request.Form("referensi1")
akeluar = Request.Form("akeluar")
akeluar1 = Request.Form("akeluar1")
jabatan = Request.Form("jabatan")
jabatan1 = Request.Form("jabatan1")
jusaha = Request.Form("jusaha")
jusaha1 = Request.Form("jusaha1")


set pekerjaan_cmd = Server.CreateObject("ADODB.Command")
pekerjaan_cmd.ActiveConnection = MM_cargo_STRING

pekerjaan_cmd.commandText = "SELECT * FROM HRD_T_HistKerja WHERE HK_Nip = '"& nip &"' and HK_namaPT = '"& namapt1 &"' and HK_ushID = '"& jusaha1 &"' and HK_JbtID = '"& jabatan1 &"' and HK_bulan1 = '"& blna1 &"' and HK_tahun1 = '"& thna1 &"' and HK_bulan2 = '"& blna2 &"' and HK_tahun2 = '"& thna2 &"' and HK_referensi = '"& referensi1 &"' and HK_alasanKeluar = '"& akeluar1 &"'"
' Response.Write pekerjaan_cmd.commandText
set pekerjaan = pekerjaan_cmd.execute

if pekerjaan.eof then

    pekerjaan_cmd.commandText = "UPDATE HRD_T_HistKerja SET HK_namaPT = '"& namapt1 &"', HK_UshID = '"& jusaha1 &"', HK_JbtID = '"& jabatan1 &"', HK_Bulan1 = '"& blna1 &"', HK_tahun1 = '"& thna1 &"', HK_bulan2 = '"& blna2 &"', HK_Tahun2 = '"& thna2 &"', HK_referensi = '"& referensi1 &"', HK_alasanKeluar = '"& akeluar1 &"' WHERE HK_Nip = '"& nip &"' and HK_namaPT = '"& namapt &"' and HK_ushID = '"& jusaha &"' and HK_JbtID = '"& jabatan &"' and HK_bulan1 = '"& bln1 &"' and HK_tahun1 = '"& thn1 &"' and HK_bulan2 = '"& bln2 &"' and HK_tahun2 = '"& thn2 &"' and HK_referensi = '"& referensi &"' and HK_alasanKeluar = '"& akeluar &"'"
    ' Response.Write pekerjaan_cmd.commandText
    pekerjaan_cmd.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pekerjaan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/pekerjaan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!--#include file="../../layout/footer.asp"-->