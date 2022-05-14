<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<!-- #include file="../updateHrdLog.asp" -->
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
ptgl = right("00" & month(pengajuan),2)
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
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")
    elseIf radioStatus = "1" then
        'karyawan demosi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '1', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")

        ' 'update demosi
        ' mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_DemosiYN = 'Y' WHERE Mut_Nip = '"& nip &"'"
        
        ' mutasi.execute

    elseIf radioStatus = "2" then
        'karyawan rotasi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '2', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")

    elseIf radioStatus = "3" then
        'karyawan promorsi
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '3', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")

        ' mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_DemosiYN = 'N' WHERE Mut_Nip = '"& nip &"'"

        ' set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")

    elseIf radioStatus = "4" then
        'karyawan pensiun
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '4', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")
    elseIf radioStatus = "5" then
        'karyawan keluartanpa kabar 
        mutasi.commandText = "exec sp_ADDHRD_T_Mutasi '"& key &"', '"& nip &"', '"& pengajuan &"', '5', '"& nomor &"', '"& catatan &"', '"& agenlama &"', '"& jablama &"', '"& jjlama &"', '"& divlama &"', '"& agen &"', '"& jabatan &"', '"& jenjang &"', '"& divisi &"' "
        ' Response.Write mutasi.commandText & "<br>"
        set mutasi = mutasi.execute 

        mutasiid = mutasi("ID")
    else
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Mohon Untuk Pilih Perubahan Status</span><img src='../logo/berhasil_dakota.PNG'><a href='view_tambah.asp' class='btn btn-primary'>kembali</a></div>"
    end if

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "CREATE"
    key = mutasiid
    url = ""
    if radioStatus = "" then
        nameRadio = "MUTASI"
    elseIf radioStatus = "1" then
        nameRadio = "DEMOSI"
    elseIf radioStatus = "2" then
        nameRadio = "ROTASI"
    elseIf radioStatus = "3" then
        nameRadio = "PROMOSI"
    elseIf radioStatus = "4" then
        nameRadio = "PENSIUN"
    else
        nameRadio = "KELUAR TANPA SEBAB"
    end if

    keterangan = "TAMBAH "& nameRadio &" KARYAWAN ("& nip &") / UNTUK DIPROSES TANGGAL " & pengajuan
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='view_tambah.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='view_tambah.asp' class='btn btn-primary'>kembali</a></div>"
end if
%>
 
<!-- #include file='../layout/footer.asp' -->