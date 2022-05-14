<!-- #include file='../connection.asp' -->
<%
set log_cmd = Server.CreateObject("ADODB.Command")
log_cmd.activeConnection = mm_cargo_string

log_cmd.commandText = "SELECT * FROM HRD_T_Log ORDER BY LogDateTime ASC"
set data = log_cmd.execute

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SYSTEM LOG</title>
    <!-- #include file='../layout/header.asp' -->
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-12">
            <H3>SISTEM LOG</H3>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <table class="table" style="font-size:14px;">
                <thead>
                    <tr>
                        <th>EVENT</th>
                        <th>KETERANGAN</th>
                        <th>URL</th>
                        <th>KEY</th>
                        <th>USER UPDATE</th>
                        <th>CABANG LOGIN</th>
                        <th>TANGGAL UPDATE</th>
                        <th>IP</th>
                        <th>BROWSER</th>
                    </tr>
                </thead>
                <tbody>
                    <%do while not data.eof%>
                    <tr>
                        <td><%= data("LogEvent") %></td>
                        <td><%= data("LogKeterangan") %></td>
                        <td><%= data("LogURL") %></td>
                        <td><%= data("LogKey") %></td>
                        <td><%= data("LogUser") %></td>
                        <td><%= data("LogAgenID") %></td>
                        <td><%= data("LogDateTime") %></td>
                        <td><%= data("LogIP") %></td>
                        <td><%= data("LogBrowser") %></td>
                    </tr>
                    <%
                    data.movenext
                    loop
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- #include file='../layout/footer.asp' -->