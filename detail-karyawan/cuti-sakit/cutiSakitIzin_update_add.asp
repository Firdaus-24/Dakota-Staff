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
sform = request.form("sform")
    if sform <> "" then
        sform = "Y"
    else
        sform = "N"
    end if
atasanApproveYN = request.form("atasanApproveYN")
atasanUpper = trim(request.form("atasanUpper"))
atasanUpperApproveYN = request.form("atasanUpperApproveYN")

set updateData = Server.CreateObject("ADODB.Command")
updateData.ActiveConnection = MM_Cargo_string

updateData.commandText = "SELECT * FROM HRD_T_izinCutiSakit WHERE ICS_StartDate = '"& tgla &"' AND ICS_Enddate = '"& tgle &"' AND ICS_Nip = '"& nip &"' AND ICS_Status = '"& status &"' AND ICS_PotongGaji = '"& potgaji &"' AND ICS_PotongCuti = '"& potcuti &"' AND ICS_AtasanApproveYN = '"& AtasanApproveYN &"' AND ICS_AtasanUpperApproveYN = '"& AtasanUpperApproveYN &"' AND ICS_FormYN = '"& sform &"'"
' Response.Write updateData.commandText & "<br>"
set cuti = updateData.execute

if cuti.eof then
    updateData.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_StartDate='"& tgla &"', ICS_EndDate='"& tgle &"', ICS_Status='"& status &"', ICS_Keterangan='"& keterangan &"', ICS_Atasan='"& atasan &"', ICS_PotongCuti='"& potcuti &"', ICS_PotongGaji='"& potgaji &"', ICS_FormYN = '"& sform &"', ICS_AtasanApproveYN = '"& AtasanApproveYN &"', ICS_AtasanUpper = '"& AtasanUpper  &"', ICS_AtasanUpperApproveYN = '"& AtasanUpperApproveYN &"' WHERE ICS_ID ='"& nomor &"'"
    ' Response.Write updateData.commandText
    updateData.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Diubah</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/cutiSakitIzin.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if

 %>
<!-- #include file='../../layout/footer.asp' -->