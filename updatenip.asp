<!-- #include file='connection.asp' -->
<% 
niplama = Request.Form("niplama")
nipbaru = Request.Form("nipbaru")
nama = Request.Form("nama")

' for succes or failed
f = Request.QueryString("f")
s = Request.QueryString("s")
name = Request.QueryString("name")

set updateNip_cmd = Server.CreateObject("ADODB.Command")
updateNip_cmd.activeConnection = MM_Cargo_string

if niplama <> "" And nipbaru <> "" then
    updateNip_cmd.commandText = "SELECT Kry_nip, Kry_nama FROM HRD_M_Karyawan WHERE Kry_nip = '"& nipbaru &"'"
    ' Response.Write updateNip_cmd.commandText & "<br>"
    set nipterdaftar = updateNip_cmd.execute

        if nipterdaftar.eof then
            updateNip_cmd.commandText = "UPDATE HRD_M_Karyawan SET Kry_nip = '"& nipbaru &"' WHERE Kry_nip = '"& niplama &"'"
            updateNip_cmd.execute

            Response.Redirect("updatenip.asp?s=s")
        else
            Response.Redirect("updatenip.asp?f=f&name="& nipterdaftar("Kry_nama"))
        end if
end if

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPDATE NIP</title>
    <!-- #include file='layout/header.asp' -->
    <style>
    .container{
        height: 100vh;
        justify-content:center;
        item-align:center;
    }
    .judulNip h3{
        font-weight: 600;
    }
    label{
        font-weight:bold;
    }
    </style>
</head>

<body>

<div class='container h100'>
    <div class='row h-100 justify-content-center align-items-center'>
        <form action="updateNip.asp" method="post" class="col-12 formGantiNip">
            <div class='row'>
                <div class='col text-center judulNip'>
                    <h3>FORM UBAH NIP</h3>
                </div>
            </div>
            <!--alert for success -->
            <% If s <> "" then  %>
                <div class='row justify-content-center'>
                    <div class='col-sm-8'>
                        <div class="alert alert-primary alert-dismissible fade show" role="alert">
                            <strong>Hore..!</strong> Data Berhasil Di Rubah
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
            <% end if %>
            <!--end alert -->
            <!--alert for failed -->
            <% if f <> "" then %>
                <div class='row justify-content-center'>
                    <div class='col-sm-8'>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            Data Sudah Terdaftar Atas Nama <strong><%= name %></strong> 
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
            <% end if %>
            <!--end alert -->
            <div class='row mt-2'>
                <div class='col-lg-12'>
                    <div class="mb-3 row justify-content-center">
                        <label for="niplama" class="col-sm-3 col-form-label">Nip Lama</label>
                        <div class="col-sm-5">
                            <input type="number" class="form-control" id="niplama" name="niplama" autocomplete="off" required>
                        </div>
                    </div>
                    <div class="mb-3 row justify-content-center">
                        <label for="nipbaru" class="col-sm-3 col-form-label">Nip Baru</label>
                        <div class="col-sm-5">
                            <input type="number" class="form-control" id="nipbaru" name="nipbaru" autocomplete="off" required>
                        </div>
                    </div>
                    <div class="mb-3 row justify-content-center">
                        <label for="nip" class="col-sm-3 col-form-label">Nama</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="nama" name="nama" autocomplete="off">
                        </div>
                    </div>
                </div>
            </div>
            <div class='row'>
                <div class='col-sm text-center'>
                    <button type="button" class="btn btn-primary" onclick="window.location.href = 'index.asp'">kembali</button>
                    <button type="submit" class="btn btn-dark">Submit</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
<!-- #include file='layout/footer.asp' -->
</html>