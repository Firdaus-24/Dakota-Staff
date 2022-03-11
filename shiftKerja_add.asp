<!-- #include file="connection.asp"-->
<% 
if session("username") = "" then
    Response.Redirect("login.asp")
end if
dim shiftName, str, datatgl, karyawan, nip 
dim shift, arry

shiftName = trim(request.form("shiftName"))
str = trim(request.form("myrosterdate"))
nip = trim(request.form("karyawan"))

'Response.Write nip

'set add data
set shift = server.createobject("ADODB.Command")
shift.activeConnection = MM_Cargo_string

'Split
datatgl = Split(str,",")
nip = Split(nip,",")

		dim histori_cmd, histori       
        dim nipbaru
        dim jnip, jtgl
        dim tampil
        dim tampilData
		
		set tampilData = server.createobject("ADODB.Command")
        tampilData.activeConnection = MM_Cargo_string

for i = 0 to ubound(datatgl)
	jtgl = trim(datatgl(i))
	
	if i = 0 then
		filterTglStart = " SHF_Tanggal = '"& jtgl &"'"
	else
	    filterTgl = filterTgl & " or Shf_Tanggal = '"& jtgl &"'"
	end if
	
    for x = 0 to ubound(nip)
       
        jnip = trim(nip(x))
		
		if x = 0 then
			filterNipStart = " SHF_Nip = '"& jnip &"'"
		else
			filterNip = filterNip & " or SHF_Nip = '"& jnip &"'"
		end if
		
        

        'tampil data
        tampilData.commandText = "SELECT Shf_NIP, SH_ID, Shf_Tanggal FROM HRD_T_Shift WHERE Shf_Nip = '"& jnip &"' and Shf_Tanggal = '"& jtgl &"'"

        set tampil = tampilData.execute
        if tampil.eof = true then 

            shift.commandText = "exec sp_ADDHRD_T_Shift'"& shiftName &"','"& jnip &"','"& jtgl &"','"& session("username") &"'"
            ' response.write shift.commandText & "<BR>"
            shift.execute
        
        else 
            Response.redirect("updateShiftKerja.asp?update=id")
        end if
    next
next


'    response.write filterNip & "<BR>"
set histori_cmd = server.createobject("ADODB.Command")
histori_cmd.activeConnection = MM_Cargo_string

histori_cmd.commandText = "SELECT dbo.HRD_T_Shift.Shf_GSCode, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_M_Shift.Sh_ID, dbo.HRD_M_Shift.Sh_Name, dbo.HRD_M_Shift.SH_JamIn, dbo.HRD_M_Shift.SH_MenitIn, dbo.HRD_M_Shift.SH_JamOut, dbo.HRD_M_Shift.SH_MenitOut, dbo.HRD_M_Shift.SH_iHari, dbo.HRD_T_Shift.shf_UpdateTime, dbo.HRD_T_Shift.Shf_updateID FROM dbo.HRD_T_Shift LEFT OUTER JOIN dbo.HRD_M_Shift ON dbo.HRD_T_Shift.Sh_ID = dbo.HRD_M_Shift.Sh_ID where HRD_M_Shift.Sh_ID <> '' and (" & filterTglStart & filterTGL & ") and (" & filterNipStart & filterNip & ") order by shf_nip, shf_tanggal ASC "

set histori = histori_cmd.execute
	

	
%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HISTORI DATA SHIFT</title>
    <!--#include file="layout/header.asp"-->
    <style>
    .box{
        width:400px;
        height:200px;
        border-radius:20px;
        border-style:solid;
        border-color:black;
        padding:20px;
        background:yellow;
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px
    }
    </style>
</head>
<body>
<div class=container>
    <div class='row'>
        <div class='col-lg text-center'>
            <h3 class="mt-3">HISTORI SHIFT KERJA </h3>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg'>
            <button type="button" class="btn btn-danger mb-2" onclick="window.location.href='tambahShiftkerja.asp'">Kembali</button>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg'>
            <table class="table table-success table-striped mt2">
                <thead>
                    <tr>
                        <td>Jam masuk</td>
                        <td>Menit masuk</td>
                        <td>Jam keluar</td>
                        <td>Menit keluar</td>
                        <td>Beda hari</td>
                        <td>NIP</td>
                        <td>Tanggal</td>
                        <td>Update ID</td>
                        <td>Tanggal Update</td>
                    </tr>
                </thead>
                </tbody>
                <% do until histori.eof %> 
                    <tr>
                        <td><%= histori("Sh_JamIn") %> </td>
                        <td><%= histori("Sh_MenitIn") %> </td>
                        <td><%= histori("Sh_JamOut") %> </td>
                        <td><%= histori("Sh_MenitOut") %> </td>
                        <td><%= histori("Sh_iHari") %> </td>
                        <td><%= histori("Shf_NIP") %> </td>
                        <td><%= histori("Shf_Tanggal") %> </td>
                        <td><%= histori("Shf_updateID") %> </td>
                        <td><%= histori("shf_UpdateTime") %> </td>
                    </tr>
                <% histori.movenext
                loop 
                %> 
            </tbody>
        </div>
    </div>
</table>
</div>
<!--#include file="layout/footer.asp"-->
