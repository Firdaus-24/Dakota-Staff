<!--#include file="../connection.asp"-->
<!--#include file="../landing.asp"-->
<% 
'koneksi tampilan master shift
    if session("username") = "" then
        Response.Redirect("../login.asp")
    end if
    dim shift
    set shift = server.createobject("ADODB.Command")
    shift.activeConnection = MM_Cargo_String

    shift.commandText = "SELECT * from dbo.HRD_M_Shift where SH_Name is not null"
    set shift = shift.execute
%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Master Shift</title>
   <!--#include file="../layout/header.asp"-->
   <style>
        .table {
            width: 1%;
            white-space: nowrap;
        }
        a{
            text-decoration:none;
        }
   </style>
</head>
<body> 
<br>
<div class="container">
    <div class="row">
        <div class="col-lg">
            <h3 class="text-center">MASTER SHIFT</h3>
        </div>
    </div>
    <div class='row'>
        <% if session("HA3A") = true then %>
        <div class='col-lg'>
            <button type="button" onclick="window.location.href='tambahMaster.asp'" class="btn btn-primary">Tambah</button>
        </div>
        <% end if %>
    </div>
    <div class='row mt-3' style="overflow:auto;">
        <div class='col-lg'>
            <table class="table table-striped table-hover" style="font-size:14px;">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Nama</th>
                        <th scope="col">AktifYN</th>
                        <th scope="col">Update ID</th>
                        <th scope="col">Update Time</th>
                        <th scope="col">Jam masuk</th>
                        <th scope="col">Menit masuk</th>
                        <th scope="col">Jam Keluar</th>
                        <th scope="col">Menit Keluar</th>
                        <th scope="col">Beda Hari</th>
                        <th scope="col">Ubah Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        dim id
                        dim tampil
                    
                        
                        do until shift.eof
                    %> 
                    <tr>
                        <td><%= shift("SH_ID") %> </td>
                        <td><%= shift("Sh_Name") %> </td>
                        <td><%= shift("Sh_AktifYN") %> </td>
                        <td><%= shift("Sh_UpdateID") %> </td>
                        <td><%= shift("Sh_UpdateTime") %> </td>
                        <td><%= shift("SH_JamIn") %> </td>
                        <td><%= shift("SH_MenitIn") %> </td>
                        <td><%= shift("SH_JamOut") %> </td>
                        <td><%= shift("SH_MenitOut") %> </td>
                        <td><%= shift("SH_iHari") %> </td>
                    <%
                        id = shift("SH_ID")
                        
                        set tampil = server.createobject("ADODB.Command")
                        tampil.activeConnection = MM_Cargo_String


                        tampil.commandText = "SELECT * from dbo.HRD_T_Shift where SH_ID = '"& id &"'"
                        ' Response.Write tampil.commandText & "<br>"
                        set tampil = tampil.execute
                        
                        if tampil.eof then                    
                    %> 
                        <td>
                            <% 
                            if session("HA3B") = true then
                                if shift("Sh_AktifYN") = "N" then %> 
                                    <a href="ubahShift.asp?id=<%= shift("SH_ID") %>&status=<%= shift("Sh_AktifYN") %>" class="badge bg-danger masterShiftY" id="masterShiftY">Yes</a>
                            <% else %> 
                                <a href="ubahShift.asp?id=<%= shift("SH_ID") %>&status=<%= shift("Sh_AktifYN") %>" class="badge bg-success masterShiftN">No</a>
                            <%
                                end if
                            end if%>
                        </td>
                        <% else %>
                            <td></td>
                        <%end if%> 
                    </tr>
                    <% 
                    shift.movenext
                    loop
                    %> 
            </table>
        </div>
    </div>
</div>




<!--#include file="../layout/footer.asp"-->