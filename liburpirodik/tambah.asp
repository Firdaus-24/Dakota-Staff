<!-- #include file='../connection.asp' -->
<!-- #include file='../func_getLastDay.asp' -->
<%
    if session("HL8A") = false then
        Response.Redirect("index.asp")
    end if

    tahun = trim(Request.Form("tahun"))
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FORM LIBUR</title>
    <!-- #include file='../layout/header.asp' -->
    <link rel="stylesheet" href="style.css">

</head>
<body>
<!-- #include file='../landing.asp' -->
<div class="container">
    <div class="row mt-3">
        <div class="col-sm-12 text-center">
            <h3>FORM SETTING LIBUR PRIODIK</h3>
        </div>
    </div>
    <%if tahun = "" then%>
        <div class="row">
            <div class="col-lg-12 selectTahun">
                <form method="post" action="tambah.asp" id="formThn" class="mt-2">
                    <div class="mb-3 text-center">
                        <label for="tahun" class="form-label">PILIH TAHUN</label>
                        <input type="number" class="form-control" id="tahun" name="tahun" autocomplete="off" maxlength="4" required>
                    </div>
                    <div class="text-center">
                        <div class="btn-group" role="group" aria-label="Basic example">
                        <button class="btn btn-secondary btn-sm" type="button" onclick="window.location.href='index.asp'">KEMBALI</button>
                        <button class="btn btn-secondary btn-sm" type="submit">CARI</button>
                    </div>  
                    </div>
                </form>
            </div>
        </div>
    <%else%>
    <form action="ptambah.asp" method="post">
        <div class="row">
            <div class="col-lg-12 d-flex justify-content-end btnCallender">
                <button class="btn btn-outline-secondary" type="button" onclick="window.location.href='tambah.asp'">REFRESH</button>
                <button class="btn btn-outline-secondary" type="submit">SAVE</button>
            </div>
        </div>
        <div class="row mt-3 callender">
            <%
                for i = 1 to 12

                dateNow = tahun&"-"&i&"-01"
                monthserial = month(tahun&"-"&i&"-01")
            %>
                <!--ceh bulan -->
                    <div class="col-lg-12 text-center bg-secondary text-light mt-2 mb-2">
                        <label><%= MonthName(monthserial,true) %></label> 
                    </div>
                    <!--ceh hari  -->
                            <div class="nameDays">
                    <%
                        a=Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
                        for each x in a
                    %>
                                <span><%= x %></span>
                        <%next%>
                            </div>
                    <div class="detailTgl">
                        <% 
                        lastday = GetlastDay(dateNow)
                        for j = 1 to lastday 
                        %>      
                            <% if j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Sunday"then%>    
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <% elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Monday"then%>
                                <div class="numbDate">                                    
                                    <input type="checkbox" class="form-check-input" name="non" id="non" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">                                    
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Tuesday" then%>
                                <div class="numbDate">                                    
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">                                    
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">                                    
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Wednesday" then%>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Thursday" then%>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Friday" then%>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;"> 
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%elseif j = 1 AND weekdayname(weekday(monthserial&"-"&j&"-"&tahun)) = "Saturday" then%>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="" onclick="return false;">
                                    <span></span>
                                </div>
                                <div class="numbDate">
                                    <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%else%>
                                <div class="numbDate">
                                <input type="checkbox" class="form-check-input" name="tgl" id="tgl" value="<%= Cdate(monthserial&"-"&j&"-"&tahun) %>">
                                    <span><%= j %></span>
                                </div>
                            <%end if%>
                        <%next%>
                    </div>
            <%next%>
        </div>
        </form>
    <%end if%>
</div>
<!-- #include file='../layout/footer.asp' -->