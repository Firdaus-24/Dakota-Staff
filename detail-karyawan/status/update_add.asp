<!-- #include file='../../connection.asp' -->
<!-- #include file='../../layout/header.asp' -->
<% 
dim tgla, tgle, status, id, nip
dim update

tgla = CDate(Request.Form("tgla"))
tgle = CDate(Request.Form("tgle"))
status = Request.Form("status")
nip = trim(Request.Form("nip"))
id = trim(Request.Form("id"))

set karyawan_cmd = Server.CreateObject("ADODB.Command")
karyawan_cmd.activeConnection = MM_Cargo_string

set status_cmd = Server.CreateObject("ADODB.Command")
status_cmd.activeConnection = MM_Cargo_string

set update = Server.CreateObject("ADODB.Command")
update.activeConnection = MM_Cargo_string

update.commandText = "SELECT * FROM HRD_T_StatusKaryawan WHERE SK_ID = '"& id &"' AND SK_KryNip = '"& nip &"' AND SK_tglIn = '"& tgla &"' AND SK_tglOut = '"& tgle &"'"
' Response.Write update.commandText & "<br>"
set result = update.execute

if result.eof then

    update.commandText = "UPDATE HRD_T_StatusKaryawan SET SK_tglIn = '"& tgla &"', SK_tglOut = '"& tgle &"', Sk_Status = '"& status &"' WHERE SK_ID = '"& id &"' and SK_KryNip = '"& nip &"'"
    
    update.execute

     karyawan_cmd.commandText = "SELECT SK_Status FROM HRD_T_StatusKaryawan WHERE SK_ID = '"& id &"' AND SK_KryNip = '"& nip &"' AND SK_tglIn = '"& tgla &"' AND SK_tglOut = '"& tgle &"'"

     set karyawan = karyawan_cmd.execute

          if karyawan("SK_Status") = "T" then
               spegawai = 0
          elseIf karyawan("Sk_Status") = "H" then
               spegawai = 1
          elseIf karyawan("Sk_Status") = "K" then
               spegawai = 2
          elseIf karyawan("Sk_Status") = "M" then
               spegawai = 3
          else 
               spegawai = 4
          end if  
     ' update data karyawan 
    status_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_SttKerja = "& spegawai &" WHERE Kry_nip = '"& nip &"'"
     ' Response.Write status_cmd.commandText & "<br>"
    status_cmd.execute

   Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../../logo/berhasil_dakota.PNG'><a href='"& url &"/detail-karyawan/status.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
else
     Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../../logo/gagal_dakota.PNG'><a href='"& url &"/detail-karyawan/status.asp?nip="& nip &"' class='btn btn-primary'>kembali</a></div>"
end if
 %>
<!-- #include file='../../layout/footer.asp' -->