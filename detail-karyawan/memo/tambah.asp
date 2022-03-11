<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim memo
dim nip, tgl,status, aktif, subject, memop, key

nip = Request.Form("nip")
tgl = Request.Form("tgl")
status = Request.Form("status")
' aktif = Request.Form("aktif")
subject = Ucase(Request.Form("subject"))
memop = Request.Form("memo")
key=left(nip,3) & right("00" & month(date),2) & right(year(date),2)

set memo = Server.CreateObject("ADODB.Command")
memo.activeConnection = MM_Cargo_String

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_String

memo.commandText = "SELECT * FROM HRD_T_MEMO WHERE Memo_ID = '"& key &"' and Memo_Nip = '"& nip &"'"
' Response.Write memo.commandtext
set memo = memo.execute

if memo.eof = true then

    tambah.commandText = "exec sp_ADDHRD_T_Memo '"& key &"', '"& nip &"', '"& status &"', '"& tgl &"', '"& subject &"', '"& memop &"'"
    ' Response.Write tambah.commandText
    tambah.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/memo.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/memo.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

end if

 %>
 <!-- #include file='../../layout/footer.asp' -->