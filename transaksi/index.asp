<!-- #include file='../connection.asp' -->
<% 
if session("HA8") = false then
  response.Redirect(url & "/dashboard.asp")
end if
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRANSAKSI</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
      @import url('https://fonts.googleapis.com/css?family=Heebo:400,700|Open+Sans:400,700');

      :root {
        --color: #3c3163;
        --transition-time: 0.5s;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        min-height: 100vh;
        font-family: 'Open Sans';
        background: #fafafa;
      }

      a {
        color: inherit;
      }

      .cards-wrapper {
        display: grid;
        justify-content: center;
        align-items: center;
        grid-template-columns: 1fr 1fr 1fr;
        grid-gap: 4rem;
        padding: 4rem;
        margin: 0 auto;
        width: max-content;
      }

      .card {
        font-family: 'Heebo';
        --bg-filter-opacity: 0.5;
        background-image: linear-gradient(rgba(0,0,0,var(--bg-filter-opacity)),rgba(0,0,0,var(--bg-filter-opacity))), var(--bg-img);
        height: 20em;
        width: 15em;
        font-size: 1.5em;
        color: white;
        border-radius: 1em;
        padding: 1em;
        /*margin: 2em;*/
        display: flex;
        align-items: flex-end;
        background-size: cover;
        background-position: center;
        box-shadow: 0 0 5em -1em black;
        transition: all, var(--transition-time);
        position: relative;
        overflow: hidden;
        border: 10px solid #ccc;
        text-decoration: none;
      }

      .card:hover {
        transform: rotate(0);
      }

      .card h1 {
        margin: 0;
        font-size: 1.5em;
        line-height: 1.2em;
      }

      .card p {
        font-size: 0.75em;
        font-family: 'Open Sans';
        margin-top: 0.5em;
        line-height: 2em;
      }

      .card .tags {
        display: flex;
      }

      .card .tags .tag {
        font-size: 0.75em;
        background: rgba(255,255,255,0.5);
        border-radius: 0.3rem;
        padding: 0 0.5em;
        margin-right: 0.5em;
        line-height: 1.5em;
        transition: all, var(--transition-time);
      }

      .card:hover .tags .tag {
        background: var(--color);
        color: white;
      }

      .card .date {
        position: absolute;
        top: 0;
        right: 0;
        font-size: 0.75em;
        padding: 1em;
        line-height: 1em;
        opacity: .8;
      }

      .card:before, .card:after {
        content: '';
        transform: scale(0);
        transform-origin: top left;
        border-radius: 50%;
        position: absolute;
        left: -50%;
        top: -50%;
        z-index: -5;
        transition: all, var(--transition-time);
        transition-timing-function: ease-in-out;
      }

      .card:before {
        background: #ddd;
        width: 250%;
        height: 250%;
      }

      .card:after {
        background: white;
        width: 200%;
        height: 200%;
      }

      .card:hover {
        color: var(--color);
      }

      .card:hover:before, .card:hover:after {
        transform: scale(1);
      }

      .info {
        font-size: 1.2em;
        display: block;
        padding: 1em 3em;
        height: 4em;
      }

      .info img {
        height: 3em;
        margin-right: 0.5em;
      }

      .info h1 {
        font-size: 1em;
        font-weight: normal;
      }

      /* MEDIA QUERIES */
      @media screen and (max-width: 1285px) {
        .cards-wrapper {
          grid-template-columns: 1fr 1fr;
        }
      }

      @media screen and (max-width: 900px) {
        .cards-wrapper {
          grid-template-columns: 1fr;
        }
        .info {
          justify-content: center;
        }
        .card-grid-space .num {
          /margin-left: 0;
          /text-align: center;
        }
      }

      @media screen and (max-width: 500px) {
        .cards-wrapper {
          padding: 4rem 2rem;
        }
        .card {
          max-width: calc(100vw - 4rem);
        }
      }

      @media screen and (max-width: 450px) {
        .info {
          display: block;
          text-align: center;
        }
        .info h1 {
          margin: 0;
        }
      }
    </style>
</head>

<body>
<!-- #include file='../landing.asp' -->
<section class="info">
  <h3 class="text-center">TRANSAKSI KARYAWAN</h3>
</section>
<section class="cards-wrapper">
  <%if session("HA8A") = true then%>
  <div class="card-grid-space">
    <a class="card" href="pinjaman/pinjamanKaryawan.asp" style="--bg-img: url(../logo/dolarpinjaman.jpg)">
      <div>
        <h1>PINJAMAN KARYWAAN</h1>
        <p>SEMUA RINCIAN PINJAMAN KARYAWAN</p>
        <div class="date"><%= date %></div>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HA8B") = true then%>
  <div class="card-grid-space">
    <a class="card" href="pembayaran/index.asp" style="--bg-img: url('../logo/pembayaran.jpg')">
      <div>
        <h1>PEMBAYARAN PINJAMAN KARYAWAN</h1>
        <p>Rincian Pembayaran Pinjaman Karyawan Dakota Cargo</p>
        <div class="date"><%= date %></div>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HA8C") = true then%>
  <div class="card-grid-space">
    <a class="card" href="mutasi" style="--bg-img: url('../logo/mutasipinjaman.jpg')">
      <div>
        <h1>MUTASI PINJAMAN KARYAWAN</h1>
        <p>Rincian Mutasi Pinjaman Karyawan</p>
        <div class="date"><%= date %></div>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HA8D") = true then%>
  <div class="card-grid-space">
    <a class="card" href="elektro/" style="--bg-img: url('../logo/elektro.jpg')">
      <div>
        <h1>PINJAMAN DAN PEMBAYARAN BARANG ELEKTRONIK</h1>
        <p>Proses ini hanya untuk karyawan yang mengambil dan membayar barang barang elektronik</p>
        <div class="date"><%= date %></div>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
  <%if session("HA8E") = true then%>
  <div class="card-grid-space">
    <a class="card" href="proses.asp" style="--bg-img: url('../logo/prosestransaksi.jpg')">
      <div>
        <h1>PROSES PINJAMAN KARYAWAN</h1>
        <p>WARNING!!</p>
        <p>Sebelum Anda Cek Mutasi Pembayaran Mohon Untuk Proses Terlebih Dahulu</p>
        <div class="date"><%= date %></div>
        <div class="tags">
          <div class="tag"><i class="fa fa-forward" aria-hidden="true"></i> NEXT</div>
        </div>
      </div>
    </a>
  </div>
  <%end if%>
</section>
<!-- #include file='../layout/footer.asp' -->