<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tambah
dim tgla, tgle, status, nip, pstatus, key, bulan, tglfix, ptgla

nip = trim(Request.Form("nip"))
tgla = Cdate(trim(Request.Form("tgla")))
tgle = Cdate(trim(Request.Form("tgle")))
status = trim(Request.Form("status"))

set tambah = Server.CreateObject("ADODB.Command")
tambah.activeConnection = MM_Cargo_string

set status_cmd = Server.CreateObject("ADODB.Command")
status_cmd.activeConnection = MM_Cargo_string

status_cmd.commandText = "SELECT * FROM HRD_T_StatusKaryawan WHERE SK_KryNip = '"& nip &"' and SK_TglIn = "& tgla &" and SK_tglOut = "& tgle &" and SK_Status = '"& status &"'"
set pstatus = status_cmd.execute

key = left(nip,3)

if month(tgla) <= 9 then
    bulan = "0" &  month(tgla)
else
    bulan = month(tgla)
end if 

if day(tgla) <= 9 then
    tglfix = "0" & day(tgla)
else 
    tglfix = day(tgla)
end if

ptgl = bulan &"/"& tglfix & "/" & year(tgla)

if pstatus.eof then

    tambah.commandText = "exec sp_AddHRD_T_SK '"& ptgl &"', '"& key &"', '"& nip &"'"
    ' Response.Write tambah.commandText
    tambah.execute

    ' ambil data paling terakhir
    status_cmd.commandText = "SELECT TOP 1 SK_Status FROM HRD_T_StatusKaryawan WHERE SK_KryNip = '"& nip &"' ORDER BY SK_TglIn DESC"

    set nstatus = status_cmd.execute
    
        if nstatus("Sk_Status") = "K" then
            spegawai = 2
        end if  
        
    ' update data karyawan 
    status_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_SttKerja = "& spegawai &" WHERE Kry_nip = '"& nip &"'"
    status_cmd.execute

    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/status.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/status.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"

end if

 
 %>
<!-- #include file='../../layout/footer.asp' -->