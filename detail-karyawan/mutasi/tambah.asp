<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah, mutasi
dim nip, notrans, tgl, nosurat, memo, cabang, cabang1, jabatan, jabatan1, jenjang, jenjang1, divisi, divisi1
dim pnip, ptgl, pthn, key, id

id = Request.Form("id")
nip = trim(Request.Form("nip"))
notrans = trim(Request.Form("notrans"))
tgl = CDate(Request.Form("tgl"))
nosurat = trim(replace(Request.Form("nosurat"),"'",""))
memo = trim(replace(Request.Form("memo"),"'",""))
agen = trim(Request.Form("agen"))
jabatan = trim(Request.Form("jabatan"))
jenjang = trim(Request.Form("jenjang"))
divisi = trim(Request.Form("divisi"))
cabang1 = trim(Request.Form("cabang1"))
jabatan1 = trim(Request.Form("jabatan1"))
jenjang1 =trim(Request.Form("jenjang1"))
divisi1 = trim(Request.Form("divisi1"))

pnip = left(nip, 3)
pthn = right(year(tgl), 2)
ptgl = right("00"& month(tgl),2)

key = pnip & ptgl & pthn

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.activeConnection = MM_Cargo_string

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_Nip = '"& nip &"' and Mut_NoSurat = '"& nosurat &"' and Mut_Tanggal = '"& tgl &"' and Mut_Memo = '"& memo &"' AND Mut_AsalAgenID = '"& agen &"'"
Response.Write tambah.commandText & "<br>"
set mutasi = tambah.execute

if mutasi.eof then
    tambah.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& tgl &"', '', '"& nosurat &"', '"& memo &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"', '"& cabang1 &"', '"& jabatan1 &"', '"& jenjang1 &"', '"& divisi1 &"' "
    Response.Write tambah.commandText
    ' tambah.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../../layout/footer.asp' -->
