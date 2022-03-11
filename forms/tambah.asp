<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<!-- #include file='../constend/constanta.asp' -->
<% 
dim pengajuan, tglmasuk, nama, nip,nomor, radioStatus, jablama, jjlama, divlama, agenlama, jabatan, jenjang, agen, divisi, catatan

pengajuan = CDate(Request.Form("tgl"))
tglmasuk = Request.Form("tglmasuk")
nama = trim(Request.Form("nama"))
nip = trim(Request.Form("nip"))
nomor = trim(Request.Form("nomor"))
radioStatus = trim(Request.Form("radioStatus"))
jablama = trim(Request.Form("jablama"))
jjlama = trim(Request.Form("jjlama"))
divlama = trim(Request.Form("divlama"))
agenlama = trim(Request.Form("agenlama"))
jabatan = trim(Request.Form("jabatan"))
jenjang = trim(Request.Form("jenjang"))
agen = trim(Request.Form("agen"))
divisi = trim(Request.Form("divisi"))
catatan = trim(Request.Form("catatan"))

'make key 
pnip = left(nip, 3)
pthn = right(year(pengajuan), 2)
if month(pengajuan) <= 9 then
    ptgl = "0"& month(pengajuan)
else 
    ptgl = month(pengajuan)
end if 

key = pnip & ptgl & pthn

set mutasi = Server.CreateObject("ADODB.Command")
mutasi.ActiveConnection = MM_cargo_STRING

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.ActiveConnection = MM_cargo_STRING

mutasi.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_Nip = '"& nip &"' AND month(Mut_tanggal) = '"& month(pengajuan) &"' AND Year(Mut_tanggal) = '"& year(pengajuan) &"' AND Mut_Status = '"& radioStatus &"' AND Mut_NoSurat = '"& nomor &"' AND Mut_AsalAgenID = '"& agenlama &"' AND Mut_AsalJabCode = '"& jablama &"' AND Mut_AsalJJID = '"& jjlama &"' AND Mut_AsalDDBID = '"& divlama &"' AND Mut_tujAgenID = '"& agen &"' AND Mut_TujJabCode = '"& jabatan &"' AND Mut_TujJJID = '"& jenjang &"' AND Mut_TujDDBID = '"& divisi &"' AND Mut_Memo = '"& catatan &"'"
' Response.Write mutasi.commandText & "<br>"
set mutasilama = mutasi.execute

if mutasilama.eof then
    'karyawan mutasi
    if radioStatus = "" then
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        
        mutasi.execute

        'update karyawan yang bersangkutan
        ' karyawan.commandText = "UPDATE HRD_M_Karyawan SET Kry_AgenID = '"& agen &"', Kry_JabCode = '"& jabatan &"', Kry_JJID = '"& jenjang &"', Kry_DDBID = '"& divisi &"' WHERE Kry_Nip = '"& nip &"'"
        ' Response.Write karyawan.commandText & "<br>"
        ' karyawan.execute

    elseIf radioStatus = "1" then
        'karyawan demosi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '1', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "

        mutasi.execute

        'update demosi
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_DemosiYN = 'Y' WHERE Mut_Nip = '"& nip &"'"
        mutasi.execute

        'update karyawan yang bersangkutan
        ' karyawan.commandText = "UPDATE HRD_M_Karyawan SET Kry_AgenID = '"& agen &"', Kry_JabCode = '"& jabatan &"', Kry_JJID = '"& jenjang &"', Kry_DDBID = '"& divisi &"', Kry_UpdateID = '"& session("username") &"', Kry_UpdateTIme = '"& now() &"' WHERE Kry_Nip = '"& nip &"'"

        ' karyawan.execute

    elseIf radioStatus = "2" then
        'karyawan rotasi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '2', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "

        mutasi.execute

        'update karyawan yang bersangkutan
        ' karyawan.commandText = "UPDATE HRD_M_Karyawan SET Kry_JabCode = '"& jabatan &"', Kry_JJID = '"& jenjang &"', Kry_DDBID = '"& divisi &"', Kry_AgenID = '"& agen &"' WHERE Kry_Nip = '"& nip &"'"

        ' karyawan.execute

    elseIf radioStatus = "3" then
        'karyawan promorsi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '3', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "

        mutasi.execute

        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_DemosiYN = 'N' WHERE Mut_Nip = '"& nip &"'"
        mutasi.execute

        'update karyawan yang bersangkutan
        ' karyawan.commandText = "UPDATE HRD_M_Karyawan SET Kry_AgenID = '"& agen &"', Kry_JabCode = '"& jabatan &"', Kry_JJID = '"& jenjang &"', Kry_DDBID = '"& divisi &"' WHERE Kry_Nip = '"& nip &"'"

        ' karyawan.execute

    elseIf radioStatus = "4" then
        'karyawan pensiun
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '4', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "

        mutasi.execute

        ' karyawan.commandText = "UPDATE HRD_M_karyawan SET Kry_AktifYN = 'N' WHERE Kry_Nip = '"& nip &"'"
        ' karyawan.execute
    elseIf radioStatus = "5" then
        'karyawan keluartanpa kabar 
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '5', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "

        mutasi.execute

        ' karyawan.commandText = "UPDATE HRD_M_karyawan SET Kry_AktifYN = 'N' WHERE Kry_Nip = '"& nip &"'"
        ' karyawan.execute
    else
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Mohon Untuk Pilih Perubahan Status</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/forms' class='btn btn-primary'>kembali</a></div>"
    end if
    
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/forms' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/forms/view_tambah.asp' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!-- #include file='../layout/footer.asp' -->