<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah
dim nip, nosurat, perihal, tgl

nip = Request.Form("nip")
tgl = Request.Form("tgl")
nosurat = Request.Form("nosurat")
perihal = Request.Form("perihal")

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "SELECT * FROM HRD_T_SPK WHERE SPK_Nip = '"& nip &"' and SPK_Tanggal = '"& tgl &"' and SPK_No = '"& nosurat &"' and SPK_Perihal = '"& perihal &"'"
set perjanjian = tambah.execute

bulan = month(tgl)
tahun = right(year(tgl), 2)

key = bulan & tahun

if perjanjian.eof then

    tambah.commandText = "exec sp_ADDHRD_T_SPK '"& key &"', '"& nip &"',  '"& nosurat &"', '"& tgl &"', '"& perihal &"'"
    ' Response.Write tambah.commandText
    tambah.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/perjanjian.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/perjanjian.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

end if

 
 %>
<!-- #include file='../../layout/footer.asp' -->