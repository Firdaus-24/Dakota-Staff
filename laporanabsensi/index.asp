<!-- #include file='../connection.asp' -->
<% 
set divisi = Server.CreateObject("ADODB.Command")
divisi.activeConnection = mm_cargo_string

divisi.CommandText = "SELECT div_nama, Div_Code FROM HRD_M_divisi WHERE Div_AktifYN = 'Y' AND ISNULL(Div_Code, '') <> '' ORDER BY Div_nama ASC"
set divisi = divisi.execute

set cabang_cmd = Server.CreateObject("ADODB.Command")
cabang_cmd.activeConnection = mm_cargo_string

cabang_cmd.CommandText = "SELECT Agen_id, Agen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_Agen.Agen_ID WHERE GLB_M_Agen.agen_AktifYN = 'Y' AND GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_TglKeluar = '' GROUP BY Agen_id, Agen_Nama ORDER BY agen_nama ASC"
set cabang = cabang_cmd.execute
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN ABSENSI</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
    div.container {
        height: 40em;
        /* width:100%; */
        position: relative;
        }
    div.container .content {
        padding:20px;
        margin: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        border: 1px solid #5E9FFF;
        border-radius:20px;
    }
    </style>
</head>

<body>
<!-- #include file='../landing.asp' -->
<div class='container'>
    <div class="content">
        <div class='row mt-3'>
            <div class='col-lg text-center'>
                <h3>ABSENSI BERDASARKAN DIVISI</h3>
            </div>
        </div>
        <form action="absensidivisi.asp" method="post">
        <div class='row'>
            <div class='col'>
                <div class="mb-3 ">
                    <label class="col-sm-5 col-form-label">Set Cabang/Agen</label>
                    <div class="col-sm-12">
                        <select class="form-select" aria-label="Default select example" id="agen" name="agen" required>
                            <option value="">Pilih</option>
                            <% do while not cabang.eof %>
                            <option value="<%= cabang("Agen_ID") %>"><%= cabang("Agen_Nama") %></option>
                            <% 
                            cabang.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <div class="mb-3 ">
                    <label for="setdivisi" class="col-sm-5 col-form-label">Set Divisi</label>
                    <div class="col-sm-12">
                        <select class="form-select" aria-label="Default select example" id="divisi" name="divisi" required>
                            <option value="">Pilih</option>
                            <% do while not divisi.eof %>
                            <option value="<%= divisi("Div_Code") %>"><%= divisi("Div_Nama") %></option>
                            <% 
                            divisi.movenext
                            loop
                            %>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <div class="row">
                    <label for="tgla" class="col-sm-5 col-form-label">Priode Tanggal</label>
                </div>
                <div class="mb-3 row">
                    <div class="col-sm-6">
                        <input type="date" class="form-control" id="tgla" name="tgla" required>
                    </div>
                    <div class="col-sm-6">
                        <input type="date" class="form-control" id="tgle" name="tgle" required>
                    </div>
                </div>
            </div>
        </div>
        <div class='row text-center'>
            <div class='col'>
                <button type="submit" class="btn btn-primary">SEARCH</button>
            </div>
        </div>
        </form>
    </div>
</div>
<!-- #include file='../layout/footer.asp' -->