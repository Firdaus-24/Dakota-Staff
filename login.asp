<!-- #include file='nconnection.asp' -->
<% 
    dim cabang_cmd, cabang
    session.Abandon()

    set cabang_cmd = Server.CreateObject("ADODB.Command")
    cabang_cmd.activeConnection = MM_Cargo_String

    cabang_cmd.commandText = "SELECT agen_id, agen_nama FROM GLB_M_Agen WHERE Agen_AktifYN = 'Y' order by agen_nama"
    set cabang = cabang_cmd.execute
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- #include file='layout/header.asp' -->
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Righteous&display=swap');
    body{
        background-color:#fff;
    }
    .container {
        width: 415px;
        box-shadow: 0px 0px 18px 0px grey;
        border-radius: 24px;
        position: relative;
        background: inherit;
        padding: 12px;
        overflow: hidden;
        background: #5baeff;
        margin-top:20vh;
    }
    .container:before {
        /* width: 200px; */
        content: "";
        position: absolute;
        background: inherit;
        z-index: -1;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        box-shadow: inset 0 0 2000px rgba(255, 255, 255, .5);
        filter: blur(10px);
        margin: -20px;
    }
    .textbox{   
        width:auto;
        /* background: #5baeff; */
        overflow:hidden;
        font-size:20px;
        padding:8px 0;
        margin:8px 0;
        border-bottom: 1px solid #fff;
    }
    .textbox i {
        width:26px;
        float:left;
        margin-top:5px;
        color:#fff;
        text-align:center;
    }
    .textbox input{
        border:none;
        outline:none;
        background:none;
        color:white;
        font-size:18px;
        width:88%;
        margin:0 10px;
    }
    .textbox select{
        border:none;
        outline:none;
        background:transparent;
        background-color:#5baeff;
        color:#fff;
        font-size:18px;
        width:auto;
        margin:0 10px;
    }
    .btn{
        width:100%;
        background:#800000;
        color:white;
        font-size:18px;
        cursor:pointer;
        margin:12px 0;
    }
    h3
    {
        font-family:"Righteous";
        color:#fff;
    }
    img
    { 
        width:200px;
        position:fixed;
        margin-left:35%;
        margin-top:10px;
    }
    /* Portrait and Landscape */
    @media (min-device-width: 375px) and (max-device-width: 812px) and (-webkit-min-device-pixel-ratio: 3)
    { 
        .container {
            width: 360px;
            box-shadow: 0px 0px 18px 0px grey;
            border-radius: 24px;
            position: relative;
            background: inherit;
            padding: 12px;
            overflow: hidden;
            background: #5baeff;
            margin-top:20vh;
            margin-left:8px;
            margin-right:auto;
        }
        .textbox i {
            float:left;
            margin-top:5px;
            color:#fff;
            text-align:center;
        }
        .textbox{   
            width:auto;
            overflow:hidden;
            font-size:20px;
            padding:8px 0;
            margin:8px 0;
            border-bottom: 1px solid #fff;
        }
        .textbox input{
            border:none;
            outline:none;
            background:none;
            color:white;
            font-size:14px;
            width:85%;
            margin:0 10px;
        }
        .textbox select{
            border:none;
            outline:none;
            background:transparent;
            background-color:#5baeff;
            color:#fff;
            font-size:14px;
            width:auto;
            margin:0 10px;
        }
        .btn{
            width:100%;
            background:#800000;
            color:white;
            font-size:14px;
            cursor:pointer;
            margin:12px 0;
        }
        img
        { 
            width:100px;
            position:fixed;
            margin-left:5px;
            margin-top:10px;
        }
    }
    @media (min-width: 411px) and (max-width: 731px) {
        .container {
            width: 95%;
            box-shadow: 0px 0px 18px 0px grey;
            border-radius: 24px;
            position: relative;
            background: inherit;
            padding: 12px;
            overflow: hidden;
            background: #5baeff;
            margin-top:20vh;
        }
        .textbox i {
            float:left;
            margin-top:5px;
            color:#fff;
            text-align:center;
        }
        .textbox{   
            width:auto;
            overflow:hidden;
            font-size:20px;
            padding:8px 0;
            margin:8px 0;
            border-bottom: 1px solid #fff;
        }
        .textbox input{
            border:none;
            outline:none;
            background:none;
            color:white;
            font-size:14px;
            width:85%;
            margin:0 10px;
        }
        .textbox select{
            border:none;
            outline:none;
            background:transparent;
            background-color:#5baeff;
            color:#fff;
            font-size:14px;
            width:auto;
            margin:0 10px;
        }
        img
        { 
            width:150px;
            position:fixed;
            margin-left:5px;
            margin-top:10px;
        }
    }
    
    </style>
</head>

<body>
<div class='container'>
    <div class='row'>
        <div class='col mt-3 text-center'>
            <h3>LOGIN</h3>
        </div>
    </div>
    <form action="login_add.asp" method="post">
    <div class='row'>
        <div class='col'>
            <div class='textbox'>
                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                <input type="text" name="username" id="username"autocomplete="off">
            </div>
            <div class='textbox'>
                <i class="fa fa-lock" aria-hidden="true"></i>
                <input type="password" name="password" id="password"autocomplete="off">
            </div>
            <div class='textbox'>
                <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="cabang" id="cabang">
                    <option>Pilih</option>
                    <% 
                    do until cabang.eof
                    %>
                    <option value="<%=cabang("agen_id")%>"><%=cabang("agen_nama")%></option>
                    <% 
                    cabang.movenext
                    loop
                    %>
                </select>
            </div>
                <input class="btn" type="submit" name="submit" id="submit" value="SIGN-IN" onclick="return validasilogin()">
     </form>
            </div>
        </div>
    </div>
    <img src="logo/landing.png">
</div>
<script>
    function validasilogin() {
        var nama = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		if (nama != "" && password!="") {
			return true;
		}else{
			alert('Data harus diisi dahulu !');
            return false;
		}
    }
</script>
<!-- #include file='layout/footer.asp' -->
