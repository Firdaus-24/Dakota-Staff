<!-- #include file='../connection.asp' -->
<% 

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.activeConnection = MM_Cargo_string

    ' agen
    karyawan_cmd.commandText = "SELECT Agen_ID, AGen_Nama FROM HRD_M_Karyawan RIGHT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE Agen_AktifYN = 'Y' AND Agen_Nama NOT LIKE '%XXX%' AND Kry_AktifYN = 'Y' AND (GLB_M_Agen.Agen_ID IS NOT NULL) GROUP BY Agen_ID, AGen_Nama ORDER BY Agen_Nama ASC"
    set agen = karyawan_cmd.execute

    ' divisi
    karyawan_cmd.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Karyawan RIGHT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE Div_AktifYN = 'Y' AND Kry_AktifYN = 'Y' AND (Div_Code IS NOT NULL) GROUP BY Div_Code, Div_Nama ORDER BY Div_Nama ASC"
    set divisi = karyawan_cmd.execute

    ' jabatan
    karyawan_cmd.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Karyawan RIGHT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code WHERE Kry_AktifYN = 'Y' AND Jab_aktifYN = 'Y' GROUP BY Jab_Code, Jab_Nama ORDER BY Jab_Nama ASC"
    ' Response.Write karyawan_cmd.commandText & "<br>"
    set jabatan = karyawan_cmd.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APPROVE CUTI</title>
    <!-- #include file='../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <style>
        .tampilNip{
            display:inline-block;
            max-height: 60vh;
            overflow-y: auto;
        }
        .tampilAtasan{
            display:inline-block;
            max-height: 60vh;
            overflow-y: auto;
        }
        .table{
            text-align: center;
            margin: auto;
        }
    </style>
</head>

<body>

<div class='container'>
    <form action="approve_add.asp" method="post" onsubmit="return validateAtasan()">
        <div class='row text-center mt-2'>
            <div class='col'>
                <label><b>FILTER KARYAWAN</b></label>
            </div>
        </div>
        <div class='row'>
            <div class='col-md-4'>
                <label>Agen / Cabang</label>
                <select class="form-select" aria-label="Default select example" name="agen" id="agen">
                    <option value="">Pilih</option>
                    <% 
                        do while not agen.eof
                    %>
                        <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                    <% 
                        agen.movenext
                        loop
                        agen.movefirst
                    %>
                </select>
            </div>
            <div class='col-md-4'>
                <label>Divisi</label>
                <select class="form-select" aria-label="Default select example" name="divisi" id="divisi">
                    <option value="">Pilih</option>
                    <% do while not divisi.eof %>
                        <option value="<%= divisi("Div_Code") %>"><%= divisi("Div_Nama") %></option>
                    <% 
                        divisi.movenext
                        loop
                        divisi.movefirst
                    %>
                    
                </select>
            </div>
            <div class='col-md-4'>
                <label>Jabatan</label>
                <select class="form-select" aria-label="Default select example" name="jabatan" id="jabatan">
                    <option value="">Pilih</option>
                    <% do while not jabatan.eof %>
                        <option value="<%= jabatan("Jab_Code") %>"><%= jabatan("Jab_Nama") %></option>
                    <% 
                        jabatan.movenext
                        loop
                        jabatan.movefirst
                    %>
                </select>
            </div>
        </div>
        <div class='row mt-2 text-center'>
            <div class='col'>
                <label><b>FILTER ATASAN</b></label>
            </div>
        </div>

        <div class='row mt-2'>
            <div class='col-md-4'>
                <label>Agen / Cabang</label>
                <select class="form-select" aria-label="Default select example" name="agen1" id="agen1">
                    <option value="">Pilih</option>
                    <% 
                        do while not agen.eof
                    %>
                        <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                    <% 
                        agen.movenext
                        loop
                    %>
                </select>
            </div>
            <div class='col-md-4'>
                <label>Divisi</label>
                <select class="form-select" aria-label="Default select example" name="divisi1" id="divisi1">
                    <option value="">Pilih</option>
                    <% do while not divisi.eof %>
                        <option value="<%= divisi("Div_Code") %>"><%= divisi("Div_Nama") %></option>
                    <% 
                        divisi.movenext
                        loop
                    %>
                    
                </select>
            </div>
            <div class='col-md-4'>
                <label>Jabatan</label>
                <select class="form-select" aria-label="Default select example" name="jabatan1" id="jabatan1">
                    <option value="">Pilih</option>
                    <% do while not jabatan.eof %>
                        <option value="<%= jabatan("Jab_Code") %>"><%= jabatan("Jab_Nama") %></option>
                    <% 
                        jabatan.movenext
                        loop
                    %>
                </select>
            </div>
        </div>

        <div class='row'>
            <div class='col-md-6'>
                    <div class="form-check form-check-inline mt-3">
                        <input class="form-check-input" type="radio" name="atasan" id="atasan1" value="1">
                        <label class="form-check-label" for="atasan1">ATASAN 1</label>
                    </div>
                    <div class="form-check form-check-inline mb-3">
                        <input class="form-check-input" type="radio" name="atasan" id="atasan2" value="2">
                        <label class="form-check-label" for="atasan2">ATASAN 2</label>
                    </div>
            </div>
            <div class='col-md-6 mt-3'>
                <div class='d-flex justify-content-end'>
                    <div class="btn-group" role="group" aria-label="Basic outlined example">
                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="window.location.href=`../dashboard.asp`">KEMBALI</button>
                        <button type="submit" name="submit" id="submit" class="btn btn-sm btn-outline-primary">SAVE</button>
                    </div>
                </div>
            </div>
        </div>
        <div class='row mt-3'>
            <div class='col-lg-6 tampilNip'>
                <h4 class="text-center">DAFTAR KARYAWAN</h4>
                <span id="ckatasan1">
                    <input class="form-check-input" id="selectAll" type="checkbox" checked><label for='selectAll'> Select All</label>
                </span>   
                    <table class="table" style="font-size:14px;">
                        <thead>
                            <tr>
                                <th scope="col">Pilih</th>
                                <th scope="col">Nip</th>
                                <th scope="col">Nama</th>
                                <th scope="col">Agen</th>
                                <th scope="col">Divisi</th>
                                <th scope="col">Jabatan</th>
                            </tr>
                        </thead>
                        <tbody id="tbody">
                        </tbody>
                    </table>
            </div>
            <div class='col-lg-6 tampilAtasan'>
                <h4 class="text-center">DAFTAR ATASAN</h4>
                    <table class="table" style="font-size:14px;">
                        <thead>
                            <tr>
                                <th scope="col">Pilih</th>
                                <th scope="col">Nip</th>
                                <th scope="col">Nama</th>
                                <th scope="col">Agen</th>
                                <th scope="col">Divisi</th>
                                <th scope="col">Jabatan</th>
                            </tr>
                        </thead>
                        <tbody id="tbody2">
                        </tbody>
                    </table>
            </div>
        </div>
    </form>
