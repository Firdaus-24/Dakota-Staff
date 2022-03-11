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

     '   session(app("appIDRights"))=true

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
                <h3>Daftar Akses</h3>
            </div> 
            <form action="checkakses_add.asp" method="post">
                <input type='hidden' name='uname' id='uname' value="<%=pusername%>">
                <input type='hidden' name='serverID' id='serverID' value="<%=pserverid%>">
            <div class="accordion" id="accordionExample">
                <!--master karyawan -->
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        KARYAWAN
                    </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
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
                                    <label for="HA1A">Tambah</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1B'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA1B" id="HA1B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1B');" >
                                    <label for="HA1B">Edit</label>
                                </li>
                                <li>
                                    <%
                                    app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA1C'"
                                    set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA1C" id="HA1C" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA1C');" >
                                    <label for="HA1C">Cetak</label>
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
                <!--end master karyawan -->
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
                                        <label for="HL6">Udate Data Login</label>
                                    </li>
                                    <li>
                                        <%
                                            app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HL7'"
                                            set app = app_cmd.execute
                                        %>
                                        <input class="form-check-input" type="checkbox" name="HL7" id="HL7" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HL7');" >
                                        <label for="HL7">Gaji ALL</label>
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
                                    <label for="HA2A">Tambah</label>
                                </li>
                                <li>
                                    <%
                                        app_cmd.commandText = "SELECT appIDRights FROM WebRights WHERE (Username = '"& pusername &"') AND (ServerID = '"& pserverid &"') and appIDRights = 'HA2B'"
                                        set app = app_cmd.execute
                                    %>
                                    <input class="form-check-input" type="checkbox" name="HA2B" id="HA2B" <% if app.eof = false then %>checked <% end if %> onClick="updateRights(document.getElementById('uname').value,document.getElementById('serverID').value,'HA2B');" >
                                    <label for="HA2B">Ubah Status</label>
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
                                <label for="HA4C">Aktif YN</label>
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
                                <label for="HA5B">Aktif YN</label>
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
                                <label for="HA6B">Aktif YN</label>
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
                                    <label for="HA7B">AktifYN</label>
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