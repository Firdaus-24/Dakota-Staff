<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim nomor, tgl, nip, nama, keterangan, pp
dim update_cmd, update

nomor = trim(Request.Form("nomor"))
tgl = trim(Request.Form("tgl"))
nip = trim(Request.Form("nip"))
keterangan = trim(Request.Form("keterangan"))
pp = trim(replace(replace(replace(Request.Form("cicilan"),"-",""),".",""),",",""))
id = trim(Request.Form("id"))

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_string

update_cmd.commandText = "UPDATE HRD_T_BK SET TPK_ID = '"& nomor &"', TPK_Tanggal = '"& tgl &"', TPK_Nip = '"& nip &"', TPK_Ket = '"& keterangan &"', TPK_PP = "& pp &", TPK_AktifYN = 'Y', TPK_UpdateID = '"& id &"', TPK_UpdateTime = GETDATE() WHERE TPK_ID = '"& nomor &"' and TPK_Nip = '"& nip &"'"
update_cmd.execute
Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
 %>
  <!-- #include file='../../layout/footer.asp' -->