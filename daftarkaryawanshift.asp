<!--#include file="connection.asp"-->
<% 
dim code, karyawan_cmd, karyawan
code = request.queryString("id")
bulana = request.queryString("bulana")
bulane = request.queryString("bulane")
cabang = request.queryString("cabang")

set karyawan_cmd = server.createObject("ADODB.Command")
karyawan_cmd.activeConnection = MM_Cargo_string

karyawan_cmd.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.DIv_Code LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_T_Shift ON HRD_M_Karyawan.Kry_Nip = HRD_T_Shift.SHF_Nip WHERE HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_DDBID = '"& code &"' and HRD_M_Karyawan.Kry_AktifYN = 'Y' AND GLB_M_Agen.Agen_ID = '"& cabang &"' AND HRD_T_Shift.SHF_Tanggal BETWEEN '"& bulana &"' AND '"& bulane &"' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, HRD_M_Divisi.Div_Nama ORDER BY Kry_Nama ASC"
'Response.Write karyawan_cmd.commandText
set karyawan = karyawan_cmd.execute

 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Karyawan Shift</title>
    <!--#include file="layout/header.asp"-->
    <style>
    a{
        text-decoration:none;
    }
    </style>
</head>
<body> 
<!-- #include file='landing.asp' -->   
<div class="container">
    <div class="row text-center">
        <div class="collg">
            <h3 class="mt-3">DAFTAR KARYAWAN <%= ucase(karyawan("Div_Nama")) %></h3>
        </div>
    </div>
    <div class='row'>
        <div class='collg'>
            <button type="button" class="btn btn-danger" onclick="window.location.href='shiftkaryawan.asp'">Kembali</button>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg'>
            <table class="table table-striped table-hover mt-3">
                <thead class="bg-secondary text-light">
                <tr>
                    <th>No</th>
                    <th>Nip</th>
                    <th>Nama</th>
                    <th>Status Shift</th>
                </tr>
                </thead>
                <tbody>
                <% 
                dim i
                i = 0 
                do until karyawan.eof 
                i = i + 1
                'Response.Write i %> 
                <tr>   
                    <td><%= i %></td> 
                    <td><%= karyawan("Kry_Nip") %> </td>
                    <td><%= karyawan("Kry_Nama") %> </td>
                    <td><a href="kalendershift.asp?nip=<%= karyawan("Kry_nip") %>&id=<%= code %>" class="badge bg-info text-dark">Info</a></td>
                </tr>
                <% karyawan.movenext
                loop 
            
                %> 
                </tbody>
            </table>
                <% 
                i = 0
                 %> 
        </div>
    </div>
</div>  
<!--#include file="layout/footer.asp"-->