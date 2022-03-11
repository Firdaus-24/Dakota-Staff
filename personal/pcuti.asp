<!-- #include file="../connection_personal.asp"-->
<!-- #include file='../layout/header.asp' -->
<% 
dim cuti_add
dim key, nip, tgla,tgle, status, pgaji, pcuti, ket, atasan, bpengobatan, nip2, sform

key = trim(request.form("key"))
nip = trim(request.form("nip"))
tgla = Cdate(request.form("tgla"))
tgle = Cdate(request.form("tgle"))
status = Request.Form("status")
formsurat = "N"
atasan = trim(request.form("atasan"))
atasanApproveYN = "N"
atasanUpperApproveYN = "N"
atasanUpper = trim(request.form("atasanUpper"))
sform ="N"
ket = request.form("ket")
bpengobatan = 0

    if status <> "" then
        status = status
    else
        status = "C"
    end if


set karyawan_cmd = server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = MM_Cargo_string

karyawan_cmd.commandText = "SELECT Kry_JmlCuti FROM HRD_M_Karyawan WHERE Kry_Nip = '"& nip &"'"
set karyawan = karyawan_cmd.execute

    if karyawan("Kry_JmlCuti") = 0 then
        pgaji = "Y"
        pcuti = "N"
    else
        pgaji = "N"
        pcuti = "Y"
    end if

set cuti_add = server.CreateObject("ADODB.Command")
cuti_add.activeConnection = MM_Cargo_string

cuti_add.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' and ICS_StartDate BETWEEN '"& tgla &"' AND '"& tgle &"' OR ICS_EndDate BETWEEN '"& tgla &"' AND '"& tgle &"' AND ICS_AktifYN = 'Y'"
' Response.Write cuti_add.commandText
set cuti = cuti_add.execute

    if not cuti.eof then
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='cuti.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
    else
        cuti_add.commandText = "exec sp_ADDHRD_T_IzinCutiSakit '"& key &"','"& nip &"','"& tgla &"','"& tgle &"','"& status &"','"& ket &"','"& atasan &"','"& atasanApproveYN &"','"& atasanUpper &"','"& atasanUpperApproveYN &"',"& bpengobatan &", '"& pcuti &"','"& pgaji &"', '"& sform &"',''"
        ' Response.Write cuti_add.commandText
        cuti_add.execute
        
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='cuti.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
    end if

%>
<!--#include file="../layout/footer.asp"-->