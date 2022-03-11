<!--#include file="../../connection.asp"-->
<!--#include file="../../layout/header.asp"-->
<% 
dim nip, nama, alamat, kelurahan, bpjs, tlp1, tlp2, kota, pos, tmpt, tglL, email, agama, jkelamin, ssosial, janak, tanggungan, pendidikan, spegawai, saudara, anakke, bankID, norek, pegawai, activeId, jabatan, jenjang, divisi, jcuti, nKTP, npwp, tglmasuk, tglkeluar, tglagaji, tglegaji, jsim, nsim, kesehatan, jamsostek, berlakuSIM
dim update, tglawal, tglakhir
dim keluarlagi

set bpjs_cmd = Server.CreateObject("ADODB.Command")
bpjs_cmd.ActiveConnection = MM_cargo_STRING

set update = Server.CreateObject("ADODB.Command")
update.ActiveConnection = MM_cargo_STRING

nip = trim(request.form("nip"))
nama = trim(request.form("nama"))
alamat = trim(request.form("alamat"))
kelurahan = trim(request.form("kelurahan"))
bpjs = trim(request.form("bpjs"))
tlp1 = trim(request.form("tlp1"))
tlp2 = trim(request.form("tlp2"))
kota = trim(request.form("kota"))
pos = trim(request.form("pos"))
tmpt = trim(request.form("tmpt"))
tglL = trim(request.form("tglL"))
email = trim(request.form("email"))
agama = trim(request.form("agama"))
jkelamin = trim(request.form("jkelamin"))
ssosial = trim(request.form("ssosial"))
janak = trim(request.form("janak"))
tanggungan = trim(request.form("tanggungan"))
pendidikan = trim(request.form("pendidikan"))
spegawai = trim(request.form("spegawai"))
saudara = trim(request.form("saudara"))
anakke = trim(request.form("anakke"))
bankID = trim(request.form("bankID"))
norek = trim(request.form("norek"))
pegawai = trim(request.form("pegawai"))
SubCabang = trim(request.form("ActiveId"))
jabatan = trim(request.form("jabatan"))
jenjang = trim(request.form("jenjang"))
divisi = trim(request.form("divisi"))
jcuti = trim(request.form("jcuti"))
nKTP = trim(request.form("nKTP"))
npwp = trim(request.form("npwp"))
tglmasuk = replace(trim(request.form("tglmasuk")),"'","")
tglkeluar = trim(request.form("tglkeluar"))
tglagaji = trim(request.form("tglagaji"))
tglegaji = trim(request.form("tglegaji"))
jsim = trim(request.form("jsim"))
nsim = trim(request.form("nsim"))
kesehatan = trim(request.form("kesehatan"))
jamsostek = trim(request.form("jamsostek"))
berlakuSIM = trim(request.form("berlakuSIM"))
bpjskes = trim(request.form("bpjskes"))
atasan1 = trim(Request.Form("atasan1"))
atasan2 = trim(Request.Form("atasan2"))

update.commandText = "UPDATE HRD_M_Karyawan SET  Kry_Nip = '"& nip &"', Kry_DDBID = '"& divisi &"', Kry_Sex='"& jkelamin &"',Kry_AgenID ='"& SubCabang &"', Kry_JabCode = '"& jabatan &"',Kry_JJID = '"& jenjang &"', Kry_Nama = '"& nama &"', Kry_Addr1 = '"& alamat &"', Kry_Addr2 = '"& kelurahan &"', Kry_Kota = '"& kota &"', Kry_KdPos = '"& pos &"', Kry_Telp1 = '"& tlp1 &"', Kry_Telp2 = '"& tlp2 &"', Kry_Fax ='"& email &"', Kry_TmpLahir = '"& tmpt &"', Kry_TglLahir = '"& tglL &"', Kry_SttSosial = '"& ssosial &"', Kry_JmlAnak ='"& janak &"', Kry_JmlSaudara ='"& saudara &"', Kry_AnakKe = '"& anakke &"', Kry_AgamaID = '"& agama &"', Kry_JDdkID = '"& pendidikan &"', Kry_NoID = '"& nKTP &"', Kry_NoSIM = '"& nsim &"', Kry_JnsSIM = '"& jsim &"', Kry_SIMValidDate = '"& berlakuSIM &"', Kry_JmlTanggungan = '"& tanggungan &"', Kry_JmlCuti = '"& jcuti &"', Kry_TglMasuk = '"& tglmasuk &"', Kry_tglKeluar = '"& tglkeluar &"', Kry_tglStartGaji =  '"&tglagaji &"', Kry_TglEndGaji = '"& tglegaji &"', Kry_BankID = '"& bankID &"', Kry_NoRekening = '"& norek &"', Kry_SttKerja = '"& spegawai &"', Kry_NPWP = '"& npwp &"', Kry_NoJamsostek = '"& jamsostek &"', Kry_BPJSYN = '"& bpjs &"', Kry_NoBPJS = '"& kesehatan &"' , Kry_Pegawai = '"& pegawai &"', Kry_BPJSKesYN = '"& bpjskes &"', Kry_atasanNip1 = '"& atasan1 &"', Kry_atasanNip2 = '"& atasan2 &"' WHERE Kry_Nip = '"& nip &"'"
' Response.Write update.commandText
update.execute

' update bpjsYN
bpjs_cmd.commandText = "SELECT * FROM HRD_T_MutasiBPJS WHERE Mut_KRYNip = '"& nip &"' AND month(Mut_Tanggal) = '"& month(now) &"' AND year(Mut_tanggal) = '"& year(now) &"' AND Mut_AktifYN = 'Y'"

set bpjsAdd = bpjs_cmd.execute

    if bpjsAdd.eof then
        bpjs_cmd.commandText = "exec sp_ADDHRD_T_MutasiBPJS "& pegawai &",'"& nip &"','"& bpjskes &"','"& bpjs &"','"& date &"','"& session("username") &"'"
        ' Response.Write bpjs_cmd.commandText & "<br>"
        bpjs_cmd.execute
        
    else
        bpjs_cmd.commandText = "UPDATE HRD_T_MutasiBPJS SET Mut_BPJSKes = '"& bpjskes &"', Mut_BPJSKet = '"& bpjs &"', Mut_Tanggal = '"& date &"', Mut_UpdateID = '"& session("username") &"' WHERE Mut_KryNip = '"& nip &"'"
        ' Response.Write bpjs_cmd.commandText & "<br>"
        bpjs_cmd.execute
    end if
dim id
id = Request.QueryString("nip")
'Response.Write id

Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='../index.asp?nip="& id &"' class='btn btn-primary'>kembali</a></div>"

 %> 
<!--#include file="../../layout/footer.asp"-->