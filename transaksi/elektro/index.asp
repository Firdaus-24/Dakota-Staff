<!-- #include file='../../connection.asp' -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CICILAN ELEKTRONIK</title>
    <!-- #include file='../../layout/header.asp' -->
    <link rel="stylesheet" href="<%= url %>/css/elektro.css">
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-12 text-center mb-3 labelHeader">
            <h3>DETAIL PENGAMBILAN DAN PEMBAYARAN KARYAWAN</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-4 mb-3 d-flex justify-content-center">
            <a href="pinjaman.asp">
                <div class="card" style="background:url(../../logo/elektro1.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">PINJAMAN BARANG</h3>
                        <p>Detail data semua karyawan yang terdaftar pegambilan barang elektronik</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-4 mb-3  d-flex justify-content-center" >
            <a href="pembayaran.asp" >
                <div class="card" style="background:url(../../logo/elektro2.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">PEMBAYARAN CICILAN</h3>
                        <p>Detail data karyawan pembayaran cicilan</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-sm-4 mb-3  d-flex justify-content-center" >
            <a href="laporan_elektro.asp" >
                <div class="card" style="background:url(../../logo/elektro4.jpg);background-size: cover;background-position: center; position: relative;">
                    <div class="card-body layer">
                        <h3 class="card-title">LAPORAN</h3>
                        <p>Detail Pengambilan dan pembayaran barang elektronik karyawan </p>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 text-center" >
            <a href="../index.asp" style="text-decoration: none;"><i class="fa fa-long-arrow-left" aria-hidden="true"></i> kembali</a>
        </div>
    </div>  
</div>


<!-- #include file='../../layout/footer.asp' -->