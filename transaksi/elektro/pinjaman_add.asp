<!-- #include file='../../connection.asp' -->
<!-- #include file='../../constend/constanta.asp' -->
    <!--link aos -->
    <!-- #include file='../../layout/header.asp' -->
<% 
dim pinjaman_cmd, pinjaman
dim id, tgl, nip, keterangan, bunga, lama, kode,hutang, thutang

id = Request.Form("id")
tgl = Request.Form("tgl")
nip = Request.Form("nip")
hutang = replace(replace(replace(Request.Form("hutang"),".",""),"-",""),",","")
thutang = replace(replace(replace(Request.Form("tpinjaman"),".",""),"-",""),",","")
bunga = Request.Form("bunga")
lama = Request.Form("lama")

kode = mid(nip,1,3)

keterangan = "Elektronik Ke"

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = mm_cargo_String

set pinjaman_cmd = Server.CreateObject("ADODB.Command")
pinjaman_cmd.activeConnection = mm_cargo_String

pinjaman_cmd.commandText = "SELECT * FROM HRD_T_PK WHERE TPK_Nip = '"& nip &"' and TPK_Tanggal = '"& tgl &"' and TPK_ket ='"& keterangan &"' and TPK_AktifYN = 'Y'"
set pinjaman = pinjaman_cmd.execute

if pinjaman.eof then
    karyawan_cmd.commandText = "SELECT ISNULL(COUNT(TPK_ID), 0) + 1 AS ke FROM HRD_T_PK WHERE TPK_Nip = '"& nip &"' AND (TPK_AktifYN = 'Y') AND (TPK_Ket LIKE '%"& keterangan &"%')"
    ' Response.Write karyawan_cmd.commandText & "<br>"
    set karyawan = karyawan_cmd.execute

    ke = karyawan("ke")

    pinjaman_cmd.commandText = "exec sp_AddHRD_T_PK '"& kode &"','"& tgl &"','"& nip &"','"& keterangan&"-"&ke&"',"& hutang &","& bunga &","& lama &",'"& session("username") &"'"
    ' Response.Write pinjaman_cmd.commandText
    pinjaman_cmd.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='pinjaman.asp' class='btn btn-primary'>kembali</a></div>"
end if



 %>
<!--#include file="../../layout/footer.asp"-->