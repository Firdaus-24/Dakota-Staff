<!--#include file="connection.asp"-->
<% 
dim nip, tanggalshift
nip = request.queryString("nip")
id = Request.QueryString("id")


set tanggalshift = server.createObject("ADODB.Command")
tanggalshift.activeConnection = MM_Cargo_string

tanggalshift.commandText = "SELECT dbo.HRD_M_Karyawan.Kry_NIP, HRD_M_Divisi.Div_Nama, dbo.HRD_M_Karyawan.Kry_Nama, dbo.HRD_M_Karyawan.Kry_GSCode, dbo.HRD_T_Shift.Shf_GSCode, dbo.HRD_T_Shift.Sh_ID, dbo.HRD_T_Shift.Shf_NIP, dbo.HRD_T_Shift.Shf_Tanggal, dbo.HRD_T_Shift.Shf_updateID, dbo.HRD_T_Shift.shf_UpdateTime FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.HRD_T_Shift ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Shift.Shf_NIP LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code WHERE dbo.HRD_T_Shift.Shf_NIP = '"& nip &"'"
set tanggal = tanggalshift.execute

 %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kalender Shift</title>
    <!--#include file="layout/header.asp"-->
    <script src="<%= url %>/js/jquery-3.5.1.min.js"></script> 
    <style>
        .hero{
            width:100%;
            height:100%;
            background:linear-gradient(45deg,#6ac1c5,#bda5ff);
            position:relative;
        }
        #calendar{
            width:80%;
            height:35rem;
            position:fixed;
            margin-top:24%;
            left:50%;
            transform:translate(-50%,-50%);
        }
        /* all android */
        @media (min-width: 411px) and (max-width: 731px) {
            #calendar{
                margin-top:20rem;
            }
        }
        /* iphonex */
        @media (min-width: 375px) and (max-width: 812px) {
            #calendar{
                margin-top:20rem;
            }
        }
        .parent{
            width: 100vw;
            height: 100vh;
            background-color: #8773C1;
        }
        .colKalender{
           position:absolute;
           top:50%;
           left:50%;
           transform:translate(-50%, -50%);
           padding:3rem;
           color:#fff;
           background:#d84315;
        }
        .colKalender button {
            display: block;
            text-transform: uppercase;
            position:relative;
            margin: 20px auto;
            width:12%;
            cursor: pointer;
            color: #fff;
            background: transparent;
            border: 1px solid  #fff;
            text-align: center;
            font-size: 1.5vw;
            font-weight: bold;
            padding: 1vw 0;
            text-shadow:1px 1px hsla(0,5%,5%,.3), 2px 2px hsla(0,5%,5%,.3);
            overflow:hidden;
            transition: all 0.3s ease-in;
        }
        button:hover{
            color:hsla(0, 0%, 15%, .5);
            background:#8773C1;
            color:#D84315;
            border: 1px solid  #8773C1;
        }
        button:focus{
            color:hsla(0, 0%, 5%, 1);
        }
    </style>
</head>
<body> 
<% if tanggal.eof then %>
    <div class='row parent'>
        <div class='col-lg-12 col-sm-12 col-md-12 colKalender'>
            <h3>Data Belum Tersedia</h3></br>
            <Label>Mohon Untuk Cek Kembali Daftar Shift Karyawan</label></br>
            <button onclick="window.location.href='daftarkaryawanshift.asp?id=<%=id%>'">Kembali</button>
        </div>
    </div>
<% else %>
    <div class='row'>
        <div class='col-lg'>
            <input type="hidden" name="tanggal" id="tanggal" value="<%do until tanggal.eof  Response.Write tanggal("Shf_tanggal") %> <%= "," %>
            <%  tanggal.movenext
            loop
            tanggal.movefirst %> ">
            <input type='hidden' name='nama' id='nama' value="<%=tanggal("Kry_Nama")%>">
            <input type='hidden' name='divisi' id='divisi' value="<%=tanggal("Div_Nama")%>">
        </div>
    </div>
    <div class='row'>
        <div class='col-lg'>
            <div class="hero">
                <div id="calendar"></div>
            </div>
        </div>
    </div>
<% end if %>
<!-- Add jQuery library (required) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>
<!--#include file="layout/footer.asp"-->
<script>
    // initialize kalender
    $(document).ready(function() {
        var id = $('#tanggal').val();
        var tanggal = id.split(',');
        let nama = $('#nama').val();
        let divisi = $('#divisi').val();
        var result = tanggal.map((el, idx) =>
        {
        return {        
            id : 'shift', // Event's ID 
            name:  "Sudah Setting Shift", // Event name 
            date:   el, // Event date 
            type:  "holiday", // Event type 
            format: 'mm/dd/yyyy',
            description: `${nama},  ${divisi}.`// Event description (optional)
            }
            }
        )
        $('#calendar').evoCalendar({
            calendarEvents: result
        });
        
    });
 
</script>