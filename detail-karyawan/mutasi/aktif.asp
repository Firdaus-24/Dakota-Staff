<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<!-- #include file='../../updateHrdLog.asp' -->
<% 
dim id, p 
dim tambah

id = Request.QueryString("id")
p = Request.QueryString("p")
nip = Request.QueryString("nip")
' Response.Write p
set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

if p = "Y" then
    tambah.commandText = "UPDATE HRD_T_Mutasi SET Mut_AktifYN = 'N' WHERE Mut_ID = '"& id &"' and Mut_Nip = '"& nip &"'"
    ' Response.Write tambah.commandText
    tambah.execute
else
    tambah.commandText = "UPDATE HRD_T_Mutasi SET Mut_AktifYN = 'Y' WHERE Mut_ID = '"& id &"' and Mut_Nip = '"& nip &"'"
    ' Response.Write tambah.commandText
    tambah.execute
end if

    'updateLog system
    ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    browser = Request.ServerVariables("http_user_agent")
    dateTime = now()
    eventt = "DELETE"
    key = id
    url = ""
    if p = "N" then
        text = "AKTIF"
    else
        text = "NONAKTIF"
    end if
    keterangan = text &" MUTASI KARYAWAN ("& nip &") NOMOR MUTASI "& id
    call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='../mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../../layout/footer.asp' -->