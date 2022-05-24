<!-- #include file='../connection.asp' -->
<%
    p_event = request.form ("event")
    user = request.form ("user")
    file = request.form ("file")

    set event_cmd = Server.CreateObject("ADODB.Command")
    event_cmd.activeConnection = mm_cargo_string

    ' log event
    event_cmd.commandText = "SELECT HRD_T_LOG.logEvent FROM WebLogin LEFT OUTER JOIN HRD_T_LOG ON WebLogin.username = HRD_T_LOG.LogUser LEFT OUTER JOIN WebRights ON WebLogin.username = WebRights.username WHERE WebLogin.user_aktifYN = 'Y' AND WebLogin.serverID = '1' and appIDRights like '%H%' AND (HRD_T_Log.logEvent)IS NOT NULL GROUP BY  HRD_T_Log.logEvent" 

    set logEvent = event_cmd.execute 

    ' log user
    event_cmd.commandText = "SELECT  WebLogin.username FROM WebLogin LEFT OUTER JOIN HRD_T_LOG ON WebLogin.username = HRD_T_LOG.LogUser LEFT OUTER JOIN WebRights ON WebLogin.username = WebRights.username WHERE WebLogin.user_aktifYN = 'Y' AND WebLogin.serverID = '1' and appIDRights like '%H%' GROUP BY  WebLogin.username" 

    set logUser = event_cmd.execute 

    ' log url
    event_cmd.commandText = "SELECT HRD_T_LOG.LogURL FROM WebLogin LEFT OUTER JOIN HRD_T_LOG ON WebLogin.username = HRD_T_LOG.LogUser LEFT OUTER JOIN WebRights ON WebLogin.username = WebRights.username WHERE WebLogin.user_aktifYN = 'Y' AND WebLogin.serverID = '1' and appIDRights like '%H%' AND (HRD_T_Log.LogUrl)IS NOT NULL GROUP BY  HRD_T_Log.LogURL" 

    set logUrl = event_cmd.execute 

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

    root = "SELECT * FROM HRD_T_LOG LEFT OUTER JOIN WebLogin ON HRD_T_LOG.LogUser = WebLogin.username WHERE WebLogin.user_aktifYN =  'Y' "&filterEvent&" "&filterUser&" "&filterFile&""

    log_cmd.commandText = root
    ' response.write Log_cmd.commandText & "<br>"
    set data = log_cmd.execute

    ' paggination
    set conn = Server.CreateObject("ADODB.Connection")
    conn.open MM_Cargo_string

    dim recordsonpage, requestrecords, allrecords, hiddenrecords, showrecords, lastrecord, recordconter, pagelist, pagelistcounter, sqlawal
    dim angka
    ' untuk angka
    angka = request.QueryString("angka")
    if len(angka) = 0 then 
        angka = Request.form("urut") + 1
    end if

    page = Request.QueryString("page")
    
    orderBy = "ORDER BY LogEvent ASC"

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = root

    sql=sqlawal + orderBy

    rs.open sql, conn

    ' records per halaman
    recordsonpage = 10

    ' count all records
    allrecords = 0
    do until rs.EOF
        allrecords = allrecords + 1
        rs.movenext
    loop

    ' if offset is zero then the first page will be loaded
    offset = Request.QueryString("offset")
    if offset = 0 OR offset = "" then
        requestrecords = 0
    else
        requestrecords = requestrecords + offset
    end if

    rs.close

    set rs = server.CreateObject("ADODB.RecordSet")

    sqlawal = root
    sql=sqlawal + orderBy

    rs.open sql, conn

    ' reads first records (offset) without showing them (can't find another solution!)
    hiddenrecords = requestrecords
    do until hiddenrecords = 0 OR rs.EOF
        hiddenrecords = hiddenrecords - 1
        rs.movenext
        if rs.EOF then
        lastrecord = 1
        end if	
    loop
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SYSTEM LOG</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        .coltableLog {
            font-size: 12px;
        }
        .tableLog{
            display:block;
            overflow-x:scroll;
        } 
        .tableLog th{
            color:#fff;
            background-color:gray;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<!-- #include file='../landing.asp' -->
<div class="container">
    <div class="row mb-4">
        <div class="col-12 mt-3 text-center ">
            <H1 id="judul">LOG SYSTEM</H1>
        </div>
    </div>
    <form action="log.asp" method="post" name="event" id="carievent">
        <div class="row rowLog">
            <div class="col-lg-3 mt-2">
                <div class="col-auto">
                    <select class="form-select" aria-label="Default select example" name="event" id="event">
                        <option value="">Pilih EVENT</option>
                        <%
                        do while not LogEvent.eof 
                        %>
                        <option value="<%= LogEvent("LogEvent") %>"><%= LogEvent("LogEvent") %></option>
                        <%
                        LogEvent.movenext
                        loop
                        %>
                    </select>
                </div>
            </div>
            <div class="col-lg-3 mt-2" >
                <div class="col-auto" >
                    <select class="form-select" aria-label="Default select example" name="user" id="user">
                        <option value="">Pilih USER</option>
                        <%
                        do while not logUser.eof 
                        %>
                        <option value="<%= logUser("username") %>"><%= logUser("username") %></option>
                        <%
                        logUser.movenext
                        loop
                        %>
                    </select>
                </div>
            </div>
            <div class="col-lg-3 mt-2">
                <div class="col-auto">
                    <select class="form-select" aria-label="Default select example" name="file" id="file">
                        <option value="">Pilih FILE</option>
                        <%
                            nameURL=" "
                            do while not logUrl.eof 
                            nameURL = (Mid(logUrl("LogURL"),25))
                        %>
                            <option value="<%= logUrl("LogURL") %>"><%= nameURL %></option>
                        <%
                            logUrl.movenext
                            loop
                        %>
                    </select>
                </div>
            </div>
            <div class="col-lg-2 mt-2">
                <div class='col-sm-2'>
                    <button type="submit" class="btn btn-primary" name="submit" id="submit">Cari</button>
                </div>
            </div>
        </div>
    </form>
    <div class="row mt-3 " >
        <div class="col-lg-12 coltableLog">
            <table class="table table-striped table-hover tableLog" >
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
                    <%
                    'prints records in the table
                    showrecords = recordsonpage
                    recordcounter = requestrecords
                    do until showrecords = 0 OR  rs.EOF
                    recordcounter = recordcounter + 1
                    %>
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
                        showrecords = showrecords - 1
                        rs.movenext
                        if rs.EOF then
                        lastrecord = 1
                        end if
                        loop
                        rs.close
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <!--pagination-->
            <nav aria-label="Page navigation example">
				<ul class="pagination" id="pagin">
					<li class="page-item">
                    <% 
						page = Request.QueryString("page")
						if page = "" then
						npage = 1
						else
							npage = page - 1
						end if
						if requestrecords <> 0 then %>
							<a class="page-link" href="log.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=npage%>">&#x25C4; Previous </a>
							<% else %>
							<p class="page-link-p">&#x25C4; Previous </p>
						<% end if %>
                        <li class="page-item d-flex" style="overflow-y:auto;">	
                        <%
								pagelist = 0
								pagelistcounter = 0
								maxpage = 5
								nomor = 0
								do until pagelist > allrecords  
								pagelistcounter = pagelistcounter + 1

									if page = "" then
										page = 1
									else
										page = page
									end if
									
									if Cint(page) = pagelistcounter then
						%>
                        <a class="page-link hal d-flex bg-primary text-light" href="log.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>"><%= pagelistcounter %></a>  
							<% else %>
							<a class="page-link hal d-flex" href="log.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>"><%= pagelistcounter %></a>  
						<%	
                            end if
								pagelist = pagelist + recordsonpage
							loop
						%>
                    </li>
                    <li class="page-item"
                    <% 
						if page = "" then
						   page = 1
						else
						   page = page + 1
						end if
					%>
                    %>
						<% if(recordcounter > 1) and (lastrecord <> 1) then %>
						<a class="page-link next" href="log.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=page%>">Next &#x25BA;</a>
						<% else %>
						<p class="page-link next-p">Next &#x25BA;</p>
						<% end if %>
                </ul>
            </nav>
            <!-- end pagging -->
        </div>
    </div>
</div>

<!-- #include file='../layout/footer.asp' -->