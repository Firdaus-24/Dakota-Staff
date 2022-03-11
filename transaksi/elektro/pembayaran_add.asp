<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tgl, nip, nama, keterangan, cicilan, id
dim tambah,tambah_cmd, kode

tgl = Trim(Request.Form("tgl"))
nip = Trim(Request.form("nip"))
nama = Trim(Request.form("nama"))
keterangan = Trim(Request.form("keterangan"))
inplama = trim(Request.Form("inplama"))
id = Trim(Request.form("id"))
pembayaranke = Trim(Request.form("pembayaranke"))
cicilan = replace(replace(replace(Request.form("cicilan"),",",""),"-",""),".","")

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = mm_cargo_string

set tambah_cmd = Server.CreateObject("ADODB.Command")
tambah_cmd.activeConnection = mm_cargo_string

tambah_cmd.commandText = "SELECT * FROM HRD_T_BK WHERE TPK_Tanggal = '"& tgl &"' AND TPK_Nip = '"& nip &"' AND TPK_Ket = '"& keterangan &"'"
set tambah = tambah_cmd.execute

kode = mid(nip,1,3)

if tambah.eof then
    tambah_cmd.commandText = "exec sp_AddHRD_T_BK '"& kode &"','"& tgl &"','"& nip &"','"& keterangan&"','"& cicilan &"','"& id &"'"
    ' Response.Write tambah_cmd.commandText & "<br>"
    tambah_cmd.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pembayaran.asp' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!--#include file="../../layout/footer.asp"-->