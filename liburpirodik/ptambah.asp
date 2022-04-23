<!-- #include file='../connection.asp' -->
<%
     if session("HL8A") = false then
        Response.Redirect("index.asp")
    end if

    tgl = trim(Request.Form("tgl"))

    set liburadd_cmd = Server.CreateObject("ADODB.Command")
    liburadd_cmd.activeConnection = MM_cargo_string

    set libur_cmd = Server.CreateObject("ADODB.Command")
    libur_cmd.activeConnection = MM_cargo_string

    datatgl = split(tgl,",")

    key = ""
    for each data in datatgl 
        libur_cmd.commandText = "SELECT * FROM HRD_M_CalLiburPeriodik  WHERE LP_Tgl = '"& data &"' AND LP_LiburYN = 'Y'"
        set libur = libur_cmd.execute

        if libur.eof then
            key = "001" & right(data,3)
            liburadd_cmd.commandText = "exec sp_ADDHRD_M_CalLiburPeriodik '"& key &"', '"& data &"', ''"
            liburadd_cmd.execute
        end if
    next

    liburadd_cmd.commandText = "SELECT * FROM HRD_M_CalLiburPeriodik WHERE LP_Keterangan  = '' ORDER BY LP_Tgl ASC"
    set plibur = liburadd_cmd.execute
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>UPDATE KETERANGAN</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="style.css">
    <script>
        let keterangan = "";
        function func_ket(e){
            this.keterangan = e;
        }
    </script>
</head>
<body>
<%  if plibur.eof then 
        Response.Redirect("index.asp")
    else
%>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center mt-3 mb-3 labelPTambah">
                <h3>DAFTAR LIBUR TANPA KETERANGAN</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 tablePTambah">
                <table class="table table-hover">
                    <thead class="bg-secondary text-light text-center">
                        <tr>
                            <td>
                                ID
                            </td>
                            <td>
                                TANGGAL
                            </td>
                            <td>
                                KETERANGAN
                            </td>
                            <td>
                                AKSI
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <%do while not plibur.eof%>
                            <tr>
                                <td>
                                    <input class="form-control form-control-sm" type="hidden" aria-label=".form-control-sm example" name="id" id="id" autocomplete="off" value="<%= plibur("LP_ID") %>">
                                    <%= plibur("LP_ID") %>
                                </td>
                                <td>
                                    <input class="form-control form-control-sm" type="hidden" aria-label=".form-control-sm example" name="tgl" id="tgl" autocomplete="off" value="<%= plibur("LP_Tgl") %>">
                                    <%= plibur("LP_Tgl") %>
                                </td>
                                <td>
                                    <input class="form-control form-control-sm" type="text" aria-label=".form-control-sm example" name="keterangan" id="keterangan" onkeyup="return func_ket(this.value)" autocomplete="off" required>
                                </td>
                                <td class="text-center">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="return sendData('<%=plibur("LP_ID")%>')">CEK-IN</button>
                                </td>
                            </tr>
                        <%
                        plibur.movenext
                        loop
                        %>
                    </tbody>
                </table>
            </div>
        </div>  
    </div>
<%end if%>
<script>

function sendData(id){
    let ket = this.keterangan;
    $.post('updateKet.asp', {id:id, ket:ket}, function(response){ 
        location.reload();
    });
}
</script>

<!-- #include file='../layout/footer.asp' -->