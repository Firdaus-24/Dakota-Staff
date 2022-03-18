<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah, mutasi
dim nip, notrans, tgl, nosurat, memo, cabang, cabang1, jabatan, jabatan1, jenjang, jenjang1, divisi, divisi1
dim pnip, ptgl, pthn, id

nip = Request.Form("nip")
notrans = Request.Form("notrans")
tgl = CDate(Request.Form("tgl"))
nosurat = Request.Form("nosurat")
memo = Request.Form("memo")
agen = Request.Form("agen")
cabang1 = Request.Form("cabang1")
jabatan = Request.Form("jabatan")
jabatan1 = Request.Form("jabatan1")
jenjang = Request.Form("jenjang")
jenjang1 = Request.Form("jenjang1")
divisi = Request.Form("divisi")
divisi1 = Request.Form("divisi1")

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "UPDATE HRD_T_Mutasi SET Mut_Nip = '"& nip &"', Mut_Tanggal = '"& tgl &"', Mut_NoSurat = '"& nosurat &"', Mut_Memo = '"& memo &"', Mut_AsalAgenID = '"& agen &"', Mut_AsalJabCode = '"& jabatan &"', Mut_AsalJJID = '"& jenjang &"', Mut_AsalDDBID = '"& divisi &"', Mut_TujAgenID = '"& cabang1 &"', Mut_TujJabCode = '"& jabatan1 &"', Mut_TujJJID = '"& jenjang1 &"', Mut_TujDDBID = '"& divisi1 &"' WHERE Mut_ID = '"& notrans &"'"
' Response.Write tambah.commandText & "<br>"
tambah.execute
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../../layout/footer.asp' -->
