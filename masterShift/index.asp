<!--#include file="../connection.asp"-->
<% 
    if session("HA3")=false then
        Response.Redirect("../dashboard.asp")
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
            white-space: nowrap;
        }
        a{
            text-decoration:none;
        }
   </style>
</head>
<body> 
<!--#include file="../landing.asp"-->
<div class="container mt-3">
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
        <div class='col-sm-12'>
            <table class="table table-striped table-hover" style="font-size:14px;">
                <thead class="bg-secondary text-light">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Aktif</th>
                        <th scope="col">Update ID</th>
                        <th scope="col">Update Time</th>
                        <th scope="col">Jam masuk</th>
                        <th scope="col">Jam Keluar</th>
                        <th scope="col">Beda Hari</th>
                        <th scope="col">Ubah Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        do while not shift.eof
                        if shift("SH_AktifYN") = "Y" then
                            aktif = "Aktif"
                        else
                            aktif = "No"
                        end if
                    %> 
                    <tr>
                        <td><%= shift("SH_ID") %> </td>
                        <td><%= shift("Sh_Name") %> </td>
                        <td><%= aktif %> </td>
                        <td><%= shift("Sh_UpdateID") %> </td>
                        <td><%= shift("Sh_UpdateTime") %> </td>
                        <td><%= right("00" & shift("SH_JamIn"),2) &":"& right("00" & shift("SH_MenitIn"),2) %> </td>
                        <td><%= right("00" & shift("SH_JamOut"),2) &":"& right("00" & shift("SH_MenitOut"),2) %> </td>
                        <td><% if shift("SH_iHari") = "N" then Response.Write "No" else Response.Write "Yes" end if %> </td>
                    <%
                        id = shift("SH_ID")
                        
                        set tampil = server.createobject("ADODB.Command")
                        tampil.activeConnection = MM_Cargo_String


                        tampil.commandText = "SELECT * from dbo.HRD_T_Shift where SH_ID = '"& id &"'"
                        ' Response.Write tampil.commandText & "<br>"
                        set tampil = tampil.execute
                        
                        if tampil.eof then                    
                    %> 
                        <td class="text-center">
                            <% 
                            if session("HA3B") = true then
                                if shift("Sh_AktifYN") = "N" then %> 
                                    <a href="ubahShift.asp?id=<%= shift("SH_ID") %>&status=<%= shift("Sh_AktifYN") %>" class="badge bg-danger masterShiftY" id="masterShiftY">Yes</a>
                                <% else %> 
                                    <a href="ubahShift.asp?id=<%= shift("SH_ID") %>&status=<%= shift("Sh_AktifYN") %>" class="badge bg-success masterShiftN">No</a>
                            <%
                                end if
                            end if%>
                                <a href="updateShift.asp?id=<%= shift("SH_ID") %>" class="badge bg-primary masterShiftN">Update</a>
                        </td>
                        <% else %>
                            <td  class="text-center">-</td>
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