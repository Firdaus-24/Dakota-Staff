<!--#include file="../connection.asp"-->
<% 
if session("username") = "" then
    Response.Redirect("../login.asp")
end if
dim master, masterAdd
dim id, nama, jamIn, minIn, jamOut, minOut, bhari

id = trim(request.form("idshift"))
nama = trim(request.form("nama"))
jamIn = trim(request.form("jamIn"))
minIn = trim(request.form("minIn"))
jamOut = trim(request.form("jamOut"))
minOut = trim(request.form("minOut"))
bhari = trim(request.form("bhari"))

set masterAdd = server.createobject("ADODB.Command")
masterAdd.activeConnection = MM_Cargo_String

masterAdd.commandText = "SELECT * from dbo.HRD_M_Shift where SH_ID = '"& trim(id)  &"'"
'Response.Write masterAdd.commandText
set master = masterAdd.execute  

    if master.eof = true  then  
		masterAdd.commandText = "INSERT INTO dbo.HRD_M_Shift (Sh_ID, Sh_Name, Sh_AktifYN, Sh_UpdateID, Sh_UpdateTime, SH_JamIn, SH_MenitIn, SH_JamOut, SH_MenitOut, SH_iHari) VALUES ('"& id &"','"& nama &"','Y','"& session("username") &"',getdate(),'"& jamIn &"','"& minIn &"','"& jamOut &"','"& minOut &"','"& bhari &"' )"
        'Response.Write masterAdd.commandText
        masterAdd.execute
        Response.redirect("tambahMaster.asp?notif=Data")
    else
		Response.Write "<script>alert('Data Sudah Ada KK')</script>"
        'Response.redirect("index.asp")
    end if

'Response.redirect("tambahMaster.asp?notif=Data")

%> 