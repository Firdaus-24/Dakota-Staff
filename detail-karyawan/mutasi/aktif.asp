<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
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
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/mutasi.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../../layout/footer.asp' -->