<!-- #include file="../connection_personal.asp"-->
<!-- #include file='../layout/header.asp' -->
<% 
dim cuti_add
dim key, nip, tgla,tgle, status, pgaji, pcuti, ket, atasan, bpengobatan, nip2, sform

nomor = trim(request.form("nomor"))
key = trim(request.form("key"))
nip = trim(request.form("nip"))
tgla = Cdate(request.form("tgla"))
tgle = Cdate(request.form("tgle"))
status = "C"
formsurat = "N"
atasan = trim(request.form("atasan"))
atasanApproveYN = "N"
atasanUpper = trim(request.form("atasanUpper"))
atasanUpperApproveYN = "N"
pgaji = "N"
pcuti = "Y"
sform ="N"
ket = request.form("ket")
bpengobatan = 0

set cuti_add = server.CreateObject("ADODB.Command")
cuti_add.activeConnection = MM_Cargo_string

cuti_add.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' and ICS_StartDate BETWEEN '"& tgla &"' and '"& tgle &"' OR ICS_EndDate BETWEEN '"& tgla &"' AND '"& tgle &"' AND ICS_Keterangan = '"& ket &"' AND ICS_Atasan = '"& atasan &"' AND ICS_AtasanUpper = '"& atasanUpper &"'"
' Response.Write cuti_add.commandText
set cuti = cuti_add.execute

    if not cuti.eof then
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='cuti.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
    else
        cuti_add.commandText = "UPDATE HRD_T_IzinCutiSakit SET ICS_StartDate = '"& tgla &"', ICS_EndDate = '"& tgle &"', ICS_Keterangan = '"& ket &"', ICS_Atasan = '"& atasan &"', ICS_AtasanUpper = '"& atasanUpper &"' WHERE ICS_Nip = '"& nip &"' AND ICS_ID = '"& nomor &"'"
        ' Response.Write cuti_add.commandText
        cuti_add.execute
        
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='cuti.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
    end if

%>
<!--#include file="../layout/footer.asp"-->