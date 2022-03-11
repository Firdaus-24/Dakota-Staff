<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tgl, id
dim delete

id = Request.QueryString("id")  
tgl = Request.QueryString("tgl")
nip = Request.QueryString("nip")

set delete = Server.CreateObject("ADODB.COmmand")
delete.activeConnection = MM_Cargo_string

delete.commandText  = "DELETE FROM HRD_T_StatusKaryawan WHERE SK_ID = '"& id &"' and SK_TglIn = '"& tgl &"'"
delete.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Terhapus</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/status.asp?nip="&nip &"' class='btn btn-primary'>kembali</a></div>"

 %>
 <!-- #include file='../../layout/footer.asp' -->