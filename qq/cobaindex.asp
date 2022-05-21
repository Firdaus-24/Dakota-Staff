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
            .formevent {
                display : Block;
				margin-top:5px;
				font-size:12px;
                }
            .formuser  {
                display : Block;
				margin-top:5px;
				font-size:12px;
                }
            .formfile  {
                display : Block;
				margin-top:5px;
				font-size:12px;
                }
        
            #submit{
                display : Block;
				max-width:100px;
				font-size:15px;
            }
            .coltableLog{
                display:block;
                overflow-x: scroll;
            }
            .tableLog {
                display:block;
                font-size : 12px;
                
            }
            .pagination {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            }

            #pagin{
                text.align : center;
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
    <div class="row mb-4 header">
        <div class="col-12 text-center ">
            <h1 id="judul">SISTEM LOG</h1>
        </div>

    </div>
    <form action="cobaindex.asp" method="post" name="event" id="carievent">
    <div class="row ">
        <div class="col-3 formevent">
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
        <div class="col-3 formuser " >
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
        <div class="col-3 formfile">
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
        
        <div class="col-2 ">
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
                    <%
                    'prints records in the table
                    showrecords = recordsonpage
                    recordcounter = requestrecords
                    do until showrecords = 0 OR  rs.EOF
                    recordcounter = recordcounter + 1
                    %>
                    <tr>
                        <td><%= rs("LogEvent") %></td>
                        <td><%= rs("LogKeterangan") %></td>
                        <td><%= rs("LogURL") %></td>
                        <td><%= rs("LogKey") %></td>
                        <td><%= rs("LogUser") %></td>
                        <td><%= rs("LogAgenID") %></td>
                        <td><%= rs("LogDateTime") %></td>
                        <td><%= rs("LogIP") %></td>
                        <td><%= rs("LogBrowser") %></td>
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
							<a class="page-link" href="cobaindex.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=npage%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">&#x25C4; Previous </a>
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
                        <a class="page-link hal d-flex bg-primary text-light" href="cobaindex.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a>  
							<% else %>
							<a class="page-link hal d-flex" href="cobaindex.asp?offset=<%= pagelist %>&page=<%=pagelistcounter%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>"><%= pagelistcounter %></a>  
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
						<a class="page-link next" href="cobaindex.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=page%>&p=<%=p%>&q=<%= q %>&r=<%= r %>&s=<%= s %>&t=<%= t %>&u=<%= u %>&a=<%= a %>&b=<%= b %>&c=<%= c %>&d=<%= d %>&e=<%= e %>">Next &#x25BA;</a>
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