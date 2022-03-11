<% 
if session("username") = "" then
response.Redirect("../../login.asp")
end if
 %>
<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim update_cmd
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

id = Request.Form("id")
nomor = Request.Form("nomor")
tgl = Request.Form("tgl")
nip = Request.Form("nip")
keterangan = Request.Form("keterangan")
hutang = replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",","")
thutang = replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",","")
bunga = replace(replace(replace(Request.Form("bunga"),".",""),"-",""),",","")
lama = Request.Form("lama")
cicilan = replace(replace(replace(Request.Form("cicilan"),".",""),"-",""),",","")

set update_cmd = Server.CreateObject("ADODB.Command")
update_cmd.activeConnection = mm_cargo_String

update_cmd.commandText = "UPDATE HRD_T_PK SET TPK_ID = '"& nomor &"', TPK_Tanggal = '"& tgl &"', TPK_Nip = '"& nip &"', TPK_ket = '"& keterangan &"', TPK_PP = '"& hutang &"', TPK_Bunga = '"& bunga &"', TPK_Lama = '"& lama &"', TPK_updateID = '"& id &"', TPK_UpdateTIme = '"& date() &"' WHERE TPK_ID = '"& nomor &"'"
' Response.Write update_cmd.commandText
update_cmd.execute

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/transaksi/pinjaman/pinjamanKaryawan.asp' class='btn btn-primary'>kembali</a></div>"

 %>
 <!-- #include file='../../layout/footer.asp' -->