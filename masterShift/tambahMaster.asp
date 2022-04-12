<!--#include file="../connection.asp"-->
<% 
if session("HA3A") = false then
    Response.Redirect("../dashboard.asp")
end if
dim shift, notif, ada

set shift = server.createobject("ADODB.Command")
shift.activeConnection = MM_Cargo_String

 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TAMBAH SHIFT</title>
    <!--#include file="../layout/header.asp"-->
</head>
<body>
<!--#include file="../landing.asp"-->
<div class="container mt-3">
    <div class="row">
        <div class="col-md">
            <h3 class="text-center">FORM MASTER SHIFT</h3>
        </div>
    </div> 
    <div class='row mt-2'>
        <div class='col-md-12'>
            <form name="formShift" method="post" action="mastershift_add.asp" onsubmit="return validasiShift()"> 
                <div class="row mb-3 justify-content-md-center">
                    <div class="col-2">
                        <label for="idshift" class="col-form-label">ID Shift</label>
                    </div>
                    <div class="col-sm-8"> 
                        <input type="text" id="idshift" name="idshift" class="form-control" aria-describedby="Inline" max="5" autocomplete="off" required>
                    </div>
                </div>
                <div class="mb-3 row justify-content-md-center">
                    <div class="col-2">
                        <label for="nama" class="col-form-label">Nama Shift</label>
                    </div>
                    <div class="col-sm-8">
                        <input type="text" id="nama" name="nama" class="form-control" aria-describedby="Inline"  autocomplete="off" required>
                    </div>
                </div>
                <div class="mb-3 row justify-content-md-center">
                    <div class="col-2">
                        <label for="jamIn" class="col-form-label">Jam In</label>
                    </div>
                    <div class="col-sm-3">
                        <input type="number" id="jamIn" name="jamIn" class="form-control" aria-describedby="Inline" required>
                    </div>
                    <div class="col-sm-2">
                        <label for="minIn" class="col-form-label">Menit In</label>
                    </div>
                    <div class="col-sm-3">
                        <input type="number" id="minIn" name="minIn" class="form-control" aria-describedby="Inline" required>
                    </div>
                </div>
                <div class="mb-3 row justify-content-md-center">
                    <div class="col-2">
                        <label for="jamOut" class="col-form-label">Jam Out</label>
                    </div>
                    <div class="col-sm-3">
                        <input type="number" id="jamOut" name="jamOut" class="form-control" aria-describedby="Inline" required>
                    </div>
                    <div class="col-sm-2">
                        <label for="minOut" class="col-form-label">Menit Out</label>
                    </div>
                    <div class="col-sm-3">
                        <input type="number" id="minOut" name="minOut" class="form-control" aria-describedby="Inline" required>
                    </div>
                </div>
                <div class="mb-3 row">
                    <div class='col-md-1'></div>
                    <div class="col-md-2">
                        <label for="bhari" class="col-form-label">Beda Hari</label>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" aria-label="Default select example" name="bhari" id="bhari" required>
                            <option value="">Pilih</option>
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
                    </div>
                </div>
        </div>
    </div>
    <div class='row'>
        <div class='col-md-1'></div>
        <div class='col-md-2'>
                <button type="button" onclick="window.location.href='index.asp'" name="button" id="button" class="btn btn-warning">Kembali</button>
                <button type="submit" value="Submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</div>
<script>
    function validasiShift() {
        var min = 5;
        var min2 = 50;
        var j = 23;
        var m = 59;
        var h = 1;
        // cari data
        var id = document.forms["formShift"]["idshift"].value;
        var nama = document.forms["formShift"]["nama"].value;
        var jamIn = document.forms["formShift"]["jamIn"].value;
        var minIn = document.forms["formShift"]["minIn"].value;
        var jamOut = document.forms["formShift"]["jamOut"].value;
        var minOut = document.forms["formShift"]["minOut"].value;
        var bhari = document.forms["formShift"]["bhari"].value;
        // kodisikan
        if (id.length > min) {
            Swal.fire(
                'MAXIMAL ID 5 CHARAKTER',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (nama.length > min2){
            Swal.fire(
                'MAXIMAL NAMA 50 CHARAKTER',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (jamIn > j ){
            Swal.fire(
                'Jam Maximal sampai 23 WIB',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (minIn > m ){
            Swal.fire(
                'Menit Maximal sampai 59',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (jamOut > j ){
            Swal.fire(
                'am Maximal sampai 23 WIB',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (minOut > m ){
            Swal.fire(
                'Menit Maximal sampai 59',
                'coba periksa kembali',
                'error'
            )
            return false;
        }else if (bhari.length > h){
            alert("Jangan di ganti2 deh");
            return false;
        }
        else{
            return confirm("Anda Sudah Yakin Benar???");
        }
        return true;
    }
    </script> 
<!--#include file="../layout/footer.asp"-->