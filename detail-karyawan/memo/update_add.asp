<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim update
dim tgl, status, notrans, nip, subject, memo

tgl = Request.Form("tgl")
status = Request.Form("status")
notrans = Request.Form("notrans")
nip = Request.Form("nip")
subject = Request.Form("subject")
memo = Request.Form("memo")

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_String

update.commandText = "UPDATE HRD_T_Memo SET Memo_ID = '"& notrans &"', Memo_Nip = '"& nip &"', Memo_Tanggal = '"& tgl &"', Memo_status = '"& status &"', memo_subject = '"& subject &"', Memo_isi = '"& memo &"' WHERE Memo_id = '"& notrans &"' and Memo_Nip = '"& nip &"'"
' Response.Write update.commandText
update.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/memo.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

 %>


<!-- #include file='../../layout/footer.asp' -->