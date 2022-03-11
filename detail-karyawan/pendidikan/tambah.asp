<!-- #include file='construct.asp' -->
<!-- #include file='../../layout/header.asp' -->
<style>
.notiv-gagal{
    width:400px;
    height:200px;
    padding:20px;
    background:#718ee3;
    position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -120px;
    margin-left: -220px;
    border-radius:20px;
}
.notiv-gagal span{
    float:right;
    margin-top:40px;
    color:white;
    font-size:20px;
    text-transform:uppercase;
}
.notiv-gagal img{
    display:block;
    width:100px;
    height:120px;
}   
.notiv-gagal a{
    display:block;
}
/* done */
.notiv-berhasil{
    width:400px;
    height:200px;
    padding:20px;
    background:#718ee3;
    position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -120px;
    margin-left: -220px;
    border-radius:20px;
}
.notiv-berhasil span{
    float:left;
    margin-top:40px;
    color:white;
    font-size:20px;
    text-transform:uppercase;
}
.notiv-berhasil img{
    display:inline-block;
    width:120px;
    height:130px;
    margin-left:20px;
}   
.notiv-berhasil a{
    display:block;
    text-decoration:none;
}
</style>
<% 
dim jenjang, nama, jurusan, kota, blnS, blnE, thnS, thnE, tamat, nip

nip = Request.Form("nip")
jenjang = Request.Form("jenjang")
nama = (UCase(Request.Form("nama")))
jurusan = Request.Form("jurusan")
kota = (Ucase(Request.Form("kota")))
blnS = Request.Form("blnS")
blnE = Request.Form("blnE")
thnS = Request.Form("thnS")
thnE = Request.Form("thnE")
tamat = (UCase(Request.Form("tamat")))

tambah.commandText = "SELECT * FROM HRD_T_Didik1 WHERE Ddk1_NIP = '"& nip &"' and Ddk1_Nama = '"& nama &"' and Ddk1_JrsID = '"& jurusan &"' and Ddk1_kota = '"& kota &"' and Ddk1_Bulan1 = '"& blnS &"' and Ddk1_Tahun1 = '"& thnS &"' and Ddk1_Bulan2 = '"& blnE &"' and Ddk1_Tahun2 = '"& thnE &"' and Ddk1_TamatYN = '"& tamat &"'"
set tambah = tambah.execute

if tambah.eof then

    exe.commandText = "INSERT INTO HRD_T_Didik1 (Ddk1_Nip, Ddk1_JDdkID, Ddk1_Nama, Ddk1_JrsID, Ddk1_Kota, Ddk1_Bulan1, Ddk1_tahun1, Ddk1_Bulan2, Ddk1_Tahun2, Ddk1_TamatYN) VALUES ('"& nip &"', '"& jenjang &"', '"& nama &"', '"& jurusan &"', '"& kota &"', '"& blnS &"', '"& thnS &"', '"& blnE &"', '"& thnE &"', '"& tamat &"')"
    exe.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pendidikan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else 
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/pendidikan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!-- #include file='../../layout/footer.asp' -->