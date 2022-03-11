<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah, mutasi
dim nip, notrans, tgl, nosurat, memo, cabang, cabang1, jabatan, jabatan1, jenjang, jenjang1, divisi, divisi1
dim pnip, ptgl, pthn, key, id

id = Request.Form("id")
nip = Request.Form("nip")
notrans = Request.Form("notrans")
tgl = CDate(Request.Form("tgl"))
nosurat = Request.Form("nosurat")
memo = Request.Form("memo")
cabang = Request.Form("cabang")
cabang1 = Request.Form("cabang1")
jabatan = Request.Form("jabatan")
jabatan1 = Request.Form("jabatan1")
jenjang = Request.Form("jenjang")
jenjang1 = Request.Form("jenjang1")
divisi = Request.Form("divisi")
divisi1 = Request.Form("divisi1")

pnip = left(nip, 3)
pthn = right(year(tgl), 2)
if month(tgl) <= 9 then
    ptgl = "0"& month(tgl)
else 
    ptgl = month(tgl)
end if

key = pnip & ptgl & pthn

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.activeConnection = MM_Cargo_string

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

tambah.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_Nip = '"& nip &"' and Mut_NoSurat = '"& nosurat &"' and Mut_Tanggal = '"& tgl &"' and Mut_Memo = '"& memo &"'"
set mutasi = tambah.execute

if mutasi.eof then
    tambah.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& tgl &"', '', '"& nosurat &"', '"& memo &"', '"& cabang &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"', '"& cabang1 &"', '"& jabatan1 &"', '"& jenjang1 &"', '"& divisi1 &"' "
    ' Response.Write tambah.commandText
    tambah.execute

    'update karyawan yang bersangkutan
    ' karyawan.commandText = "UPDATE HRD_M_Karyawan SET Kry_ActiveAgenID = '"& cabang1 &"', Kry_JabCode = '"& jabatan1 &"', Kry_JJID = '"& jenjang1 &"', Kry_DDBID = '"& divisi1 &"' WHERE Kry_Nip = '"& nip &"'"

    karyawan.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../../layout/footer.asp' -->
