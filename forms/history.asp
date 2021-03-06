<!-- #include file='../connection.asp' -->
<% 
tgla = Request.Form("tgla")
tgle = Request.Form("tgle")
tahun = Request.Form("tahun")

set history_cmd = Server.CreateObject("ADODB.Command")
history_cmd.activeConnection = mm_cargo_string

if tgla <> "" And tgle <> "" then
    history_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_karyawan.Kry_Nama, HRD_M_karyawan.Kry_tglMasuk FROM HRD_T_Mutasi LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_T_Mutasi.Mut_Tanggal BETWEEN '"& Cdate(tgla) &"' AND '"& cdate(tgle) &"' ORDER BY HRD_T_Mutasi.Mut_tanggal DESC"
    ' Response.Write history_cmd.commandText & "<br>"
    set data = history_cmd.execute
else 
    history_cmd.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_karyawan.Kry_Nama, HRD_M_karyawan.Kry_tglMasuk FROM HRD_T_Mutasi LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE year(HRD_T_Mutasi.Mut_Tanggal) = '"& tahun &"' ORDER BY HRD_T_Mutasi.Mut_tanggal DESC"
    set data = history_cmd.execute
end if
 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>History</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        .content{
            display:block;
            overflow:auto;
        }
        .table{
            font-size:12px;
        }
        .table thead{
            background-color:gray;
            color:#fff;
        }
        th{
            text-align:center;
        }
        tr:first-child{
            width: 1%;
            white-space: nowrap;
        }
        tr:last-child{
            text-align:left;
        }
        @media screen and (max-width:540px)
		{
            .ExportHistory button{
                font-size:12px;
            }
            .table{
                font-size:10px;
            }
        }
    </style>
</head>

<body>
<div class='container'>
    <div class='row mt-3'>
        <div class='col-12 text-center'>
            <h3>DAFTAR PERUBAHAN KARYAWAN</h3>
            <% if tgla <> "" then %>
                <label><b>PROIODE <%= Cdate(tgla) &"-"& Cdate(tgle) %></b></label>
            <% end if %>
            <% if tahun <> "" then %>
                <label><b>PROIODE TAHUN<%= tahun %></b></label>
            <% end if %>
        </div>
    </div>
</div>
<div class="btn-group mb-2 ExportHistory" role="group" aria-label="Basic outlined example">
  <button type="button" class="btn btn-outline-primary" onclick="window.location.href='index.asp'">Kembali</button>
  <button type="button" class="btn btn-outline-primary" onclick="window.location.href='exporXls-mutasi.asp?tgla=<%=tgla%>&tgle=<%=tgle%>&tahun=<%=tahun%>'">Export</button>
