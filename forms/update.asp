<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<!-- #include file="../updateHrdLog.asp" -->

<% 
dim pengajuan, tglmasuk, nama, nip,nomor, radioStatus, jablama, jjlama, divlama, agenlama, jabatan, jenjang, agen, divisi, catatan

key = trim(Request.Form("key"))
pengajuan = CDate(Request.Form("tgl"))
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

set updatemutasi = Server.CreateObject("ADODB.Command")
updatemutasi.activeConnection = MM_Cargo_string

'make key 
pnip = left(nip, 3)
pthn = right(year(pengajuan), 2)
if month(pengajuan) <= 9 then
    ptgl = right("00"& month(pengajuan), 2)
else 
    ptgl = month(pengajuan)
end if 

set mutasi = Server.CreateObject("ADODB.Command")
mutasi.ActiveConnection = MM_cargo_STRING

set karyawan = Server.CreateObject("ADODB.Command")
karyawan.ActiveConnection = MM_cargo_STRING

mutasi.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"
' Response.Write mutasi.commandText & "<br>"
set mutasilama = mutasi.execute

if not mutasilama.eof then
    if radioStatus = "" then
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"
        ' Response.Write mutasi.commandText & "<BR>"
        mutasi.execute

    elseIf radioStatus = "1" then
        'karyawan demosi
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '1', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"', Mut_DemosiYN = 'Y' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"

        mutasi.execute

    elseIf radioStatus = "2" then
        'karyawan rotasi
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '2', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"

        mutasi.execute

    elseIf radioStatus = "3" then
        'karyawan promorsi
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '3', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"', Mut_DemosiYN = 'N' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"

        mutasi.execute

    elseIf radioStatus = "4" then
        'karyawan pensiun
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '4', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"

        mutasi.execute

        karyawan.commandText = "UPDATE HRD_M_karyawan SET Kry_AktifYN = 'N' WHERE Kry_Nip = '"& nip &"'"
        karyawan.execute
    elseIf radioStatus = "5" then
        'karyawan keluartanpa kabar 
        mutasi.commandText = "UPDATE HRD_T_Mutasi SET Mut_Tanggal = '"& pengajuan &"', Mut_Status = '5', Mut_NoSurat = '"& nomor &"', Mut_Memo = '"& catatan &"', Mut_TujAgenId = '"& agen &"', Mut_TujJabCode = '"& jabatan &"', Mut_TujJJID = '"& jenjang &"', Mut_TujDDBID = '"& divisi &"' WHERE Mut_ID = '"& key &"' AND Mut_Nip = '"& nip &"'"

        mutasi.execute

        karyawan.commandText = "UPDATE HRD_M_karyawan SET Kry_AktifYN = 'N' WHERE Kry_Nip = '"& nip &"'"
        karyawan.execute
    else
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Mohon Untuk Pilih Perubahan Status</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/forms/' class='btn btn-primary'>kembali</a></div>"
    end if
    
    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "UPDATE"
    pkey = key
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

    keterangan = "UPDATE "& nameRadio &" NOMOR "& key & " DENGAN KARYAWAN ("& nip &") "
    call updateLog(eventt,url,pkey,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
end if
%>
<!-- #include file='../layout/footer.asp' -->