<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah, pekerjaan
dim nip, namapt, namapt1, bln1, blna1, thn1, thna1, bln2, blna2, thn2, thna2, referensi1, referensi, akeluar, akeluar1, jabatan, jabatan1, usaha, usaha1

nip = Request.Form("nip")
namapt = Request.Form("namapt")
namapt1 = Request.Form("namapt1")
bln1 = Request.Form("bln1")
blna1 = Request.Form("blna1")
thn1 = Request.Form("thn1")
thna1 = Request.Form("thna1")
bln2 = Request.Form("bln2")
blna2 = Request.Form("blna2")
thna2 = Request.Form("thna2")
referensi = Request.Form("referensi")
referensi1 = Request.Form("referensi1")
akeluar = Request.Form("akeluar")
akeluar1 = Request.Form("akeluar1")
jabatan = Request.Form("jabatan")
jabatan1 = Request.Form("jabatan1")
jusaha = Request.Form("jusaha")
jusaha1 = Request.Form("jusaha1")


set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "INSERT INTO HRD_T_HistKerja (HK_Nip, HK_NamaPT, HK_UshID, HK_JbtID, HK_Bulan1, HK_Tahun1, HK_Bulan2, HK_tahun2, HK_Referensi, HK_AlasanKeluar) VALUES ('"& nip &"', '"& namapt1 &"', '" & jusaha1 &"', '"& jabatan1 &"', '"& blna1 &"', '"& thna1 &"', '"& blna2 &"', '"& thna2 &"', '"& referensi1 &"', '"& akeluar1 &"')"
    ' Response.Write tambah.commandText
tambah.execute
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pekerjaan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

 
 %>
<!-- #include file='../../layout/footer.asp' -->