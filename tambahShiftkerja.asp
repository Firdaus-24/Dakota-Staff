<!-- #include file="connection.asp"-->
<% 
    if Session("HA2A") = false then
        Response.Redirect(url&"/shift_view.asp")
    end if
    'set master shift
    dim shift, berhasil

    ' berhasil = request.queryString("berhasil")
    ' if berhasil <> "" then
    '     Response.Write "<script>alert('DATA BERHASIL DI TAMBAHKAN')</script>"
    ' End if

    set shift = server.createobject("ADODB.Command")
    shift.activeConnection = MM_Cargo_string

    shift.commandText ="SELECT * FROM HRD_M_Shift Where Sh_AktifYN = 'Y'"
    set shift = shift.execute

    'set divisi
    dim divisi

    set divisi = server.createobject("ADODB.Command")
    divisi.activeConnection = MM_Cargo_string

    divisi.commandText = "SELECT dbo.HRD_M_Divisi.Div_Code, dbo.HRD_M_Divisi.Div_Nama FROM HRD_M_Divisi WHERE Div_AktifYN = 'Y' ORDER BY dbo.HRD_M_Divisi.Div_Nama ASC "
    set divisi = divisi.execute
    
    set agen = server.createobject("ADODB.Command")
    agen.activeConnection = MM_Cargo_string

    agen.commandText = "SELECT GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND GLB_M_agen.Agen_Nama NOT LIKE '%XXX%' GROUP BY GLB_M_Agen.Agen_ID, GLB_M_Agen.Agen_Nama ORDER BY GLB_M_Agen.AGen_Nama ASC"
    ' Response.Write agen.commandText & "<br>"
    set agen = agen.execute

%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Halaman Shift Kerja</title>
    <!--#include file="layout/header.asp"-->
    <script type="text/javascript" src="js/jqueryshiftkerja.js"></script>

    <!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
    <link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />

    <!-- Bootstrap Date-Picker Plugin -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

    <script type="text/javascript">

        $(document).ready(function(){
            var date_input=$('input[name="myrosterdate"]'); //our date input has the name "myrosterdate"
            var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
            var options={
                multidate:true,
                format: 'yyyy-mm-dd',
                container: container,
                todayHighlight: true,
                autoclose: false,
            };
                date_input.datepicker(options);
        });
    </script>   
     <!--CSS-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Viga&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%= url %>/css/style.css" >
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <!--#include file="layout/header.asp"-->
</head>
<body>
<!--#include file="landing.asp"-->
<div class="container">
    <div class='row mt-3'>
        <div class='col-lg'>
            <h3 class="text-center">SETTING SHIFT KERJA</h3>
        </div>
    </div>
    <div class="row">
        <div class="col mt-3">
            <div class="col-lg">
                <div class="form-floating mt-3 mb-2">
                    <!-- Form code begins -->
                    <form method="post" action="shiftKerja_add.asp">
                        <div class="form-group"> <!-- Date input -->
                            <!-- input mastershift -->
                            <label class="control-label" for="date">Pilih Shift</label>
                            <select class="form-select" aria-label="Default select example" name="shiftName" id="shiftName" required>
                                <option value="">Pilih</option>
                                    <% do until shift.eof %> 
                                    <option value="<%= shift("Sh_ID") %> ">Shift ID <%= shift("Sh_ID") %> | <%= shift("SH_Name") %> </option>
                                    <% shift.movenext
                                    loop %> 
                                </select>
                        </div>
                        <div class="form-group">
							<label for="pilagen" class="form-label">Pilih Agen</label>
							<select class="form-select" id="select-agen" required>
							    <option value="">Pilih</option>
							<% do while not agen.eof%>      
							    <option value="<%= agen("Agen_ID") %> "><%= agen("Agen_Nama") %> </option>
							<% 
                                agen.movenext 
                                loop
							%> 
							</select> 
                        </div>
                        <div class="form-group">
							<label for="pildivisi" class="form-label">Pilih Divisi</label>
							<select class="form-select" id="select-divisi" required>
							<option value="">Pilih</option>
							<% do while not divisi.eof%>      
							    <option value="<%= divisi("Div_Code") %> "><%= divisi("Div_Nama") %> </option>
							<% 
                                divisi.movenext 
                                loop
							%> 
							</select> 
                        </div>
                        <div class="form-group mt-2" name="tampil_karyawan" id="tampil_karyawan"></div>
                        <div class="form-group">
                            <!-- set tanggal -->
                            <label class="control-label" for="date">Pilih Tanggal</label>
                            <input class="form-control" id="myrosterdate" name="myrosterdate" placeholder="MM/DD/YYY" type="text" autocomplete="off" required/>
                        </div>
                </div>
            </div>
        </div>
    </div>  
    <div class='row'>
        <div class="d-flex mb-3">
            <div class="p-2 btn-group" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-danger" onclick="window.location.href='shift_view.asp'">Kembali</button>
                <%if session("HA2AB") = true then%>
                <button type="button" class="btn btn-warning" onclick="window.location.href='updateShiftKerja.asp'">Update</button>
                <%end if%>
            </div>
            <% if session("HA2AA") = true then%>
            <div class="ms-auto p-2">
                <button class="btn btn-primary " name="submit" type="submit">Submit</button>
            </div>
            <%end if%>
            </form>
        </div>
    </div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="js/script.js"></script>
</html>