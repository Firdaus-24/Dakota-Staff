<!-- #include file='../connection.asp' -->
<% 
if session("HL5")= "" then 

	response.redirect("../dashboard.asp")

end if 
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SHIFT KARYAWAN</title>
    <!-- #include file='../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <style>
    .cards-list {
        z-index: 0;
        width: 100%;
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
    }
    a{
        text-decoration:none;
    }
    .btn-history{
        border:none;
        background:transparent;
    }
    .card {
        margin: 30px auto;
        width: 300px;
        height: 300px;
        border-radius: 40px;
        box-shadow: 5px 5px 30px 7px rgba(0,0,0,0.25), -5px -5px 30px 7px rgba(0,0,0,0.22);
        cursor: pointer;
        transition: 0.4s;
    }

    .card .card_image {
        width: inherit;
        height: inherit;
        border-radius: 40px;
    }

    .card .card_image img {
        width: inherit;
        height: inherit;
        border-radius: 40px;
        object-fit: cover;
    }

    .card .card_title {
        text-align: center;
        border-radius: 0px 0px 40px 40px;
        font-family: sans-serif;
        font-weight: bold;
        font-size: 21px;
        margin-top: 20px;
        height: 40px;
        color:#ffd700;
        text-transform:uppercase;
        letter-spacing:2px;
    }

    .card:hover {
        transform: scale(0.9, 0.9);
        box-shadow: 5px 5px 30px 15px rgba(0,0,0,0.25), -5px -5px 30px 15px rgba(0,0,0,0.22);
    }

    .title-white {
        color: white;
    }

    .title-black {
        color: black;
    }

    @media all and (max-width: 500px) {
        .card-list {
            /* On small screens, we are no longer using row direction but column */
            flex-direction: column;
        }
        .card{
            margin-bottom:50px;
        }
    }
    </style>
    <script>
        function btnAwal(){
            $(".filterAwal").show();
            $(".filterBulan").hide();
            $(".filterTahun").hide();
            $(".submit").hide();
            $(".close").hide();
            $("#tgla").prop('required',false);
            $("#tgle").prop('required',false);
            $("#tahun").prop('required',false);
        }
        function btnBulan(){
            $(".filterAwal").hide();
            $(".filterBulan").show();
            $(".submit").show();
            $(".close").show();
            $("#tgla").prop('required',true);
            $("#tgle").prop('required',true);
            $("#tahun").prop('required',false);
        }
        function btnTahun(){
            $(".filterAwal").hide();
            $(".filterTahun").show();
            $(".submit").show();
            $(".close").show();
            $("#tahun").prop('required',true);
            $("#tgla").prop('required',false);
            $("#tgle").prop('required',false);
        }
    </script>
</head>

<body>
<!-- #include file='../landing.asp' -->

<div class='container'>
    <div class='row'>
        <div class='col-lg text-center mt-3'>
            <h3>PERUBAHAN STATUS KARYAWAN</h3>
        </div>
    </div>
    <div class='row text-center'>
        <% if session("HL5A") = true then %>
        <div class='col-lg-6'>
            <a href="view_tambah.asp">
            <div class="card 3">
                <div class="card_image">
                    <img src="../logo/change.gif" />
                </div>
                <div class="card_title">
                    <p>Form Tambah</p>
                </div>
            </div>
            </a>
        </div>
        <% end if %>
        <% if session("HL5C") = true then %>
        <div class='col-lg-6'>
            <button type="button" class="btn-history" data-bs-toggle="modal" data-bs-target="#modalHistory" onclick="return btnAwal()">
            <div class="card 4">
                <div class="card_image">
                    <img src="../logo/updatechange.gif" />
                </div>
                <div class="card_title title-black">
                    <p>History</p>
                </div>
            </div>
            </button>
        </div>  
        <% end if %>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalHistory" tabindex="-1" aria-labelledby="historyLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="historyLabel">Form Filter History</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">

        <div class='filterAwal'>
            <div class='mb-3 row'>
                <div class='col text-center'>
                    <label>FILTER BERDASARKAN</label>
                </div>
            </div>
            <div class='row'>
                <div class='col text-center'>
                    <button type="button" class="btn btn-outline-success btn-sm" id="btnbulan" onclick="return btnBulan()">Bulan</button>
                    <button type="button" class="btn btn-outline-success btn-sm btntahun" onclick="return btnTahun()">Tahun</button>
                </div>
            </div>
        </div>
        
        <form action="history.asp" method="post">
        <!--filter perbulan -->
        <div class='filterBulan' style="display:none;">
            <div class='mb-3 row'>
                <div class='col text-center'>
                    <label>Pilih interval bulan</label>
                </div>
            </div>
            <div class="row mt-2 align-items-center justify-content-center">
                <div class="col-5">
                    <input type="date" id="tgla" name="tgla" class="form-control">
                </div>
                <div class="col-1 text-center">
                    <span>-</span>
                </div>
                <div class="col-5">
                    <input type="date" id="tgle" name="tgle" class="form-control">
                </div>
            </div>
        </div>
        <!--end filter -->
        
        <!--filter tahun -->
        <div class='filterTahun' style="display:none;">
            <div class='mb-3 row'>
                <div class='col text-center'>
                    <label>Pilih Tahun</label>
                </div>
            </div>
            <div class="row mt-2 align-items-center justify-content-center">
                <div class="col-5">
                    <input type="number" id="tahun" name="tahun" class="form-control">
                </div>
            </div>
        </div>
        <!--end filter -->

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary close" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary submit">Submit</button>
      </div>
      </form>
    </div>
  </div>
</div>
<!-- #include file='../layout/footer.asp' -->