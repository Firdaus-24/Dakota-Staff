<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah, mutasi
dim nip, notrans, tgl, nosurat, memo, cabang, cabang1, jabatan, jabatan1, jenjang, jenjang1, divisi, divisi1
dim pnip, ptgl, pthn, id

nip = Request.Form("nip")
notrans = Request.Form("notrans")
tgl = Request.Form("tgl")
nosurat = Request.Form("nosurat")
perihal = Request.Form("perihal")

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "UPDATE HRD_T_SPK SET SPK_ID = '"& notrans &"', SPK_Nip = '"& nip &"', SPK_Tanggal = '"& tgl &"', SPK_No = '"& nosurat &"', SPK_Perihal = '"& perihal &"' WHERE SPK_ID = '"& notrans &"'"
' Response.Write tambah.commandTExt
tambah.execute
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/perjanjian.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../../layout/footer.asp' -->
