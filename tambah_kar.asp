<!--#include file="Connection.asp" -->
<!--#include file="layout/header.asp"-->
    
<% 
dim nip, nama, alamat, kelurahan, bpjs, tlp1, tlp2, kota, pos, tmpt, tglL, email, agama, jkelamin, ssosial, janak, tanggungan, pendidikan, spegawai, saudara, anakke, IDID, norek, pegawai, activeId, jabatan, jenjang, divisi, jcuti, ktp, npwp, tglmasuk, tglkeluar, tglagaji, tglegaji, jsim, nsim, kesehatan, jamsostek, berlakuSIM
dim tambah

'koneksi data
set tambah_cmd = server.createObject("ADODB.Command")
tambah_cmd.ActiveConnection = MM_Cargo_string

nama = trim(Ucase(request.form("nama")))
alamat = trim(request.form("alamat"))
kelurahan = trim(request.form("kelurahan"))
email = trim(request.form("email"))
bpjs = trim(request.form("bpjs"))
tlp1 = trim(request.form("tlp1"))
tlp2 = trim(request.form("tlp2"))
kota = trim(request.form("kota"))
pos = trim(request.form("pos"))
tmpt = trim(request.form("tempat"))
tglL = trim(Cdate(request.form("tglL")))
pendidikan = trim(request.form("pendidikan"))
agama = trim(request.form("agama"))
jkelamin = trim(request.form("jkelamin"))
ssosial = trim(request.form("ssosial"))
janak = trim(request.form("janak"))
tanggungan = trim(request.form("tanggungan"))
spegawai = trim(request.form("spegawai"))
jcuti = trim(request.form("jcuti"))
saudara = trim(request.form("saudara"))
anakke = trim(request.form("anakke"))
bank = trim(request.form("bankID"))
norek = trim(request.form("norek"))
pegawai = trim(request.form("pegawai"))
noJp = "0" 'ini ga tau apa datanya, nnti tanya ke HRD aja
subcabang = trim(request.form("areaAktif"))
jabatan = trim(request.form("jabatan"))
jenjang = trim(request.form("jenjang"))
divisi = trim(request.form("divisi"))
tenagakerja = trim(request.form("tenagakerja"))
ktp = trim(request.form("ktp"))
npwp = trim(request.form("npwp"))
tglmasuk = trim(Cdate(request.form("tglmasuk")))
tglkeluar = trim(request.form("tglkeluar"))
tglagaji = trim(request.form("tglagaji"))
tglegaji = trim(request.form("tglegaji"))
jsim = trim(request.form("jsim"))
nsim = trim(request.form("nsim"))
kesehatan = trim(request.form("kesehatan"))
berlakusim = trim(request.form("berlakuSIM"))
bpjskes = trim(request.form("bpjskes"))


'cek nip
ppegawai = Right("000" & pegawai, 3)

'jika kosong tgl akhir gaji
ptglegaji = ""
if tglegaji <> "" then
    ptglegaji = tglegaji
end if

'jika kosong tgl keluar karyawan
ptglkeluar = ""
if tglkeluar <> "" then
    ptglkeluar = tglkeluar
end if

'jika kosong tgl berlaku sim
pberlakusim = ""
if berlakusim <> "" then
    pberlakusim = berlakusim
end if

tambah_cmd.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_Nama = '"& nama &"' and Kry_Addr1 = '"& alamat &"' And Kry_Addr2 = '"& kelurahan &"' And Kry_kota = '"& kota &"' AND Kry_TglMasuk = '"& tglmasuk &"' AND Kry_Telp1 = '"& tlp1 &"' AND Kry_Telp2 = '"& tlp2 &"' AND Kry_TglLahir = '"& tglL &"' AND Kry_TmpLahir = '"& tmpt &"' AND Kry_AgamaID = '"& agama &"' AND Kry_JabCode = '"& jabatan &"' AND Kry_DDBID = '"& divisi &"'"
set tambah = tambah_cmd.execute

if tambah.eof then
    tambah_cmd.commandText = "exec sp_AddHrd_M_Karyawan_web '"& ppegawai &"','"& divisi &"','"& subcabang &"','"& subcabang &"','"& jabatan &"','',"& jenjang &",'"& nama &"','"& alamat &"','"& kelurahan &"','"& kota &"','"& pos &"','"& tlp1 &"','"& tlp2 &"','','"& email &"','"& jkelamin &"','"& tmpt &"','"& tglL &"',"& ssosial &","& janak &","& saudara &","& anakke &","& agama &","& pendidikan &",'"& ktp &"','','','"& nsim &"','"& jsim &"','','','',"& tanggungan &","& jcuti &",'"& tglmasuk &"','','"& tglagaji &"','', '','','','','',"& bank &",'"& norek &"','',"& spegawai &",'','','','','Y','"& session("username") &"','','"& npwp &"','"&tenagakerja &"','','"& bpjs &"','"& kesehatan &"','"& bpjskes &"',"& pegawai &",'"& noJP &"','','','','','','','',''"
    ' Response.Write tambah.commandText
    tambah_cmd.execute
else 
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='logo/gagal_dakota.png'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
end if

 Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"

 %> 

<!--#include file="layout/footer.asp"-->