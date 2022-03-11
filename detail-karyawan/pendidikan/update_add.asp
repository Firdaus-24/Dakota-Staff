<!-- #include file='construct.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim nip, jenjang, nama, jurusan, blnS, blnE, thnS, thnE, tamat, kota
dim jenjange, kotae, jurusane, blnSe, blnEe, thnSe, thnEs, tamate

'new data in sql
nip = Request.Form("nip")
jenjang = Request.Form("jenjang")
nama = (UCase(Request.Form("nama")))
jurusan = Request.Form("jurusan")
kota = (UCase(Request.Form("kota")))
blnS = Request.Form("blnS")
blnE = Request.Form("blnE")
thnS = Request.Form("thnS")
thnE = Request.Form("thnE")
tamat = (UCase(Request.Form("tamat")))
'old data in sql
jenjange = Request.Form("jenjange")
namae = (UCase(Request.Form("namae")))
jurusane = Request.Form("jurusane")
kotae = (UCase(Request.Form("kotae")))
blnSe = Request.Form("blnSe")
blnEe = Request.Form("blnEe")
thnSe = Request.Form("thnSe")
thnEe = Request.Form("thnEe")
tamate = (UCase(Request.Form("tamate")))

tambah.commandText = "UPDATE HRD_T_Didik1 SET Ddk1_Nip = '"& nip &"' , Ddk1_JDdkID = '"& jenjang &"', Ddk1_nama = '"& nama &"', Ddk1_JrsID = '"& jurusan &"', Ddk1_kota = '"& kota &"', Ddk1_Bulan1 = '"& blnS &"', Ddk1_Tahun1 = '"& thnS &"', Ddk1_Bulan2 = '"& blnE &"', Ddk1_Tahun2 = '"& thnE &"', Ddk1_TamatYN = '"& tamat &"' WHERE Ddk1_Nip = '"& nip &"' and Ddk1_JDdkID = '"& jenjange &"' and Ddk1_nama = '"& namae &"' and Ddk1_JrsID = '"& jurusane &"' and Ddk1_kota = '"& kotae &"' and Ddk1_Bulan1 = '"& blnSe &"' and Ddk1_Tahun1 = '"& thnSe &"'"
'Response.Write  tambah.commandText
tambah.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pendidikan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"


 %>
 <!-- #include file='../../layout/footer.asp' -->