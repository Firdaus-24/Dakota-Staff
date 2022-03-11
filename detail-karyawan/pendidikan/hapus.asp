<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->

<% 
dim nip, nama, tahun
dim delete

nip = Request.QueryString("nip")
nama = Request.QueryString("nama")
tahun = Request.QueryString("tahun")

set delete = Server.CreateObject("ADODB.Command")
delete.activeConnection = MM_Cargo_String

delete.commandText = "DELETE FROM HRD_T_Didik1 WHERE Ddk1_Nip = '"& nip &"' and DDk1_Nama = '"& nama &"' and Ddk1_tahun1 = '"& tahun &"'"
delete.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Terhapus</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/pendidikan.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

 %>
 <!-- #include file='../../layout/footer.asp' -->