<!--#include file="../../connection.asp"-->
 <!-- #include file='../../layout/header.asp' -->
 <body>
<% 
dim cuti_add
dim key, nip, tgla,tgle, status, pgaji, pcuti, ket, atasan, bpengobatan, nip2, sform

key = trim(request.form("key"))
nip = trim(request.form("nip"))
tgla = Cdate(request.form("tgla"))
tgle = Cdate(request.form("tgle"))
status = request.form("status")
formsurat = request.form("formsurat")
atasan = trim(request.form("atasan"))
atasanApproveYN = request.form("atasanApproveYN")
atasanUpper = trim(request.form("atasanUpper"))
atasanUpperApproveYN = request.form("atasanUpperApproveYN")

pgaji = request.form("pgaji")
    if pgaji <> "" then 
        pgaji = "Y" 
    else 
        pgaji = "N"
    end if 
pcuti = request.form("pcuti")
    if pcuti <> "" then 
        pcuti = "Y"
    else 
        pcuti = "N" 
    end if 
sform = request.form("sform")
    if sform <> "" then 
        sform = "Y" 
    else 
        sform = "N"
    end if 
ket = request.form("ket")
bpengobatan = request.form("bpengobatan")

set gaji_cmd = server.CreateObject("ADODB.Command")
gaji_cmd.activeConnection = MM_Cargo_string

set cuti_add = server.CreateObject("ADODB.Command")
cuti_add.activeConnection = MM_Cargo_string

cuti_add.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' and ICS_StartDate = '"& tgla &"' and ICS_EndDate = '"& tgle &"' AND ICS_AktifYN = 'Y'"
' Response.Write cuti_add.commandText
set cuti = cuti_add.execute

' sisa cuti tahun ini
cuti_add.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS jharicuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
' Response.Write cuti_add.commandText & "<br>"
set saldo = cuti_add.execute

' potongan gaji tahun ini
cuti_add.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS pgaji FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& year(date) &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& year(date) &"' AND HRD_T_IzinCutiSakit.ICS_PotongGaji <> '' AND HRD_T_IzinCutiSakit.ICS_Potonggaji = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
' Response.Write cuti_add.commandText & "<br>"
set saldogaji = cuti_add.execute

' cek saldo cuti karyawan
cuti_add.commandText = "SELECT Kry_Nama, Kry_JmlCuti FROM HRD_M_Karyawan WHERE Kry_nip = '"& nip &"' AND Kry_AktifYN = 'Y'"
set karyawan = cuti_add.execute

' total potong cuti
jharicuti = 0
do while not saldo.eof
    jharicuti = jharicuti + (saldo("jharicuti") + 1)
saldo.movenext
loop

' total potongan gaji
tgaji = 0
do while not saldogaji.eof
    tgaji = tgaji + (saldogaji("pgaji") + 1)
saldogaji.movenext
loop

sisacuti = int(karyawan("Kry_JmlCuti")) - int(jharicuti)
if sisacuti <= 0 then
    sisacuti = 0
else
    sisacuti = sisacuti
end if
' set interval day in form 
interval = cint(DateDiff("d",tgla,tgle) + 1)

    if karyawan("Kry_JmlCuti") = 0 then
        if not cuti.eof then
            Response.Write "<div class='gagalSaldo'>GAGAL</div>"
        else
            cuti_add.commandText = "exec sp_ADDHRD_T_IzinCutiSakit '"& key &"','"& nip &"','"& tgla &"','"& tgle &"','"& status &"','"& ket &"','"& atasan &"','"& atasanApproveYN &"','"& atasanUpper &"','"& atasanUpperApproveYN &"','0', '"& pcuti &"','"& pgaji &"', '"& sform &"',''"
            ' Response.Write cuti_add.commandText
            cuti_add.execute
            
            Response.Write "<div class='gagalSaldo'>BERHASIL</div>"
        end if
    else
        if interval > sisacuti and pgaji = "Y" and pcuti = "Y" then
            totalhari = interval - sisacuti
            ' set date for potgaji
            dpotcuti = dateadd("d",totalhari,tgla)
            dpotgaji = dateadd("d",totalhari,tgla) - 1


            ' store potongan cuti
            cuti_add.commandText = "exec sp_ADDHRD_T_IzinCutiSakit '"& key &"','"& nip &"','"& dpotcuti &"','"& tgle &"','"& status &"','"& ket &"','"& atasan &"','"& atasanApproveYN &"','"& atasanUpper &"','"& atasanUpperApproveYN &"','0', '"& pcuti &"','N', '"& sform &"',''"
            ' Response.Write cuti_add.commandText & "<br>"
            cuti_add.execute
            
            ' store potongan gaji
            cuti_add.commandText = "exec sp_ADDHRD_T_IzinCutiSakit '"& key &"','"& nip &"','"& tgla &"','"& dpotgaji &"','"& status &"','"& ket &"','"& atasan &"','"& atasanApproveYN &"','"& atasanUpper &"','"& atasanUpperApproveYN &"','0', 'N','"& pgaji &"', '"& sform &"',''"
            ' Response.Write cuti_add.commandText & "<br>"
            cuti_add.execute
                
            Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
        elseif sisacuti = 0 and pcuti = "Y" then
            Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Saldo Sudah Habis</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
        elseIf interval > sisacuti and pcuti = "Y" then
            Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Saldo Tidak Mencukupi</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
        else
            if not cuti.eof then
                Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
            else
                cuti_add.commandText = "exec sp_ADDHRD_T_IzinCutiSakit '"& key &"','"& nip &"','"& tgla &"','"& tgle &"','"& status &"','"& ket &"','"& atasan &"','"& atasanApproveYN &"','"& atasanUpper &"','"& atasanUpperApproveYN &"','0', '"& pcuti &"','"& pgaji &"', '"& sform &"',''"
                ' Response.Write cuti_add.commandText
                cuti_add.execute
                
                Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
            end if
        end if
    end if
%>
<!--#include file="../../layout/footer.asp"-->