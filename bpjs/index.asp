<!-- #include file='../connection.asp' -->
<% 
set area = Server.CreateObject("ADODB.COmmand")
area.activeConnection = mm_cargo_string

area.commandText = "SELECT Agen_ID, Agen_Nama FROM GLB_M_Agen WHERE Agen_AktifYN = 'Y' AND Agen_Nama NOT LIKE '%XXX%' ORDER BY Agen_Nama ASC"

set agen = area.execute

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PERUBAHAN BPJS</title>
    <!-- #include file='../layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <script>
    function getNip(nip,nama,agen){
        $("#agen").val(agen);
        $("input[name='nama']").val(nama);
        $("input[name='nip']").val(nip);
    }
    </script>
    <style>
    body{
        margin:0;
        color:#6a6f8c;
        background:#c8c8c8;
        font:600 16px/18px 'Open Sans',sans-serif;
    }
    *,:after,:before{box-sizing:border-box}
    .clearfix:after,.clearfix:before{content:'';display:table}
    .clearfix:after{clear:both;display:block}
    a{color:inherit;text-decoration:none}

    .login-wrap{
        width:100%;
        margin:auto;
        max-width:525px;
        min-height:670px;
        position:relative;
        background:url(../logo/fuso.jpg) no-repeat center;
        box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
    }
    .login-html{
        width:100%;
        height:100%;
        position:absolute;
        padding:90px 70px 50px 70px;
        background:rgba(40,57,101,.9);
    }
    .login-html .sign-in-htm,
    .login-html .sign-up-htm{
        top:0;
        left:0;
        right:0;
        bottom:0;
        position:absolute;
        transform:rotateY(180deg);
        backface-visibility:hidden;
        transition:all .4s linear;
    }
    .login-html .sign-in,
    .login-html .sign-up,
    .login-form .group .check{
        display:none;
    }
    .login-html .tab,
    .login-form .group .label,
    .login-form .group .button{
        text-transform:uppercase;
    }
    .login-html .tab{
        font-size:22px;
        margin-right:15px;
        padding-bottom:5px;
        margin:0 15px 10px 0;
        display:inline-block;
        border-bottom:2px solid transparent;
    }
    .login-html .sign-in:checked + .tab,
    .login-html .sign-up:checked + .tab{
        color:#fff;
        border-color:#1161ee;
    }
    .login-form{
        min-height:345px;
        position:relative;
        perspective:1000px;
        transform-style:preserve-3d;
    }
    .login-form .group{
        margin-bottom:15px;
    }
    .login-form .group .label,
    .login-form .group .input,
    .login-form .group .button{
        width:100%;
        color:#c0c0c0;
        display:block;
    }
    .login-form .group .input,
    .login-form .group .button{
        border:none;
        padding:15px 20px;
        border-radius:25px;
        background:rgba(255,255,255,.1);
    }
    .login-form .group .label{
        color:#aaa;
        font-size:12px;
    }
    .login-form .group .button{
        background:#1161ee;
    }
    .login-form .group label .icon{
        width:15px;
        height:15px;
        border-radius:2px;
        position:relative;
        display:inline-block;
        /* justify-content:space-between; */
        background:rgba(255,255,255,.1);
    }
    .login-form .group label .icon:before,
    .login-form .group label .icon:after{
        content:'';
        width:10px;
        height:2px;
        background:#fff;
        position:absolute;
        transition:all .2s ease-in-out 0s;
    }
    .login-form .group label .icon:before{
        left:3px;
        width:5px;
        bottom:6px;
        transform:scale(0) rotate(0);
    }
    .login-form .group label .icon:after{
        top:6px;
        right:0;
        transform:scale(0) rotate(0);
    }
    .login-form .group .check:checked + label{
        color:#fff;
    }
    .login-form .group .check:checked + label .icon{
        background:#1161ee;
    }
    .login-form .group .check:checked + label .icon:before{
        transform:scale(1) rotate(45deg);
    }
    .login-form .group .check:checked + label .icon:after{
        transform:scale(1) rotate(-45deg);
    }
    .login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
        transform:rotate(0);
    }
    .login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
        transform:rotate(0);
    }

    .hr{
        height:2px;
        margin:60px 0 50px 0;
        background:rgba(255,255,255,.2);
    }
    .foot-lnk{
        text-align:center;
    }
    </style>
</head>

<body>
<div class="login-wrap">
    <form action="pbpjs.asp" method="post">
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked value="tambah"><label for="tab-1" class="tab">form</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up" value="update"><label for="tab-2" class="tab">daftar nama</label>
            <div class="login-form"> 
                <div class="sign-in-htm">
                    <div class="group">
                        <label for="agen" class="label">Agen</label>
                        <select class="input" aria-label="Default select example" id="agen" name="agen" required>
                            <option value="">Pilih</option>
                            <% do while not agen.eof %>
                                <option value="<%= agen("Agen_ID") %>"><%= agen("Agen_Nama") %></option>
                            <% 
                            agen.movenext
                            loop
                            %>
                        </select>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Nama</label>
                        <input id="pass" type="text" class="input" name="nama" autocomplete="off">
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Nip</label>
                        <input id="pass" type="number" class="input" name="nip" autocomplete="off" required>
                    </div>
                    <div class="group">
                        <input id="check" type="checkbox" class="check" name="kes" value="Y" checked>
                        <label for="check"><span class="icon"></span> BPJSKes</label>
                        <input id="check2" type="checkbox" class="check" name="ket" value="Y" checked>
                        <label for="check2"><span class="icon"></span> BPJSKet</label>
                    </div>
                    <div class="group">
                        <label for="pass" class="label">Tanggal</label>
                        <input id="pass" type="date" class="input" id="tgl" name="tgl" autocomplete="off" required>
                        <input id="pass" type="hidden" class="input" id="updateid" name="updateid" value="<%= session("username") %>">
                    </div>
                    <div class="group">
                        <input type="submit" class="button">
                    </div>
                    
                    <div class="foot-lnk">
					    <a href="../dashboard.asp" style="color:#fff;">Kembali</a>
				    </div>
                    <div class="hr"></div>
                    
                </div>
                <!--cari bynama -->
                <div class="sign-up-htm">
                    <div class="group">
                        <label for="user" class="label">Cari Nama</label>
                        <input id="user" type="text" class="input" name="user" autocomplete="off">
                    </div>
                    <div class="tampilNama" style="height:28rem;overflow:auto;">
                    </div>
                </div>
                <!--end cari nama -->
            </div>
        </div>
    </form>
</div>

<script>
    $( "#user" ).keyup(function() {
        let nama = $("#user").val();
         $.get('cariNama.asp?nama=' + nama, function (data) {
            $(".tampilNama").html(data);
        });
    });
</script>


<!-- #include file='../layout/footer.asp' -->