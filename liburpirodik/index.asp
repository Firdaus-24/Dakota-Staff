<!-- #include file='../connection.asp' -->
<%
    if session("HL8") = false then
        Response.Redirect("../dashboard.asp")
    end if

    set libur_cmd = Server.CreateObject("ADODB.Command")
    libur_cmd.activeConnection = mm_cargo_string

    libur_cmd.commandText = "SELECT * FROM HRD_M_CalLiburPeriodik"
    set libur = libur_cmd.execute

    set conn = Server.CreateObject("ADODB.Connection")
    conn.Open mm_cargo_string

    ' untuk angka
    angka = request.QueryString("angka")
    if len(angka) = 0 then 
        angka = Request.form("urut") + 1
    end if

    ' untuk data
    id = Request.QueryString("id")
    if len(id) = 0 then
        id = Request.form("id")
    end if

    tgl = Request.QueryString("tgl")
    if len(tgl) = 0 then 
        tgl = Request.form("tgl")
    end if

    keterangan = Request.QueryString("keterangan")
    if len(keterangan) = 0 then    
        keterangan = Request.form("keterangan")
    end if

    aktif = Request.QueryString("aktif")
    if len(aktif) = 0 then
        aktif = Request.form("aktif")
    end if

    page = Request.QueryString("page")

    orderBy = " order by LP_Tgl DESC"

    set rs = Server.CreateObject("ADODB.Recordset")

    sqlawal = "SELECT * FROM HRD_M_CalLiburPeriodik"

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

    sqlawal = "SELECT * from HRD_M_CalLiburPeriodik"
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
    <title>LIBUR PRIODIK</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="style.css">
</head>
<body>
<!-- #include file='../landing.asp' -->
    <div class="container">
        <div class="row mt-3">
            <div class="col-sm-12 text-center">
                <h3>LIBUR PRIODIK</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3 mb-3">
                <% if session("HL8A") = true then%>
                    <button type="button" class="btn btn-primary" onclick="window.location.href='tambah.asp'"><i class="fa fa-plus" aria-hidden="true"></i> Tambah</button>
                <% end if %>
            </div>
        </div>
        <div class="row ">
            <div class="col-sm-12 tableLiburPriodik" style=" overflow-y: auto;">
                <table class="table table-hover" >
                    <thead class="bg-secondary text-light" >
                        <tr>
                            <td>ID</td>
                            <td>Tanggal</td>
                            <td>Keterangan</td>
                            <%if session("HL8B") =  true then%>
                            <td class="text-center">Aksi</td>
                            <%end if%>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        showrecords = recordsonpage
                        recordcounter = requestrecords
                        do until showrecords = 0 OR  rs.EOF
                        recordcounter = recordcounter + 1
                        %>
                        <tr>
                            <td><%= rs("LP_ID") %></td>
                            <td><%= rs("LP_tgl") %></td>
                            <td><%= rs("LP_keterangan") %></td>
                            <% if session("HL8B") = true then%>
                                <td class="text-center">
                                    <div class="btn-group" role="group" aria-label="Basic example">
                                        <%if rs("LP_LiburYN") = "N" then%>
                                            <button type="button" class="btn btn-sm btn-outline-warning" onclick="return window.location.href='aktif.asp?id=<%= rs("LP_ID")%>&data=<%= rs("LP_LiburYN") %>'">Aktif</button>
                                        <%else%>
                                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="return window.location.href='aktif.asp?id=<%= rs("LP_ID")%>&data=<%= rs("LP_LiburYN") %>'">Off</button>
                                        <%end if %>
                                    </div>
                                </td>
                            <%end if %>
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
            <div class="col-sm-12">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                        <% 
                        if page = "" then
                            npage = 1
                        else
                            npage = page - 1
                        end if

                        if requestrecords <> 0 then %>
                            <a class="page-link prev" href="index.asp?offset=<%= requestrecords - recordsonpage%>&page=<%=npage%>&id=<%=id%>&tgl=<%=tgl%>&keterangan=<%=keterangan%>&aktif=<%=aktif%>">&#x25C4; Prev </a>
                        <% else %>
                            <p class="page-link prev-p">&#x25C4; Prev </p>
                        <% end if %>
                        </li>
                        <li class="page-item d-flex" style="overflow-y:auto;">	
                        <%
                        pagelist = 0
                        pagelistcounter = 0
                        do until pagelist > allrecords  
                        pagelistcounter = pagelistcounter + 1

                            if page = "" then
                                page = 1
                            else
                                page = page
                            end if

                            if Cint(page) = pagelistcounter then
                        %>
                            <a class="page-link hal bg-primary text-light" href="index.asp?offset=<% = pagelist %>&page=<%=pagelistcounter%>&id=<%=id%>&tgl=<%=tgl%>&keterangan=<%=keterangan%>&aktif=<%=aktif%>"><%= pagelistcounter %></a> 
                        <%else%>
                            <a class="page-link hal" href="index.asp?offset=<% = pagelist %>&page=<%=pagelistcounter%>&id=<%=id%>&tgl=<%=tgl%>&keterangan=<%=keterangan%>&aktif=<%=aktif%>"><%= pagelistcounter %></a> 
                        <%
                            end if
                        pagelist = pagelist + recordsonpage
                        loop
                        %>
                        </li>
                        <li class="page-item">
                        <% 
                            if page = "" then
                                page = 1
                            else
                                page = page + 1
                            end if
                        %>
                        <% if(recordcounter > 1) and (lastrecord <> 1) then %>
                        <a class="page-link next" href="index.asp?offset=<%= requestrecords + recordsonpage %>&page=<%=page%>&id=<%=id%>&tgl=<%=tgl%>&keterangan=<%=keterangan%>&aktif=<%=aktif%>">Next &#x25BA;</a>
                        <% else %>
                        <p class="page-link next-p">Next &#x25BA;</p>
                        <% end if %>
                        </li>	
                    </ul>
                </nav> 
            </div>
        </div>
    </div>

<!-- #include file='../layout/footer.asp' -->