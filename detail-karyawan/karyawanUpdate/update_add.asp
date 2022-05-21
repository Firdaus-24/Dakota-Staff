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

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.ActiveConnection = MM_cargo_STRING

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
vaksin = trim(Request.Form("vaksin"))
goldarah = trim(Request.Form("goldarah"))


karyawan_cmd.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
set karyawan = karyawan_cmd.execute

if not karyawan.eof then

    oldNama = karyawan("Kry_Nama")
    oldDDBID = karyawan("Kry_DDBID")
    oldActiveAgenID = karyawan("Kry_ActiveAgenID")
    oldJabCode = karyawan("Kry_JabCode")
    oldJJID = karyawan("Kry_JJID")
    oldAddr1 = karyawan("Kry_Addr1")
    oldAddr2 = karyawan("Kry_Addr2")
    oldKota = karyawan("Kry_Kota")
    oldKdPos = karyawan("Kry_KdPos")
    oldTelp1 = karyawan("Kry_Telp1")
    oldTelp2 = karyawan("Kry_Telp2")
    oldPager = karyawan("Kry_Pager")
    oldFax = karyawan("Kry_Fax")
    oldSex = karyawan("Kry_Sex")
    oldTmpLahir = karyawan("Kry_TmpLahir")
    oldTglLahir = karyawan("Kry_TglLahir")
    oldSttSosial = karyawan("Kry_SttSosial")
    oldJmlAnak  = karyawan("Kry_JmlAnak")
    oldJmlSaudara = karyawan("Kry_JmlSaudara")
    oldAnakKe = karyawan("Kry_AnakKe")
    oldAgamaID = karyawan("Kry_AgamaID")
    oldjDdkID = karyawan("Kry_JDdkID")
    oldNoID = karyawan("Kry_NoID")
    oldJnsID = karyawan("Kry_JnsID")
    oldIDValidDate = karyawan("Kry_IDValidDate")
    oldNoSIM = karyawan("Kry_NoSim")
    oldSIMValidDate = karyawan("Kry_SIMValidDate")
    oldJsSIM = karyawan("Kry_JnsSIM")
    oldJmlTanggungan = karyawan("Kry_JmlTanggungan")
    oldJmlCuti = karyawan("Kry_JmlCuti")
    oldTglMasuk = karyawan("Kry_TglMasuk")
    oldTglKeluar = karyawan("Kry_TglKeluar")
    oldTglStartGaji = karyawan("Kry_TglStartGaji")
    oldTglEndGaji = karyawan("Kry_TglEndGaji")
    oldPembayaranGaji = karyawan("Kry_PembayaranGaji")
    oldJmlHariKerja = karyawan("Kry_JmlHariKerja")
    oldBankID = karyawan("Kry_BankID")
    oldNoRekening = karyawan("Kry_NoRekening")
    oldSttKerja = karyawan("Kry_SttKerja")
    oldAktifYN = karyawan("Kry_AktifYN")
    oldUpdateID = karyawan("Kry_UpdateID")
    oldUpdateTime = karyawan("Kry_UpdateTime")
    oldNPWP = karyawan("Kry_NPWP")
    oldNoJamsostek = karyawan("Kry_NoJamsostek")
    oldBPJSYN = karyawan("Kry_BPJSYN")
    oldNoBPJS = karyawan("Kry_NoBPJS")
    oldPegawai = karyawan("Kry_Pegawai")
    oldatasanNip1 = karyawan("Kry_atasanNip1")
    oldatasanNip2 = karyawan("Kry_atasanNip2")
    oldJenisVaksin = karyawan("Kry_JenisVaksin")
    oldgolDarah = karyawan("Kry_golDarah")
    oldBPJSKesYN = karyawan("Kry_BPJSKesYN")
    


    

    '  nama
    if oldNama <> nama THEN 
        rubahnama = "PERUBAHAN NAMA DARI " & oldNama & " KE " & nama & ","
    else 
        rubahnama = ""
    end if 
   
    '  alamat
    if oldAddr1 <> alamat THEN 
        rubahalamat = "PERUBAHAN ALAMAT DARI " & oldAddr1 & " KE " & alamat & ","
    else 
        rubahalamat = ""
    end if 
    ' keluarahan
    if oldAddr2 <> kelurahan THEN 
        rubahkelurahan = "PERUBAHAN KELUARAHAN DARI " & oldAddr2 & " KE " & kelurahan  &","
    else 
        rubahkelurahan = ""
    end if 
    ' bpjs
    if oldBPJSYN <> bpjs THEN 
        rubahbpjs = "PERUBAHAN BPJS DARI " & oldBPJSYN & " KE " & bpjs  &","
    else 
        rubahbpjs = ""
    end if 
    ' tlp1
    if oldTelp1 <> "" THEN
        if oldTelp1 <> tlp1 THEN 
            rubahtelp1 = "PERUBAHAN TELP1 DARI " & OldTelp1 & " KE " & Tlp1  &","
        else 
            rubahtelp1 = ""
        end if 
    end if
    ' tlp2
    if oldTelp2 <> "" THEN

            if oldTelp2 <> tlp2 THEN 
                rubahtelp2 = "PERUBAHAN TELP2 DARI " & OldTelp2 & " KE " & Tlp2  &","
            else 
                rubahtelp2 = ""
            end if 
    end if
    ' kota
    if oldKota <> kota THEN 
        rubahkota = "PERUBAHAN KOTA DARI " & OldKota & " KE " & kota  &","
    else 
        rubahkota = ""
    end if 
    ' pos
    if oldKdPos <> pos THEN 
        rubahpos = "PERUBAHAN POS DARI " & OldKdPos & " KE " & Pos  &","
    else 
        rubahpos = ""
    end if 
    ' tmpt
    if oldTmpLahir <> tmpt THEN 
        rubahtlahir = "PERUBAHAN TEMPAT LAHIR DARI " & OldTmpLahir & " KE " & tmpt  &","
    else 
        rubahtlahir = ""
    end if 
    ' tglL
    if oldTglLahir <> Cdate(tglL) THEN 
        rubahtglLahir = "PERUBAHAN TANGGAL LAHIR DARI " & OldTglLahir & " KE " & tglL  &","
    else 
        rubahtglLahir = ""
    end if 
    
    ' email
    if oldFax <> email THEN 
        rubahfax = "PERUBAHAN EMAIL DARI " & OldFax & " KE " & email  &","
    else 
        rubahfax = ""
    end if 
    ' response.write rubahemail & "<br>"
    ' agama
    if oldAgamaID <> CInt(agama) THEN 
        rubahagama = "PERUBAHAN AGAMA DARI " & oldAgamaID & " KE " & agama  &","
    else 
        rubahagama = ""
    end if 
    
    ' jkelamin
    if oldSex <> jkelamin THEN 
        rubahsex = "PERUBAHAN JENIS KELAMIN DARI " & oldSex & " KE " & jkelamin  &","
    else 
        rubahsex = ""
    end if 
    

    ' response.write rubahsex & "<br>"
    ' ssosial
    if oldSttSosial <> CInt(ssosial) THEN 
        rubahsttsosial = "PERUBAHAN STATUS SOSIAL DARI " & oldSttSosial & " KE " & ssosial  &","
    else 
        rubahsttsosial = ""
    end if 
    ' janak
    if oldJmlAnak <> CInt(janak) THEN 
        rubahanak = "PERUBAHAN JUMLAH ANAK DARI " & oldJmlAnak & " KE " & janak  &","
    else 
        rubahanak = ""
    end if 
    ' tanggungan
    if oldJmlTanggungan <> CInt(tanggungan) THEN 
        rubahtanggungan = "PERUBAHAN TANGGUNGAN DARI " & oldJmlTanggungan & " KE " & tanggungan  &","
    else 
        rubahtanggungan = ""
    end if 
    ' pendidikan
    if oldjDdkID <> CInt(pendidikan) THEN 
        rubahpendidikan = "PERUBAHAN PENDIDIKAN DARI " & oldjDdkID & " KE " & pendidikan  &","
    else 
        rubahpendidikan = ""
    end if 

    ' spegawai
    if oldSttKerja <> CInt(spegawai) THEN 
        rubahpegawai = "PERUBAHAN SPEGAWAI DARI " & oldSttKerja & " KE " & spegawai  &","
    else 
        rubahpegawai = ""
    end if 
    ' saudara
    if oldJmlSaudara <> CInt(saudara) THEN 
        rubahsaudara = "PERUBAHAN JUMLAH SAUDARA DARI " & oldJmlSaudara & " KE " & saudara  &","
    else 
        rubahsaudara = ""
    end if 
    ' anakke
    if oldAnakKe <> CInt(anakke) THEN 
        rubahanake = "PERUBAHAN ANAK KE- DARI " & oldAnakKe & " KE " & anakke  &","
    else 
        rubahanake = ""
    end if 
    ' bankID
    if oldBankID <> CInt(bankID) THEN 
        rubahbankid = "PERUBAHAN BANK ID DARI " & oldBankID & " KE " & bankID  &","
    else 
        rubahbankid = ""
    end if 
    ' norek
    if oldNoRekening <> norek THEN 
        rubahnorek = "PERUBAHAN NO REKENING DARI " & oldNoRekening & " KE " & norek  &","
    else 
        rubahnorek = ""
    end if 
    
    ' pegawai
    if oldPegawai <> CDbl(pegawai) THEN 
        rubahpgwi = "PERUBAHAN PEGAWAI DARI " & oldPegawai & " KE " & pegawai  &","
    else 
        rubahpgwi = ""
    end if 
    ' SubCabang
    if oldActiveAgenID <> CInt(SubCabang) THEN 
        rubahaID = "PERUBAHAN ACTIVE ID DARI " & oldActiveAgenID & " KE " & SubCabang  &","
    else 
        rubahaID = ""
    end if 
    ' Jabatan
    if oldJabCode <> Jabatan THEN 
        rubahjbtn = "PERUBAHAN JABATAN DARI " & oldJabCode & " KE " & Jabatan  &","
    else 
        rubahjbtn = ""
    end if 
    ' jenjang
    if oldJJID <> CInt(jenjang) THEN 
        rubahjenjang = "PERUBAHAN JENJANG DARI " & oldJJID & " KE " & jenjang  &","
    else 
        rubahjenjang = ""
    end if 
    ' divisi
    if oldDDBID <> divisi THEN 
        rubahdivisi = "PERUBAHAN DIVISI DARI " & oldDDBID & " KE " & divisi  &","
    else 
        rubahdivisi = ""
    end if 
    ' jcuti
    if oldJmlCuti <> CInt(jcuti) THEN 
        rubahjcuti = "PERUBAHAN JUMLAH CUTI DARI " & oldJmlCuti & " KE " & jcuti  &","
    else 
        rubahjcuti = ""
    end if 
    ' nKTP
    if oldNoID <> nKTP THEN 
        rubahktp = "PERUBAHAN NO KTP DARI " & oldNoID & " KE " & nKTP  &","
    else 
        rubahktp = ""
    end if 
    ' npwp
    if oldNPWP <> npwp THEN 
        rubahnpwp = "PERUBAHAN NO NPWP DARI " & oldNPWP & " KE " & npwp  &","
    else 
        rubahnpwp = ""
    end if 
    ' tglmasuk
    if oldTglMasuk <> CDate(tglmasuk) THEN 
        rubahtglmasuk = "PERUBAHAN TANGGAL MASUK DARI " & oldTglMasuk & " KE " & tglmasuk  &","
    else 
        rubahtglmasuk = ""
    end if 
    ' tglkeluar
    if tglagaji <> "" THEN 
    if oldTglKeluar <> tglkeluar THEN 
        rubahtglkeluar = "PERUBAHAN TANGGAL KELUAR DARI " & oldTglKeluar & " KE " & tglkeluar  &","
    else 
        rubahtglkeluar = ""
    end if 
    end if
    ' tglagaji 
    if tglagaji <> "" THEN 
        if oldTglStartGaji <> tglagaji THEN 
            rubahtglagaji = "PERUBAHAN TANGGAL AWAL GAJI DARI " & oldTglStartGaji & " KE " & tglagaji  &","
        else 
            rubahtglagaji = ""
        end if 
    end if
    ' tglegaji
     if tglagaji <> "" THEN 
        if oldTglStartGaji <> CDate(tglegaji) THEN 
            rubahegaji = "PERUBAHAN TANGGAL AKHIR GAJI DARI " & oldTglStartGaji & " KE " & tglagaji  &","
        else 
            rubahegaji = ""
        end if 
    end if
    ' jsim
    if oldJsSIM <> CInt(jsim) THEN 
        rubahjsim = "PERUBAHAN JSIM DARI " & oldJsSIM & " KE " & jsim  &","
    else 
        rubahjsim = ""
    end if 
    ' nsim
    if oldNoSIM <> "" THEN
    if oldNoSIM <> nsim THEN 
        rubahnsim = "PERUBAHAN NSIM DARI " & oldNoSIM & " KE " & nsim  &","
    else 
        rubahnsim = ""
    end if 
    end if
    ' kesehatan
    if oldNoBPJS <> kesehatan THEN 
        rubahnobpjs = "PERUBAHAN KESEHATAN DARI " & oldNoBPJS & " KE " & kesehatan  &","
    else 
        rubahnobpjs = ""
    end if 
    ' jamsostek\
    if oldNoJamsostek <> jamsostek THEN 
        rubahjamsos = "PERUBAHAN JAMSOSTEK DARI " & oldNoJamsostek & " KE " & jamsostek  &","
    else 
        rubahjamsos = ""
    end if 
    
    ' berlakuSIM
    if oldSIMValidate <> berlakuSIM THEN 
        rubahsimv = "PERUBAHAN BERLAKU SIM DARI " & oldSIMValidate & " KE " & berlakuSIM  &","
    else 
        rubahsimv = ""
    end if 
    ' bpjskes
    if oldBPJSKesYN <> bpjskes THEN 
        rubahbpjskes = "PERUBAHAN BPJSKES DARI " & oldBPJSKesYN & " KE " & bpjskes  &","
    else 
        rubahbpjskes = ""
    end if 
    ' atasan1
    if oldatasanNip1 <> atasan1 THEN 
        rubahanip1 = "PERUBAHAN ATASAN 1 DARI " & oldatasanNip1 & " KE " & atasan1  &","
    else 
        rubahanip1 = ""
    end if 
    ' atasan2
    if oldatasanNip2 <> atasan2 THEN 
        rubahanip2 = "PERUBAHAN ATASAN 2 DARI " & oldatasanNip2 & " KE " & atasan2  &","
    else 
        rubahanip2 = ""
    end if 
    ' vaksin
    if oldJenisVaksin <> "" THEN
    if oldJenisVaksin <> vaksin THEN 
        rubahvaksin = "PERUBAHAN JENIS VAKSIN DARI " & oldJenisVaksin & " KE " & vaksin  &","
    else 
        rubahvaksin = ""
    end if 
    end if
    ' goldarah
    if oldJenisVaksin <> "" THEN
        if oldgolDarah <> goldarah THEN 
            rubahgoldarah = "PERUBAHAN GOLONGAN DARAH DARI " & oldgolDarah & " KE " & goldarah  &","
        else 
            rubahgoldarah = ""
       end if
    end if

    pket = "UPDATE " & rubahNama & rubahalamat & rubahkelurahan & rubahbpjs & rubahtelp1 & rubahtelp2 & rubahkota & rubahpos & rubahtmpt & rubahtglLahir & rubahfax & rubahagama & rubahsex & rubahsttsosial & rubahanak & rubahtanggungan & rubahpendidikan & rubahpegawai & rubahsaudara & rubahanake & rubahbankid & rubahnorek & rubahpgwi & rubahaID & rubahjbtn & rubahjenjang & rubahdivisi & rubahjcuti & rubahktp & rubahnpwp & rubahtglmasuk & rubahtglkeluar & rubahtglagaji & rubahegaji & rubahjsim & rubahnsim & rubahnobpjs & rubahjamsos & rubahsimv & rubahbpjskes & rubahanip1 & rubahanip2 & rubahvaksin & rubahgoldarah & " DENGAN KARYAWAN ("& nip &") "
    ' pket = "UPDATE " & rubahNama & rubahalamat &  " DENGAN KARYAWAN ("& nip &") "

    

    update.commandText = "UPDATE HRD_M_Karyawan SET  Kry_Nip = '"& nip &"', Kry_DDBID = '"& divisi &"', Kry_Sex='"& jkelamin &"',Kry_AgenID ='"& SubCabang &"', Kry_JabCode = '"& jabatan &"',Kry_JJID = '"& jenjang &"', Kry_Nama = '"& nama &"', Kry_Addr1 = '"& alamat &"', Kry_Addr2 = '"& kelurahan &"', Kry_Kota = '"& kota &"', Kry_KdPos = '"& pos &"', Kry_Telp1 = '"& tlp1 &"', Kry_Telp2 = '"& tlp2 &"', Kry_Fax ='"& email &"', Kry_TmpLahir = '"& tmpt &"', Kry_TglLahir = '"& tglL &"', Kry_SttSosial = '"& ssosial &"', Kry_JmlAnak ='"& janak &"', Kry_JmlSaudara ='"& saudara &"', Kry_AnakKe = '"& anakke &"', Kry_AgamaID = '"& agama &"', Kry_JDdkID = '"& pendidikan &"', Kry_NoID = '"& nKTP &"', Kry_NoSIM = '"& nsim &"', Kry_JnsSIM = '"& jsim &"', Kry_SIMValidDate = '"& berlakuSIM &"', Kry_JmlTanggungan = '"& tanggungan &"', Kry_JmlCuti = '"& jcuti &"', Kry_TglMasuk = '"& tglmasuk &"', Kry_tglKeluar = '"& tglkeluar &"', Kry_tglStartGaji =  '"&tglagaji &"', Kry_TglEndGaji = '"& tglegaji &"', Kry_BankID = '"& bankID &"', Kry_NoRekening = '"& norek &"', Kry_SttKerja = '"& spegawai &"', Kry_NPWP = '"& npwp &"', Kry_NoJamsostek = '"& jamsostek &"', Kry_BPJSYN = '"& bpjs &"', Kry_NoBPJS = '"& kesehatan &"' , Kry_Pegawai = '"& pegawai &"', Kry_BPJSKesYN = '"& bpjskes &"', Kry_atasanNip1 = '"& atasan1 &"', Kry_atasanNip2 = '"& atasan2 &"', Kry_JenisVaksin = '"& vaksin &"', Kry_golDarah = '"& goldarah &"' WHERE Kry_Nip = '"& nip &"'"
    ' Response.Write update.commandText
    update.execute

    'updateLog system
    tip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    tbrowser = Request.ServerVariables("http_user_agent")
    tdateTime = now()
    teventt = "UPDATE"
    tkey = nip
    turl = ""
    
    call updateLog(teventt,turl,tkey,session("username"),session("server-id"),tdateTime,tip,tbrowser,pket) 


    ' update bpjsYN
    ' bpjs_cmd.commandText = "SELECT * FROM HRD_T_MutasiBPJS WHERE Mut_KRYNip = '"& nip &"' AND month(Mut_Tanggal) = '"& month(now) &"' AND year(Mut_tanggal) = '"& year(now) &"' AND Mut_AktifYN = 'Y'"

    ' set bpjsAdd = bpjs_cmd.execute

    ' if bpjsAdd.eof then
    '     bpjs_cmd.commandText = "exec sp_ADDHRD_T_MutasiBPJS "& pegawai &",'"& nip &"','"& bpjskes &"','"& bpjs &"','"& date &"','"& session("username") &"'"
    '     ' Response.Write bpjs_cmd.commandText & "<br>"
        
    '     set bpjs = bpjs_cmd.execute
        
    '     data = bpjs("ID")

    '     'updateLog system
    '     ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    '     browser = Request.ServerVariables("http_user_agent")
    '     dateTime = now()
    '     eventt = "CREATE"
    '     key = data
    '     url = ""

    '     keterangan = "TAMBAH MUTASI BPJS KARYAWAN ("&nip&") DENGAN NOMOR " & data 
    '     call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 

        
    ' else
    '     bpjs_cmd.commandText = "UPDATE HRD_T_MutasiBPJS SET Mut_BPJSKes = '"& bpjskes &"', Mut_BPJSKet = '"& bpjs &"', Mut_Tanggal = '"& date &"', Mut_UpdateID = '"& session("username") &"' WHERE Mut_KryNip = '"& nip &"'"
    '     ' Response.Write bpjs_cmd.commandText & "<br>"
    '     bpjs_cmd.execute

    '     'updateLog system
    '     ip = Request.ServerVariables("remote_addr") & " [" & session("lat") & "," & session("lon") & "]"
    '     browser = Request.ServerVariables("http_user_agent")
    '     dateTime = now()
    '     eventt = "UPDATE"
    '     key = nip 
    '     url = ""

    '     keterangan = "UPDATE MUTASI BPJS KARYAWAN ("&nip&") DI PROSES " & NOW 
    '     call updateLog(eventt,url,key,session("username"),session("server-id"),dateTime,ip,browser,keterangan) 

    ' end if
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='../index.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Tidak Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='../index.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
%> 
<!--#include file="../../layout/footer.asp"-->