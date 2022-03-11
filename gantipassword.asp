<!-- #include file='connection.asp' -->
<!-- #include file='constend/constanta.asp' -->
<% 
if session("username") = "" then
response.Redirect("login.asp")
end if

dim username,serverid, login_cmd,login
dim passwordLama, passwordBaru, ulang, eror, salah, berhasil, user, cabang

username = Request.queryString("username")
serverid = Request.queryString("serverid")

user = username
cabang = serverid

msgError = Request.QueryString("msgError") 
if msgError = "p" then
   eror = "ANDA SALAH MEMASUKAN PASSWORD LAMA"
elseIf msgError = "q" then
   eror = "PASSWORD TIDAK SESUAI MOHON CEK KEMBALI"
else
    eror = ""
end if

msgOK = Request.QueryString("msgOK") 
if msgOK = "q" then
    success = "SUKSES MENGGANTI PASSWORD"
else 
    success = ""
end if
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ganti Password</title>
    <!-- #include file='layout/header.asp' -->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script>
    <style>
    .vertical-center {
        min-height: 100%;  /* Fallback for browsers do NOT support vh unit */
        min-height: 100vh; /* These two lines are counted as one :-)       */

        display: flex;
        align-items: center;
    }
    @font-face{
        font-family: 'butbank';
        src: url('layout/font/burbank-bold.otf');
    }
    .header label{
        font-family:"butbank";
        font-size:30px;
    }
    .conatiner{
        width:auto;
        height:auto;
        display: flex;
        align-items: center;
    }
    .form-control:focus{
        border-color: inherit;
        -webkit-box-shadow: none;
        box-shadow: none;
    }
    .tombolLama{
        position:relative;
    }
    .buttonPasswordLama{
        background:none;
        border:none;
        margin: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    .tombolBaru{
        position:relative;
    }
    .buttonPasswordBaru{
        background:none;
        border:none;
        margin: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    .ketik{
        position:relative;
    }
    .buttonKetik{
        background:none;
        border:none;
        margin: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    #submit{
        background:transparent;
        color:black;
        border-color:black;
        text-transform: uppercase;
        transition: transform .2s;
    }
    #submit:hover{
        background-color:red;
        color:white;
        transform: scale(1.1);
    }
    @media only screen and (max-width: 600px) {
        .content {
            justify-content:center;
            align-items:center;
            margin-left:15px;
            margin-right:15px;
        }
        .content form{
            text-align:center;
        }
    }
    </style>
</head>

<body>
<div class='vertical-center'>
    <div class='container'>
        <div class='row header'>
            <div class='col mb-2 text-center label'>
                <label>FORM GANTI PASSWORD<label>
            </div>
        </div>

		<% if msgError <> "" then%>
            <div class='row' style="justify-content:center;align-items:center;">
                <div class='col-sm-7'>
                    <div class="alert alert-danger  alert-dismissible fade show" role="alert">
                        <label><%=eror%></label>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </div>
		<% end if %>
        
        <% if msgOK <> "" then %>
            <div class='row' style="justify-content:center;align-items:center;">
                <div class='col-sm-7'>
                    <div class="alert alert-primary alert-dismissible fade show" role="alert">
                        <label><%=success%></label>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </div>
        <% end if %>

        <div class='content'>
            <form action="gantipassword_add.asp" method="post">
            <input type='hidden' class='form-control' name='username' id='username' value="<%= username %>">
            <input type='hidden' class='form-control' name='serverid' id='serverid' value="<%= serverid %>">

            <div class="mb-3 row" style="justify-content:center;align-items:center;">
                <div class="col-sm-2">
                    <label for="passwordLama" class="col-form-label">Password Lama</label>.
                </div>
                <div class="col-sm-5">
                    <div class="row" style="border:1px solid black;border-radius:5px;" >
                        <div class="col-11">
                            <input type="password" class="form-control" id="passwordLama" name="passwordLama" autocomplete="off" required style="border:none;">
                        </div>
                        <div class='col-1 tombolLama'>
                            <button type="button" class="buttonPasswordLama" id="buttonPasswordLama"><span><i class="fa fa-eye" aria-hidden="true" id="read"></i></span></button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-3 row" style="justify-content:center;align-items:center;">
                <div class="col-sm-2">
                    <label for="passwordBaru" class="col-form-label">Password Baru</label>.
                </div>
                <div class="col-sm-5">
                    <div class="row" style="border:1px solid black;border-radius:5px;" >
                        <div class="col-11">
                            <input type="password" class="form-control" id="passwordBaru" name="passwordBaru" autocomplete="off" required style="border:none;">
                        </div>
                        <div class='col-1 tombolBaru'>
                            <button type="button" class="buttonPasswordBaru" id="buttonPasswordBaru"><span><i class="fa fa-eye" aria-hidden="true" id="read1"></i></span></button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mb-3 row" style="justify-content:center;align-items:center;">
                <div class="col-sm-2">
                    <label for="ulang" class="col-form-label">Ketik Ulang</label>.
                </div>
                <div class="col-sm-5">
                    <div class="row" style="border:1px solid black;border-radius:5px;" >
                        <div class="col-11">
                            <input type="password" class="form-control" id="ulang" name="ulang" autocomplete="off" required style="border:none;">
                        </div>
                        <div class='col-1 ketik'>
                            <button type="button" class="buttonKetik" id="buttonKetik"><span><i class="fa fa-eye" aria-hidden="true" id="read2"></i></span></button>
                        </div>
                    </div>
                </div>
            </div>

            <div class='row submit'>
                <div class='col text-center'>
                    <button type="submit" class="btn btn-primary" id="submit">Ubah</button>
                    <button type="button" class="btn btn-primary" id="submit" onclick="window.location.href='dashboard.asp'">KEMBALI</button>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(".buttonPasswordLama").on("click", function(){
        if ($("#passwordLama").attr("type") == "text"){
            $("#passwordLama").attr("type","password");
            $("#read").attr("class","fa fa-eye");
        }else{
            $("#passwordLama").attr("type","text");
            $("#read").attr("class","fa fa-eye-slash");
        }
    });

    $(".buttonPasswordBaru").on("click", function(){
        if ($("#passwordBaru").attr("type") == "text"){
            $("#passwordBaru").attr("type","password");
            $("#read1").attr("class","fa fa-eye");
        }else{
            $("#passwordBaru").attr("type","text");
            $("#read1").attr("class","fa fa-eye-slash");
        }
    });
    
    $(".buttonKetik").on("click", function(){
        if ($("#ulang").attr("type") == "text"){
            $("#ulang").attr("type","password");
            $("#read2").attr("class","fa fa-eye");
        }else{
            $("#ulang").attr("type","text");
            $("#read2").attr("class","fa fa-eye-slash");
        }
    });
</script>
<!-- #include file='layout/footer.asp' -->