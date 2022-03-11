<!-- #include file='../connection.asp' -->
<!-- #include file='../layout/header.asp' -->
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
dim code, nama
dim jenjnagupdate

code = trim(Request.QueryString("code"))
nama = trim(Request.form("nama"))
set jenjang_cmd = Server.CreateObject("ADODB.Command")
jenjang_cmd.activeConnection = MM_Cargo_string

set jenjangupdate = Server.CreateObject("ADODB.Command")
jenjangupdate.activeConnection = MM_Cargo_string

jenjangupdate.commandText = "SELECT * FROM HRD_M_Jenjang WHERE JJ_Nama = '"& nama &"'"
set jenjang = jenjangupdate.execute


if jenjang.eof = true then
    jenjang_cmd.commandText = "UPDATE HRD_M_jenjang SET JJ_Nama = '"& nama &"' WHERE JJ_ID = '"& code &"'"
    jenjang_cmd.execute
    Response.Write "<div class='notiv-berhasil' data-aos='fade-right'><span>Data tersimpan</span><img src='../logo/berhasil_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
else
    Response.Write "<div class='notiv-gagal' data-aos='fade-right'><span>Data sudah terdaftar</span><img src='../logo/stop_dakota.PNG'><a href='index.asp' class='btn btn-primary'>kembali</a href='index.asp'></div>"
end if


 %> 
<!-- #include file='../layout/footer.asp' -->
