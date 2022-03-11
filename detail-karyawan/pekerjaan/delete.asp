<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim id , nama
dim delete

id = Request.QueryString("id")
nama = Request.QueryString("nama")

set delete = Server.CreateObject("ADODB.COmmand")
delete.activeConnection = MM_Cargo_String

delete.commandText = "DELETE FROM HRD_T_HistKerja WHERE HK_Nip = '"& id &"' and HK_NamaPT = '"& nama &"'"
' Response.Write delete.commandText
delete.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pekerjaan.asp?nip="& id &"' class='btn btn-primary'>kembali</a></div>"

 %>


<!-- #include file='../../layout/footer.asp' -->