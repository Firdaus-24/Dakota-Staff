<!-- #include file='connection.asp' -->
<% 
dim aktif, update, nip, salary

aktif = Request.QueryString("p")
nip = Request.QueryString("q")

set update = Server.CreateObject("ADODB.Command")
update.ActiveConnection = MM_Cargo_string

if aktif = "Y" then
    update.commandText = "UPDATE HRD_M_Karyawan Set Kry_AktifYN = 'N' WHERE Kry_Nip = '"& nip &"'"
    update.execute
else
    update.commandText = "UPDATE HRD_M_Karyawan Set Kry_AktifYN = 'Y' WHERE Kry_Nip = '"& nip &"'"
    update.execute
end if
Response.Redirect("index.asp")
 %>