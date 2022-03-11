<!-- #include file='../connection.asp' -->
<!-- #include file='../md5.asp' -->
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <style>
    .notiv-gagal{
        width:400px;
        height:200px;
        padding:20px;
        background:#718ee3;
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px;
        border-radius:20px;
    }
    .notiv-gagal span{
        float:right;
        margin-top:40px;
        color:white;
        font-size:20px;
        text-transform:uppercase;
    }
    .notiv-gagal img{
        display:block;
        width:100px;
        height:130px;
    }   
    .notiv-gagal a{
        display:block;
    }
    /* done */
      .notiv-berhasil{
        width:400px;
        height:200px;
        padding:20px;
        background:#718ee3;
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -120px;
        margin-left: -220px;
        border-radius:20px;
    }
    .notiv-berhasil span{
        float:left;
        margin-top:40px;
        color:white;
        font-size:20px;
        text-transform:uppercase;
    }
    .notiv-berhasil img{
        display:inline-block;
        width:120px;
        height:130px;
        margin-left:20px;
    }   
    .notiv-berhasil a{
        display:block;
    }
    </style>
<% 
dim username, password, aktifyn, serverid, suername
dim adduser, userop_cmd,userop

username = Request.Form("username")
password = md5(Request.Form("password"))
aktifyn = Request.Form("aktifyn")
serverid = Request.Form("serverid")
surename = Request.Form("realname")

set adduser = Server.CreateObject("ADODB.Command")
adduser.activeConnection = MM_Cargo_string

set userop_cmd = Server.CreateObject("ADODB.Command")
userop_cmd.activeConnection = MM_Cargo_string

userop_cmd.commandText = "SELECT * FROM webLogin WHERE username = '"& username &"' and serverID = '"& serverid &"'"
set userop = userop_cmd.execute

if userop.eof = false then
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Sudah Terdaftar</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a></div>"
else
    adduser.commandText = "INSERT INTO WebLogin (username,password,user_AktifYN,ServerID,realName,LastLogin,LastIPLogin,PT_ID) VALUES ('"& username &"','"& password &"','Y','"& serverid &"', '"& surename &"','"& date &"','192.168.22.3','A' )"
    'Response.Write adduser.commandText
    adduser.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-up'><span>Data Berhasil Disimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='checkakses.asp?username="& username &"&serverid="& serverid &"' class='btn btn-primary'>Masuk</a></div>"
end if
 %>
 <!-- #include file='../layout/footer.asp' -->