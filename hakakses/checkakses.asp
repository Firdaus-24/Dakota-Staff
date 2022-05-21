<!-- #include file='../connection.asp' -->
<% 
    dim usernameu, serveridu
    dim pusername, pserverid, app_cmd, app

    'yang di usernamenew_add
    pusername = Request.QueryString("username")
    pserverid = Request.QueryString("serverid")

    set app_cmd = Server.CreateObject("ADODB.Command")
    app_cmd.activeConnection = MM_Cargo_String

    'app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"')"
    'set app = app_cmd.execute
    'do while not app.eof

    ' session(app("appIDRights"))=true

    'app.movenext
    'loop
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check Akses</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        *{
            font-family: Verdana, Geneva, Tahoma, sans-serif;
        }
        ul li {
            list-style: none;
        }
    </style>
</head>
<body>
<div class='container'>
    <div class='row'>
        <div class='col'>
            <div class="judul text-center mt-3">
                <h3>DAFTAR HAKAKSES</h3>
            </div> 
            <form action="checkakses_add.asp" method="post">
                <input type='hidden' name='uname' id='uname' value="<%=pusername%>">
                <input type='hidden' name='serverID' id='serverID' value="<%=pserverid%>">
            <div class="accordion" id="accordionExample">
                <!--karyawan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-controls="collapseOne">
                        DAFTAR KARYAWAN
                    </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                                <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1'"
                                    set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA1" id="HA1" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1');" >
                                <label for="HA1">Karyawan</label>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA1A" id="HA1A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1A');" >
                                    <label for="HA1A">Tambah Karyawan</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA1D" id="HA1D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1D');" >
                                    <label for="HA1D">AktifYN</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1E'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA1E" id="HA1E" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1E');" >
                                    <label for="HA1E">UpdateNip</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end karyawan -->
                <!--menu master karyawan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="hendling10">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse10" aria-expanded="false" aria-controls="collapse10">
                        MENU MASTER KARYAWAN
                    </button>
                    </h2>
                    <div id="collapse10" class="accordion-collapse collapse" aria-labelledby="hendling10" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM1'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM1" id="HM1" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM1');" >
                                    <label for="HM1">Biografi</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1B'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HA1B" id="HA1B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1B');" >
                                            <label for="HA1B">Update Karyawan</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1C'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HA1C" id="HA1C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1C');" >
                                            <label for="HA1C">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM2'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM2" id="HM2" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM2');" >
                                    <label for="HM2">Keluarga 1</label>
                                </li>   
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM2A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM2A" id="HM2A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM2A');" >
                                            <label for="HM2A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM2B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM2B" id="HM2B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM2B');" >
                                            <label for="HM2B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM2C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM2C" id="HM2C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM2C');" >
                                            <label for="HM2C">Hapus</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM3'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM3" id="HM3" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM3');" >
                                    <label for="HM3">Keluarga 2</label>
                                </li>   
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM3A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM3A" id="HM3A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM3A');" >
                                            <label for="HM3A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM3B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM3B" id="HM3B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM3B');" >
                                            <label for="HM3B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM3C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM3C" id="HM3C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM3C');" >
                                            <label for="HM3C">Hapus</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM4'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM4" id="HM4" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM4');" >
                                    <label for="HM4">Kesehatan</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM4A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM4A" id="HM4A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM4A');" >
                                            <label for="HM4A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM4B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM4B" id="HM4B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM4B');" >
                                            <label for="HM4B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM4C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM4C" id="HM4C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM4C');" >
                                            <label for="HM4C">Hapus</label>
                                        </li>
                                    </ul>   
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM5'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM5" id="HM5" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM5');" >
                                    <label for="HM5">Pendidikan</label>
                                </li>  
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM5A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM5A" id="HM5A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM5A');" >
                                            <label for="HM5A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM5B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM5B" id="HM5B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM5B');" >
                                            <label for="HM5B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM5C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM5C" id="HM5C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM5C');" >
                                            <label for="HM5C">Hapus</label>
                                        </li>
                                    </ul>  
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM6'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM6" id="HM6" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM6');" >
                                    <label for="HM6">Pekerjaan</label>
                                </li>   
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM6A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM6A" id="HM6A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM6A');" >
                                            <label for="HM6A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM6B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM6B" id="HM6B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM6B');" >
                                            <label for="HM6B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM6C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM6C" id="HM6C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM6C');" >
                                            <label for="HM6C">Hapus</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM7'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM7" id="HM7" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM7');" >
                                    <label for="HM7">Catatan</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM7A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM7A" id="HM7A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM7A');" >
                                            <label for="HM7A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM7B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM7B" id="HM7B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM7B');" >
                                            <label for="HM7B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM7C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM7C" id="HM7C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM7C');" >
                                            <label for="HM7C">Aktif Y/N</label>
                                        </li>
                                    </ul>   
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM8'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM8" id="HM8" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM8');" >
                                    <label for="HM8">Status</label>
                                </li>   
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM8A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM8A" id="HM8A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM8A');" >
                                            <label for="HM8A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM8B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM8B" id="HM8B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM8B');" >
                                            <label for="HM8B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM8C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM8C" id="HM8C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM8C');" >
                                            <label for="HM8C">Hapus</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM9'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM9" id="HM9" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM9');" >
                                    <label for="HM9">Mutasi</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM9A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM9A" id="HM9A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM9A');" >
                                            <label for="HM9A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM9B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM9B" id="HM9B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM9B');" >
                                            <label for="HM9B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM9C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM9C" id="HM9C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM9C');" >
                                            <label for="HM9C">Aktif Y/N</label>
                                        </li>
                                    </ul>   
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM10'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM10" id="HM10" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM10');" >
                                    <label for="HM10">CutiIzinSakit</label>
                                </li>  
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM10A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM10A" id="HM10A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM10A');" >
                                            <label for="HM10A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM10B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM10B" id="HM10B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM10B');" >
                                            <label for="HM10B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM10C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM10C" id="HM10C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM10C');" >
                                            <label for="HM10C">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM10D'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM10D" id="HM10D" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM10D');" >
                                            <label for="HM10D">Upload surat dokter</label>
                                        </li>
                                    </ul> 
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM11'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM11" id="HM11" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM11');" >
                                    <label for="HM11">Absensi</label>
                                </li>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM12'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HM12" id="HM12" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM12');" >
                                    <label for="HM12">Perjanjian</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM12A'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM12A" id="HM12A" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM12A');" >
                                            <label for="HM12A">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM12B'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM12B" id="HM12B" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM12B');" >
                                            <label for="HM12B">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HM12C'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HM12C" id="HM12C" <%if app.eof = false then%> checked <%end if%> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HM12C');" >
                                            <label for="HM12C">Aktif Y/N</label>
                                        </li>
                                    </ul>   
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end menu master karyawan -->
                <!--dashboard -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                    DASHBOARD
                    </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                                <ul>
                                    <li>
                                        <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL'"
                                        set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL" id="HL" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL');" >
                                        <label for="HL">Form Laporan</label>
                                    </li>
                                    <li>
                                        <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL2'"
                                        set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL2" id="HL2" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL2');" >
                                        <label for="HL2">Laporan Absensi</label>
                                    </li>
                                        <ul>
                                            <li>
                                                <%
                                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL2A'"
                                                    set app = app_cmd.execute
                                                    %>
                                                    <input class="form-check-input" type="checkbox" name="HL2A" id="HL2A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL2A');" >
                                                    <label for="HL2A">exportXls</label>
                                            </li>
                                        </ul>
                                    <li>
                                        <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL8'"
                                        set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL8" id="HL8" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL8');" >
                                        <label for="HL8">Libur Priodik</label>
                                    </li>
                                        <ul>
                                            <li>
                                                <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL8A'"
                                                set app = app_cmd.execute
                                                %>
                                                <input class="form-check-input" type="checkbox" name="HL8A" id="HL8A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL8A');" >
                                                <label for="HL8A">Tambah</label>
                                            </li>
                                            <li>
                                                <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL8B'"
                                                set app = app_cmd.execute
                                                %>
                                                <input class="form-check-input" type="checkbox" name="HL8B" id="HL8B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL8B');" >
                                                <label for="HL8B">AktifYN</label>
                                            </li>
                                        </ul>
                                    <li>
                                        <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL3'"
                                        set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL3" id="HL3" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL3');" >
                                        <label for="HL3">Approve Cuti Izin Sakit</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL4'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL4" id="HL4" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL4');" >
                                        <label for="HL4">BPJS</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL5'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL5" id="HL5" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL5');" >
                                        <label for="HL5">Perubahan Status</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL6'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL6" id="HL6" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL6');" >
                                        <label for="HL6">Update Data Login</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL7'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL7" id="HL7" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL7');" >
                                        <label for="HL7">Gaji ALL</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL9'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL9" id="HL9" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL9');" >
                                        <label for="HL9">Import File</label>
                                    </li>
                                </ul>
                        </div>
                    </div>
                </div>
                <!--end dashboard -->
                <!--shiftkaryawan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        SHIFT KARYAWAN
                    </button>
                    </h2>
                    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2'"
                                set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HA2" id="HA2" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2');" >
                            <label for="HA2">Shift Karyawan</label>
                            <ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2A'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA2A" id="HA2A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2A');" >
                                    <label for="HA2A">Setting Shift</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2AA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HA2AA" id="HA2AA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2AA');" >
                                            <label for="HA2AA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2AB'"
                                                set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HA2AB" id="HA2AB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2AB');" >
                                            <label for="HA2AB">Update</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2B'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA2B" id="HA2B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2B');" >
                                    <label for="HA2B">Shift Perdivisi</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end shiftkaryawan -->
                <!--master shift -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                        MASTER SHIFT
                    </button>
                    </h2>
                    <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <%
                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA3'"
                            set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HA3" id="HA3" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA3');" >
                            <label for="HA3">Master Shift</label>
                
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA3A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA3A" id="HA3A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA3A');" >
                                    <label for="HA3A">Tambah</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA3B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA3B" id="HA3B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA3B');" >
                                    <label for="HA3B">AktifYN</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end mastershift -->
                <!--divisi -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                        DIVISI
                    </button>
                    </h2>
                    <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
				    <%
						app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA4'"
						set app = app_cmd.execute
					%>
                        <input class="form-check-input" type="checkbox" name="HA4" id="HA4" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA4');" >
                        <label for="HA4">DIVISI</label>
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA4A'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA4A" id="HA4A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA4A');" >
                                <label for="HA4A">Tambah</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA4B'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA4B" id="HA4B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA4B');" >
                                <label for="HA4B">Update</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA4C'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA4C" id="HA4C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA4C');" >
                                <label for="HA4C">Aktif Y/N</label>
                            </li>
                        </ul>
                    </div>
                    </div>
                </div>
                <!--end divisi -->
                <!--jenjang -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                       JENJANG
                    </button>
                    </h2>
                    <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">

                            <%
                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA5'"
                            set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HA5" id="HA5" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA5');" >
                            <label for="HA5">Jenjang</label>
                        
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA5D'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA5D" id="HA5D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA5D');" >
                                <label for="HA5D">Tambah</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA5A'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA5A" id="HA5A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA5A');" >
                                <label for="HA5A">Update</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA5B'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA5B" id="HA5B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA5B');" >
                                <label for="HA5B">Aktif Y/N</label>
                            </li>
                        </ul>
                        </div>
                    </div>
                </div>
                <!--end jenjang -->
                <!--jabatan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
                       JABATAN
                    </button>
                    </h2>
                    <div id="collapseSeven" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <%
                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA6'"
                            set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HA6" id="HA6" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA6');">
                            <label for="HA6">JABATAN</label>
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA6D'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA6D" id="HA6D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA6D');">
                                <label for="HA6D">Tambah</label>
                            </li>
                            <li>
                                <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA6A'"
                                    set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA6A" id="HA6A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA6A');">
                                <label for="HA6A">Update</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA6B'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HA6B" id="HA6B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA6B');">
                                <label for="HA6B">Aktif Y/N</label>
                            </li>
                        </ul>
                        </div>
                    </div>
                </div>
                <!--end jenjang -->
                <!--laporan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
                    LAPORAN
                    </button>
                    </h2>
                    <div id="collapseNine" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                        <ul>
                            <li>
                                <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1A'"
                                    set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1A" id="HL1A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1A');">
                                <label for="HL1A">Daftar Karyawan</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1B'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1B" id="HL1B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1B');">
                                <label for="HL1B">Karyawan Kontrak</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1C'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1C" id="HL1C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1C');">
                                <label for="HL1C">Wajib Pajak</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1D'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1D" id="HL1D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1D');">
                                <label for="HL1D">Cuti PerPriode</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1E'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1E" id="HL1E" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1E');">
                                <label for="HL1E">Gaji Pernama</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1F'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1F" id="HL1F" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1F');">
                                <label for="HL1F">Gaji Perdivisi</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1G'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1G" id="HL1G" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1G');">
                                <label for="HL1G">Gaji Percabang</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1H'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1H" id="HL1H" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1H');">
                                <label for="HL1H">Karyawan Harian</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1I'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1I" id="HL1I" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1I');">
                                <label for="HL1I">Karyawan Keluar</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1J'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1J" id="HL1J" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1J');">
                                <label for="HL1J">Karyawan Perubahan Gaji</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1K'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1K" id="HL1K" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1K');">
                                <label for="HL1K">Karyawan Mutasi</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1L'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1L" id="HL1L" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1L');">
                                <label for="HL1L">Karyawan Demosi</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1M'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1M" id="HL1M" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1M');">
                                <label for="HL1M">Karyawan Rotasi</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1N'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1N" id="HL1N" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1N');">
                                <label for="HL1N">Karyawan Promorsi</label>
                            </li>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL1O'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HL1O" id="HL1O" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL1O');">
                                <label for="HL1O">Rekapgaji Karyawan 3</label>
                            </li>
                        </ul>
                        </div>
                    </div>
                </div>
                <!--end laporan -->
                <!--perubahan status karyawan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#detailPerubahan" aria-expanded="false" aria-controls="detailPerubahan">
                        PERUBAHAN DETAIL STATUS KARYAWAN
                    </button>
                    </h2>
                    <div id="detailPerubahan" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL5A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HL5A" id="HL5A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL5A');" >
                                    <label for="HL5A">Tambah</label>
                                </li>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL5B'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HL5B" id="HL5B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL5B');" >
                                    <label for="HL5B">Ubah Status</label>
                                </li>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL5C'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HL5C" id="HL5C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL5C');" >
                                    <label for="HL5C">History</label>
                                </li>
                            </ul>



                        </div>
                    </div>
                </div>
                <!--end perubahan -->
                <!--penghasilan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingEleven">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseeleven" aria-expanded="false" aria-controls="collapseeleven">
                       PENGHASILAN
                    </button>
                    </h2>
                    <div id="collapseeleven" class="accordion-collapse collapse" aria-labelledby="headingEleven" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <%
                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA7'"
                            set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HA7" id="HA7" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA7');">
                            <label for="HA7">Penghasilan</label>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA7E'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA7E" id="HA7E" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA7E');">
                                    <label for="HA7E">Tambah</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA7A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA7A" id="HA7A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA7A');">
                                    <label for="HA7A">Update</label>
                                </li>
                                <li>
                                    <%  
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA7B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA7B" id="HA7B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA7B');">
                                    <label for="HA7B">Aktif Y/N</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA7D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA7D" id="HA7D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA7D');">
                                    <label for="HA7D">Gaji ALL Karyawan</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--end penghasilan -->
                <!--transaksi klaim -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingEleven">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collap9" aria-expanded="false" aria-controls="collap9">
                        TRANSAKSI KLAIM
                    </button>
                    </h2>
                    <div id="collap9" class="accordion-collapse collapse" aria-labelledby="headingEleven" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <%
                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1'"
                            set app = app_cmd.execute
                            %>
                            <input class="form-check-input" type="checkbox" name="HT1" id="HT1" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1');">
                            <label for="HT1">Transaksi Klaim</label>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT1A" id="HT1A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1A');">
                                    <label for="HT1A">Pinjaman</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1AA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1AA" id="HT1AA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1AA');">
                                            <label for="HT1AA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1AB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1AB" id="HT1AB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1AB');">
                                            <label for="HT1AB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1AC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1AC" id="HT1AC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1AC');">
                                            <label for="HT1AC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1AD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1AD" id="HT1AD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1AD');">
                                            <label for="HT1AD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT1B" id="HT1B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1B');">
                                    <label for="HT1B">Pembayaran</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1BA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1BA" id="HT1BA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1BA');">
                                            <label for="HT1BA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1BB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1BB" id="HT1BB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1BB');">
                                            <label for="HT1BB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1BC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1BC" id="HT1BC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1BC');">
                                            <label for="HT1BC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1BD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT1BD" id="HT1BD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1BD');">
                                            <label for="HT1BD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%  
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1C'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT1C" id="HT1C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1C');">
                                    <label for="HT1C">Mutasi Pinjaman</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT1D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT1D" id="HT1D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT1D');">
                                    <label for="HT1D">Proses Pinjaman Karyawan</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--transaksi elektronik -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTen">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collap10" aria-expanded="false" aria-controls="collap10">
                    TRANSAKSI ELEKTRONIK
                    </button>
                    </h2>
                    <div id="collap10" class="accordion-collapse collapse" aria-labelledby="headingTen" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HT2" id="HT2" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2');">
                                <label for="HT2">Transaksi Barang Elektronik</label>
                            </li>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT2A" id="HT2A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2A');">
                                    <label for="HT2A">Pinjaman Barang</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2AA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2AA" id="HT2AA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2AA');">
                                            <label for="HT2AA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2AB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2AB" id="HT2AB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2AB');">
                                            <label for="HT2AB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2AC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2AC" id="HT2AC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2AC');">
                                            <label for="HT2AC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2AD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2AD" id="HT2AD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2AD');">
                                            <label for="HT2AD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT2B" id="HT2B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2B');">
                                    <label for="HT2B">Pembayaran Cicilan</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2BA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2BA" id="HT2BA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2BA');">
                                            <label for="HT2BA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2BB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2BB" id="HT2BB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2BB');">
                                            <label for="HT2BB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2BC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2BC" id="HT2BC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2BC');">
                                            <label for="HT2BC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2BD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT2BD" id="HT2BD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2BD');">
                                            <label for="HT2BD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%  
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2C'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT2C" id="HT2C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2C');">
                                    <label for="HT2C">Mutasi Barang</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT2D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT2D" id="HT2D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT2D');">
                                    <label for="HT2D">Proses Barang Karyawan</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                <!--end transaksi -->
                <!-- transaksi bank -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTen">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collap11" aria-expanded="false" aria-controls="collap11">
                    TRANSAKSI BANK
                    </button>
                    </h2>
                    <div id="collap11" class="accordion-collapse collapse" aria-labelledby="headingTen" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HT3" id="HT3" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3');">
                                <label for="HT3">Pinjaman Bank</label>
                            </li>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT3A" id="HT3A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3A');">
                                    <label for="HT3A">Pinjaman</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3AA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3AA" id="HT3AA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3AA');">
                                            <label for="HT3AA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3AB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3AB" id="HT3AB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3AB');">
                                            <label for="HT3AB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3AC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3AC" id="HT3AC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3AC');">
                                            <label for="HT3AC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3AD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3AD" id="HT3AD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3AD');">
                                            <label for="HT3AD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT3B" id="HT3B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3B');">
                                    <label for="HT3B">Pembayaran Cicilan</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3BA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3BA" id="HT3BA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3BA');">
                                            <label for="HT3BA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3BB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3BB" id="HT3BB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3BB');">
                                            <label for="HT3BB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3BC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3BC" id="HT3BC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3BC');">
                                            <label for="HT3BC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3BD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT3BD" id="HT3BD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3BD');">
                                            <label for="HT3BD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%  
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3C'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT3C" id="HT3C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3C');">
                                    <label for="HT3C">Mutasi Bank</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT3D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT3D" id="HT3D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT3D');">
                                    <label for="HT3D">Proses Bank</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                <!-- end transaksi bank -->
                <!-- transaksi pribadi -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTen">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collap12" aria-expanded="false" aria-controls="collap12">
                    TRANSAKSI PRIBADI
                    </button>
                    </h2>
                    <div id="collap12" class="accordion-collapse collapse" aria-labelledby="headingTen" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                        <ul>
                            <li>
                                <%
                                app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4'"
                                set app = app_cmd.execute
                                %>
                                <input class="form-check-input" type="checkbox" name="HT4" id="HT4" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4');">
                                <label for="HT4">Pinjaman Pribadi</label>
                            </li>
                            <ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4A'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT4A" id="HT4A" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4A');">
                                    <label for="HT4A">Pinjaman</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4AA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4AA" id="HT4AA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4AA');">
                                            <label for="HT4AA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4AB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4AB" id="HT4AB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4AB');">
                                            <label for="HT4AB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4AC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4AC" id="HT4AC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4AC');">
                                            <label for="HT4AC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4AD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4AD" id="HT4AD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4AD');">
                                            <label for="HT4AD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT4B" id="HT4B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4B');">
                                    <label for="HT4B">Pembayaran Cicilan</label>
                                </li>
                                    <ul>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4BA'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4BA" id="HT4BA" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4BA');">
                                            <label for="HT4BA">Tambah</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4BB'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4BB" id="HT4BB" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4BB');">
                                            <label for="HT4BB">Edit</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4BC'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4BC" id="HT4BC" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4BC');">
                                            <label for="HT4BC">Aktif Y/N</label>
                                        </li>
                                        <li>
                                            <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4BD'"
                                            set app = app_cmd.execute
                                            %>
                                            <input class="form-check-input" type="checkbox" name="HT4BD" id="HT4BD" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4BD');">
                                            <label for="HT4BD">Cetak</label>
                                        </li>
                                    </ul>
                                <li>
                                    <%  
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4C'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT4C" id="HT4C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4C');">
                                    <label for="HT4C">Mutasi Bank</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HT4D'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HT4D" id="HT4D" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HT4D');">
                                    <label for="HT4D">Proses Bank</label>
                                </li>
                            </ul>
                        </div>
                    </div>
                <!-- end transaksi pribadi -->
                </form>
                    <div class='p' id="thtHint"></div>
                </div>
            </div>
        <div class='backHakakses mt-2'><button type="button" class="btn btn-secondary btn-sm" onclick="window.location.href='index.asp'">KEMBALI</button></div>
    </div>
</div>

<script>
	function updateRights(uname,serverID,appRightsID)
	{
	var xmlhttp;    
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange=function()
        {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
                document.getElementById("txtHint").style.padding = "35px";
            document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET","getajax.asp?uname="+uname+"&serverID="+serverID+"&appRightsID="+appRightsID,true);
        // alert("getajax.asp?uname="+uname+"&serverID="+serverID+"&appRightsID="+appRightsID);
        xmlhttp.send();
	}
</script>
<!-- #include file='../layout/footer.asp' -->