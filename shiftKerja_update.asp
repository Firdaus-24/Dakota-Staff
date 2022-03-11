<!-- #include file="connection.asp"-->
<% 
dim shiftName, str, datatgl, karyawan, nip 
dim shift, arry, update

update = request.queryString("update")

shiftName = trim(request.form("shiftName"))
str = trim(request.form("myrosterdate"))
nip = trim(request.form("karyawan"))

'set add data
set shift = server.createobject("ADODB.Command")
shift.activeConnection = MM_Cargo_string

'Split
datatgl = Split(str,",")
nip = Split(nip,",")

'loop data nip dan tanggal
for i = 0 to ubound(datatgl)
    for x = 0 to ubound(nip)
        dim jnip, jtgl
        dim tampil
        jnip = nip(x)
        jtgl = datatgl(i)
            shift.commandText = "UPDATE HRD_T_Shift SET SH_ID = '"& shiftName &"', Shf_NIP ='"& trim(jnip) &"', Shf_tanggal = '"& jtgl &"', Shf_updateID = '"& session("username") &"' WHERE Shf_NIP ='"& trim(jnip) &"' and Shf_tanggal = '"& jtgl &"'"
            ' Response.Write shift.commandText
            shift.execute
    next
next

Response.redirect("updateShiftKerja.asp?done=done")
 %> 
