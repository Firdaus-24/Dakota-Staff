<!--#include file="../../connection.asp"-->
<!-- #include file='../../layout/header.asp' -->
<% 
dim updateData
dim nomor,tgla,tgle,status,potgaji,potcuti,keterangan,atasan

nomor = trim(request.form("nomorID"))
nip = trim(request.form("nip"))
tgla = request.form("tgla")
tgle = request.form("tgle")
status = request.form("status")
'gaji
potgaji =request.form("pgaji")
    if potgaji = "" then
        potgaji = "N"
    else 
        potgaji = "Y"
    end if
'cuti
potcuti = request.form("pcuti")
    if potcuti = "" then
        potcuti = "N"
    else 
        potcuti = "Y"
    end if
keterangan = request.form("ket")
atasan = request.form("atasan")
atasanApproveYN = request.form("atasanApproveYN")
atasanUpper = trim(request.form("atasanUpper"))
atasanUpperApproveYN = request.form("atasanUpperApproveYN")

' cek saldo cuti karyawan 
set gaji_cmd = server.CreateObject("ADODB.Command")
gaji_cmd.activeConnection = MM_Cargo_string

set cuti_add = server.CreateObject("ADODB.Command")
cuti_add.activeConnection = MM_Cargo_string

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
' Response.Write cuti_add.commandText & "<br>"
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

set updateData = Server.CreateObject("ADODB.Command")
updateData.ActiveConnection = MM_Cargo_string

updateData.commandText = "SELECT * FROM HRD_T_izinCutiSakit WHERE ICS_Nip = '"& nip &"' AND ICS_StartDate = '"& tgla &"' AND ICS_Enddate = '"& tgle &"' AND ICS_Status = '"& status &"' AND ICS_PotongGaji = '"& potgaji &"' AND ICS_PotongCuti = '"& potcuti &"' AND ICS_AtasanApproveYN = '"& AtasanApproveYN &"' AND ICS_AtasanUpperApproveYN = '"& AtasanUpperApproveYN &"'"
' Response.Write updateData.commandText & "<br>"
set cuti = updateData.execute

if cuti.eof then
    ' untuk karyawan yang belm dapet cuti
    if karyawan("Kry_JmlCuti") = 0 then
        cuti_add.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_StartDate = '"& tgla &"', ICS_EndDate = '"& tgle &"', ICS_Status = '"& status &"', ICS_Keterangan = '"& keterangan &"', ICS_Atasan = '"& atasan &"', ICS_AtasanApproveYN = '"& atasanApproveYN &"', ICS_AtasanUpper = '"& atasanUpper &"', ICS_AtasanUpperApproveYN = '"& atasanUpperApproveYN &"', ICS_PotongCuti = 'N', ICS_PotongGaji = '"&potgaji&"' WHERE ICS_ID = '"& nomor &"'"
        ' Response.Write cuti_add.commandText
        cuti_add.execute
        
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Diubah</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
    else
        if sisacuti = 0 and potcuti = "Y" then
            Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Saldo Sudah Habis</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
        else
            if interval > sisacuti and potcuti = "Y" then
                Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Saldo tidak cukup</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"  
            else
                updateData.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_StartDate='"& tgla &"', ICS_EndDate='"& tgle &"', ICS_Status='"& status &"', ICS_Keterangan='"& keterangan &"', ICS_Atasan='"& atasan &"', ICS_PotongCuti='"& potcuti &"', ICS_PotongGaji='"& potgaji &"',ICS_AtasanApproveYN = '"& AtasanApproveYN &"', ICS_AtasanUpper = '"& AtasanUpper  &"', ICS_AtasanUpperApproveYN = '"& AtasanUpperApproveYN &"' WHERE ICS_ID ='"& nomor &"'"
                ' Response.Write updateData.commandText
                updateData.execute
                Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Diubah</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
            end if
        end if
    end if
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

%>
<!-- #include file='../../layout/footer.asp' -->