</div>

<script>
    $("#ckatasan1").hide();
    $("#agen").on("change", function(){
        $("#ckatasan1").show();
        $.getJSON("ajaxNip.asp",function(data){
        let content = ``;
            $.each(data, function(i,data){
                if(data.AGENID == $("#agen").val()){
                    content += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" value="${data.NIP}" name="nip" id="nip" checked></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                }
            });
        $("#tbody").html(content);
        });
    });
    $("#divisi").on("change", function(){
        let agen = $("#agen").val();
        $.getJSON("ajaxNip.asp",function(data){
            let content = ``;
            $.each(data, function(i,data){
                if(agen != ""){
                    if(agen == data.AGENID && data.DIVCODE == $("#divisi").val()){
                        content += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" value="${data.NIP}" name="nip" id="nip" checked></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                    }
                }
            });
        $("#tbody").html(content);
        });
    });
    $("#jabatan").on("change", function(){
        let agen = $("#agen").val();
        let divisi = $("#divisi").val();
        $.getJSON("ajaxNip.asp",function(data){
            let content = ``;
            $.each(data, function(i,data){
                // if(agen != "" && divisi ){
                    if(agen == data.AGENID && data.DIVCODE == $("#divisi").val() && data.JABCODE == $("#jabatan").val()){
                        content += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" value="${data.NIP}" name="nip" id="nip" checked></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                    }
                // }
            });
        $("#tbody").html(content);
        });
    });

    // fiter atasan
     $("#agen1").on("change", function(){
        $.getJSON("ajaxNip.asp",function(data){
        let content2 = ``;
            $.each(data, function(i,data){
                if(data.AGENID == $("#agen1").val()){
                    content2 += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="radio" value="${data.NIP}" name="nip1" id="nip1"></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                }
            });
        $("#tbody2").html(content2);
        return;
        });
    });
    $("#divisi1").on("change", function(){
        let agen = $("#agen1").val();
        $.getJSON("ajaxNip.asp",function(data){
            let content = ``;
            $.each(data, function(i,data){
                if(agen != ""){
                    if(agen == data.AGENID && data.DIVCODE == $("#divisi1").val()){
                        content += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="radio" value="${data.NIP}" name="nip1" id="nip1"></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                    }
                }
            });
        $("#tbody2").html(content);
        return;
        });
    });
    $("#jabatan1").on("change", function(){
        let agen = $("#agen1").val();
        let divisi = $("#divisi1").val();
        $.getJSON("ajaxNip.asp",function(data){
            let content = ``;
            $.each(data, function(i,data){
                // if(agen != "" && divisi ){
                    if(agen == data.AGENID && data.DIVCODE == $("#divisi1").val() && data.JABCODE == $("#jabatan1").val()){
                        content += `<tr><th scope="row"><div class="form-check"><input class="form-check-input" type="radio" value="${data.NIP}" name="nip1" id="nip1"></div></th><td>${data.NIP}</td><td>${data.NAMA}</td><td>${data.AGEN}</td><td>${data.DIVNAMA}</td><td>${data.JABNAMA}</td></tr>`;
                    }
                // }
            });
        $("#tbody2").html(content);
        return;
        });
    });
    function validateAtasan(){
        if ($("input[name=atasan]:checked").length <= 0 ){
            Swal.fire(
                'PERHATIAN!!',
                'Mohon untuk pilih atasan 1 atau 2',
                'error'
            );
            return false;
        }
        if ($("input[name=nip1]:checked").length <= 0 ){
            Swal.fire(
                'PERHATIAN!!',
                'Mohon untuk pilih nip atasan',
                'error'
            );
            return false;
        }
        if($("input[type='checkbox'][name='nip']").is(":checked")){
            return true;
        }else{
            Swal.fire(
                'PERHATIAN!!',
                'Mohon untuk pilih karyawan terlebih dahulu',
                'error'
            );
            return false;
        }
    }
    // button ceklis 
    $('#selectAll').on('click', function () {
        var checkboxes = document.querySelectorAll('input[type="checkbox"]');
        for (var checkbox of checkboxes) {
        checkbox.checked = this.checked;
        }
    });
    $("input[type=checkbox]").click(function() {
        if (!$(this).prop("checked")) {
        $("#selectAll").prop("checked", false);
        }
    });
</script>

<!-- #include file='../layout/footer.asp' -->