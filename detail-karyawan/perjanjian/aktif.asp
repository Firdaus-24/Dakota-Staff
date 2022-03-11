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
    tambah.commandText = "UPDATE HRD_T_SPK SET SPK_AktifYN = 'N' WHERE SPK_ID = '"& id &"' and SPK_Nip = '"& nip &"'"
    ' Response.Write tambah.commandText
    tambah.execute
else
    tambah.commandText = "UPDATE HRD_T_SPK SET SPK_AktifYN = 'Y' WHERE SPK_ID = '"& id &"' and SPK_Nip = '"& nip &"'"
    ' Response.Write tambah.commandText
    tambah.execute
end if
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/perjanjian.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
 %>
<!-- #include file='../../layout/footer.asp' -->