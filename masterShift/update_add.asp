<!--#include file="../connection.asp"-->
<!-- #include file='../layout/header.asp' -->
<% 
if session("HA3A") = false then
    Response.Redirect("../dashboard.asp")
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

masterAdd.commandText = "SELECT * from HRD_M_Shift where SH_ID = '"& id  &"'"
' Response.Write masterAdd.commandText & "<br>"
set master = masterAdd.execute  

    if not master.eof then  
		masterAdd.commandText = "UPDATE HRD_M_Shift SET SH_Name = '"& nama &"', Sh_UpdateID = '"& session("username") &"', Sh_UpdateTime = getdate(), SH_JamIn = '"& jamIn &"', SH_MenitIn = '"& minIn &"', SH_JamOut = '"& jamOut &"', SH_MenitOut = '"& minOut &"', SH_iHari = '"& bhari &"' WHERE SH_ID = '"& id &"'"

        masterAdd.execute
        Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='"& url &"/masterShift/index.asp' class='btn btn-primary'>kembali</a></div>"
    else
        Response.Write "<div class='notiv-gagal' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/gagal_dakota.PNG'><a href='"& url &"/masterShift/index.asp' class='btn btn-primary'>kembali</a></div>"
    end if

%> 
<!-- #include file='../layout/footer.asp' -->