<!-- #include file='connection.asp' -->
<% 
    if session("HA2") = false then
        Response.Redirect(url&"/dasboard.asp")
    end if
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SHIFT KARYAWAN</title>
    <!-- #include file='layout/header.asp' -->
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
            font-size: 30px;
            margin-top: -80px;
            height: 40px;
            color:#ffd700;
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
        }
    </style>
</head>

<body>
<!-- #include file='landing.asp' -->
<div class='container'>
    <div class='row'>
        <div class='col-lg text-center mt-3'>
            <h3>SHIFT KARYAWAN</h3>
        </div>
    </div>
    <div class='row'>
        <%if session("HA2A") = true then%>
        <div class='col-lg-6'>
            <a href="tambahShiftkerja.asp">
            <div class="card 3">
                <div class="card_image">
                    <img src="logo/giphy.gif" />
                </div>
                <div class="card_title">
                    <p>Setting Shift</p>
                </div>
            </div>
            </a>
        </div>
        <%end if%>
        <%if session("HA2B") = true then%>
        <div class='col-lg-6'>
            <a href="shiftkaryawan.asp">
            <div class="card 4">
                <div class="card_image">
                    <img src="logo/shiftdivisi.gif" />
                </div>
                <div class="card_title title-black">
                    <p>Shift Perdivisi</p>
                </div>
            </div>
            </a>
        </div> 
        <%end if%> 
    </div>
</div>







<!-- #include file='layout/footer.asp' -->