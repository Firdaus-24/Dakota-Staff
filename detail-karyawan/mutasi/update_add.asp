<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<!-- #include file='../../updateHrdLog.asp' -->
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

set tambah_cmd = Server.CreateObject("ADODB.Command")
tambah_cmd.activeConnection = MM_Cargo_string

tambah_cmd.commandText = "SELECT * FROM HRD_T_Mutasi WHERE Mut_ID = '"& notrans &"' AND Mut_Nip = '"& nip &"'"
' Response.Write tambah_cmd.commandText & "<br>"
set data = tambah_cmd.execute

if not data.eof then
    tambah_cmd.commandText = "UPDATE HRD_T_Mutasi SET Mut_Nip = '"& nip &"', Mut_Tanggal = '"& tgl &"', Mut_NoSurat = '"& nosurat &"', Mut_Memo = '"& memo &"', Mut_AsalAgenID = '"& agen &"', Mut_AsalJabCode = '"& jabatan &"', Mut_AsalJJID = '"& jenjang &"', Mut_AsalDDBID = '"& divisi &"', Mut_TujAgenID = '"& cabang1 &"', Mut_TujJabCode = '"& jabatan1 &"', Mut_TujJJID = '"& jenjang1 &"', Mut_TujDDBID = '"& divisi1 &"' WHERE Mut_ID = '"& notrans &"'"
    ' Response.Write tambah_cmd.commandText & "<br>"
    tambah_cmd.execute

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "UPDATE"
    key = notrans
    url = ""
    nameRadio = "MUTASI"

    keterangan = "UPDATE "& nameRadio &" "& notrans &" DENGAN KARYAWAN ("& nip &") "
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 


    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='../mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='../mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../../layout/footer.asp' -->
