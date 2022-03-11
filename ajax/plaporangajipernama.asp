<!-- #include file='../connection.asp' -->
<% 
dim gaji, insentif, id, nip, tgl, thr, transport, kesehatan,Keluarga, jabatan, asuransi, jamsostek, pph21, koperasi, klaim
dim salary_cmd,salary

id = Request.Form("id")
nip = Request.Form("nip")
tgl = Request.Form("tgl")
gaji = Request.Form("gaji")
insentif = Request.Form("insentif")
thr = Request.Form("thr")
transport = Request.Form("transport")
kesehatan = Request.Form("kesehatan")
keluarga = Request.Form("keluarga")
jabatan = Request.Form("jabatan")
asuransi = Request.Form("asuransi")
jamsostek = Request.Form("jamsostek")
pph21 = Request.Form("pph21")
koperasi = Request.Form("koperasi")
klaim = Request.Form("klaim")
absen = Request.Form("absen")
lain = Request.Form("lain")

set salary_cmd = Server.CreateObject("ADODB.COmmand")
salary_cmd.ActiveConnection = MM_Cargo_string

salary_cmd.commandText = "SELECT * FROM HRD_T_Salary_Convert WHERE Sal_ID = '"& id &"'"
' Response.Write salary_cmd.commandText
set salary =  salary_cmd.execute

if salary.eof then
    salary_cmd.commandText = "INSERT INTO HRD_T_Salary_COnvert (Sal_ID, Sal_Nip, Sal_StartDate, Sal_Gapok, Sal_Insentif, Sal_TunjTransport, Sal_TunjKesehatan, Sal_TunjKeluarga, Sal_TunjJbt, Sal_Jamsostek, Sal_PPh21, Sal_Koperasi, Sal_Klaim, Sal_Asuransi, Sal_Absen, Sal_Lain, Sal_THR) VALUES ('"& id &"', '"& nip &"', '"& tgl &"', '"& gaji &"', '"& insentif &"', '"& transport &"', '"& kesehatan &"', '"& keluarga &"', '"& jabatan &"', '"& jamsostek &"', '"& pph21 &"', '"& koperasi &"', '"& klaim &"', '"& asuransi &"', '"& absen &"', '"& lain &"', '"& thr &"')"
    ' Response.Write salary_cmd.commandText
    salary_cmd.execute
    Response.Write "DATA BERHASIL TERCONVERT MOHON HAPUS KEMBALI JIKA SUDAH TERLIHAT DENGAN CARA MENEKAN TOMBOL REFRESH!!!"
else
    Response.Write "DATA SUDAH TERCONVERT BISA LANGSUNG ANDA CEK DI LAPORAN"
end if
 %>