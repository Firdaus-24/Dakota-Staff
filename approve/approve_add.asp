<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
<% 
nip = trim(Cstr(Request.Form("nip")))
nip1 = trim(Request.Form("nip1"))
atasan = trim(Request.Form("atasan"))

str = Split(nip,",")

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = MM_Cargo_string

for each x in str
    if atasan = 1 then
        karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_atasanNip1 = '"& nip1 &"' WHERE Kry_Nip = '"& trim(x) &"'"
        karyawan_cmd.execute
    else
        karyawan_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_atasanNip2 = '"& nip1 &"' WHERE Kry_Nip = '"& trim(x) &"'"
        karyawan_cmd.execute
    end if
next
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../layout/footer.asp' -->