<!-- #include file='../connection.asp' -->
<%

p_event = request.form ("event")
user = request.form ("user")
file = request.form ("file")

set event_cmd = Server.CreateObject("ADODB.Command")
event_cmd.activeConnection = mm_cargo_string

event_cmd.commandText = "SELECT LogEvent, LogUser, username, LogURL FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN = 'Y' GROUP BY LogEvent, LogUser, username, LogURL ORDER BY LogEvent ASC" 
set LogEvent = event_cmd.execute 

set log_cmd = Server.CreateObject("ADODB.Command")
log_cmd.activeConnection = mm_cargo_string


if p_event <> "" then 
    filterEvent = " AND LogEvent='"& p_event &"' "
else 
    filterEvent = ""
end if
if user <> "" then 
    filterUser = " AND LogUser='"& user &"' "
else 
    filterUser = ""
end if
if file <> "" then 
    filterFile = " AND LogURL='"& file &"' "
else 
    filterFile = ""
end if



if      p_event <> "" And user = "" And file = "" then 
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y' "&filterEvent&""
elseIf  p_event = "" And user <> "" And file = "" then
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y'  "&filterUser&""
elseIf  p_event = "" And user = "" And file <> "" then
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y'  "&filterFile&""
elseIf  p_event <> "" And user <> "" And file = "" then
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y'  "&filterEvent&" "&filterUser&""
elseIf  p_event <> "" And user = "" And file <> "" then
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y'  "&filterEvent&" "&filterFile&""
elseIf  p_event = "" And user <> "" And file <> "" then
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y'  "&filterUser&" "&filterFile&""
else	    
	    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y' "
end If

log_cmd.commandText = root  
' response.write Log_cmd.commandText & "<br>"

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
    <!--<script>
            function rubahnama () {
                document.getElementById("qwer").innerHTML = "Hello World!";
            }
    </script>-->

    <style>
            #judul {
                text-align: center;
                color: red;
                font-family: verdana;
                font-size: 40px;
            }
            
            @media screen and (min-width:540px)
            {
            /* .colcarievent {
                display:block;
                font-size : 12px;
            }
            .colcariuser {
                display:block;
                font-size : 12px;
            }
            .colcarifile {
                display:block;
                font-size : 12px;
            } */
            
            .colbtncari{
                display:block;
                font-size : 12px;
            }
            .colcaiLog {
                display:block;
                font-size : 12px;
            }
            .coltableLog{
                display:block;
                 overflow-x: scroll;
            }
            .tableLog {
                display:block;
                font-size : 12px;
                
            }
            }
            
            /* .header{ */
                /* background-color :
            } */
    </style>
</head>
<body>
<br>   
<div class="container">
    <div class="row mb-4 ">
        <div class="col-12 text-center ">
            <H1 id="judul">SISTEM LOG</H1>
        </div>

    </div>
    <form action="log.asp" method="post" name="event" id="carievent">
    <div class="row ">
        <div class="col-3 colcarievent">
                <div class="col-auto">
                    <select class="form-select" aria-label="Default select example" name="event" id="event">
                        <option value="">Pilih EVENT</option>
                        <%
                            do while not logEvent.eof 
                        %>
                        <option value="<%= logEvent("LogEvent") %>"><%= logEvent("LogEvent") %></option>
                        <%
                        logEvent.movenext
                        loop
                        logEvent.movefirst
                        %>

                    </select>
                </div>
        </div>
        <div class="col-3 colcariuser" >
               <div class="col-auto" >
                    <select class="form-select" aria-label="Default select example" name="user" id="user">
                        <option value="">Pilih USER</option>
                        <%
                            do while not logEvent.eof 
                        %>
                        <option value="<%= logEvent("Username") %>"><%= logEvent("Username") %></option>
                        <%
                        logEvent.movenext
                        loop
                        %>

                    </select>
                </div>

        </div>
        <div class="col-3 colcarifile">
               <div class="col-auto">
                    <select class="form-select" aria-label="Default select example" name="file" id="file">
                        <option value="">Pilih FILE</option>
                        <%
                            logEvent.movefirst
                            nameURL=" "
                            do while not logEvent.eof 
                            nameURL = (Mid(logEvent("LogURL"),25))
                        %>
                            <option value="<%= logEvent("LogURL") %>"><%= nameURL %></option>
                        <%
                            logEvent.movenext
                            loop
                        %>

                    </select>
                </div>
                
        </div>
        
        <div class="col-2 colbtncari">
            <div class='col-sm-2'>
				<button type="submit" class="btn btn-success" name="submit" id="submit">Cari</button>
			</div>
        </div>
    </div>
    </form>
    <!--<div id="qwer">
    </div>
    <div class = "row mt-3">
        <div class = "col">
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">Email address</label>
                <input type="text" class="form-control" id="nama"  name="nama"  >
                <button type="button" class="btn btn-success" name="tombol" id="tombol" onclick="return rubahnama()">Cari</button>
            </div>
        </div>
    </div>-->
    <div class="row mt-3 " >
        <div class="col-lg-12 coltableLog">
            <table class="table table-striped table-hover tableLog " >
                <thead>
                    <tr >
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