</div>
<div class="row">
    <div class="col-sm-12 content">
        <table class="table table-bordered" id="table">
            <thead>
                <tr style="text-align: center; vertical-align: middle;">
                    <th rowspan="2">No</th>
                    <th rowspan="2">Tanggal</th>
                    <th rowspan="2">No SK</th>
                    <th rowspan="2">Tgl Masuk</th>
                    <th rowspan="2">Nip</th>
                    <th rowspan="2">Nama</th>
                    <th rowspan="2">Jenis Perubahan</th>
                    <th colspan="3" class="text-center">Awal</th>
                    <th colspan="3" class="text-center">Akhir</th>
                    <% 
                    if session("HL5C") = true then
                        if session("HL5B") = true then %>
                    <th rowspan="2"></th>
                    <% 
                        end if
                    end if %>
                </tr>
                <tr style="border-style: none;">
                    <th >Jabatan</th>
                    <th >Divisi</th>
                    <th >Cabang</th>
                    <th >Jabatan</th>
                    <th >Divisi</th>
                    <th >Cabang</th>
                </tr>
            </thead>
            <tbody>
            <% 
            if not data.eof then
                    ' set nomor
            no = 0 
                do while not data.eof 
                no = no + 1
            %>
                <tr>
                    <th><%= no %></th>
                    <td><%= data("Mut_Tanggal") %></td>
                    <td><%= data("Mut_nosurat") %></td>
                    <td><%= data("Kry_TglMasuk") %></td>
                    <td><%= data("Mut_Nip") %></td>
                    <td><%= data("Kry_nama") %></td>
                    <!--cek status -->
                    <% if data("Mut_status") = "" OR data("Mut_status") = "0" then %>
                        <td>Mutasi</td>
                    <% elseIf data("Mut_status") = "1" then %>
                        <td>Demosi</td>
                    <% elseIf data("Mut_status") = "2" then %>
                        <td>Rotasi</td>
                    <% elseIf data("Mut_status") = "3" then %>
                        <td>Promorsi</td>
                    <% elseIf data("Mut_status") = "4" then %>
                        <td>Pensiun</td>
                    <% elseIf data("Mut_status") = "5" then %>
                        <td>Keluar Tanpa Kabar</td>
                    <% else %>
                        <td>Tanpa Keterangan</td>
                    <% end if %>

                    <!-- cek jabatan, divisi dan agen -->
                    <% 
                    ' divisilama
                    history_cmd.commandText = "SELECT (Div_nama) AS divlama FROM HRD_M_divisi WHERE Div_Code = '"& data("Mut_AsalDDBID") &"'"
                    set divlama = history_cmd.execute
                            
                    if divlama.eof then 
                        div1 = ""
                    else
                        div1 = divlama("divlama")
                    end if
                    ' divisibaru
                    history_cmd.commandText = "SELECT (Div_nama) AS divbar FROM HRD_M_divisi WHERE Div_Code = '"& data("Mut_TujDDBID") &"'"
                    set divbaru = history_cmd.execute

                    if divbaru.eof then
                        div2 = ""
                    else
                        div2 = divbaru("divbar")
                    end if
                    ' jabatan lama
                    history_cmd.commandText = "SELECT (Jab_nama) AS jablama FROM HRD_M_Jabatan WHERE Jab_code = '"& data("Mut_AsalJabCode") &"'"
                    set jablama = history_cmd.execute

                    if jablama.eof then
                        jab1 = "" 
                    else
                        jab1 = jablama("jablama")
                    end if
                    ' jabatan baru
                    history_cmd.commandText = "SELECT (Jab_nama) AS jabbaru FROM HRD_M_Jabatan WHERE Jab_code = '"& data("Mut_TujJabCode") &"'"
                    set jabbaru = history_cmd.execute

                    if jabbaru.eof then 
                        jab2 = ""
                    else
                        jab2 = jabbaru("jabbaru")
                    end if
                    ' agen lama
                    history_cmd.commandText = "SELECT (Agen_nama) AS agenlama FROM GLB_M_Agen WHERE Agen_Id = "& data("Mut_AsalAgenID") &""
                    set agenlama = history_cmd.execute
                            
                    if agenlama.eof then
                        agen1 = ""
                    else
                        agen1 = agenlama("agenlama")
                    end if
                    ' agen baru
                    history_cmd.commandText = "SELECT (Agen_nama) AS agenbaru FROM GLB_M_Agen WHERE Agen_Id = "& data("Mut_TujAgenID") &""
                    set agenbaru = history_cmd.execute

                    if agenbaru.eof then
                        agen2 = ""
                    else    
                        agen2 = agenbaru("agenbaru")
                    end if
                    %>
                    <td><%= jab1 %></td>
                    <td><%= div1 %></td>
                    <td><%= agen1 %></td>
                    <td><%= jab2 %></td>
                    <td><%= div2 %></td>
                    <td><%= agen2 %></td>
                    <% 
                    if session("HL5C") = true then
                        if session("HL5B") = true then %>
                    <th><a href="view_update.asp?id=<%= data("mut_id") %>"><span class="badge rounded-pill bg-info text-dark">Update</span></a></th>
                    <% 
                        end if
                    end if %>
                </tr>
            <% 
                data.movenext
                loop
            end if
            %>
            </tbody>
        </table>
    </div>
</div>
<!-- #include file='../layout/footer.asp' -->
