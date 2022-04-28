<!-- #include file='../connection.asp' -->
<% 
    if session("username") <> "dausit" AND session("username") <> "administrator" then
        Response.Redirect("../login.asp")
    end if

    dim agen_cmd, agen
    dim user_id, user, serverid

    set agen_cmd = Server.CreateObject("ADODB.Command")
    agen_cmd.activeConnection = MM_Cargo_string

    agen_cmd.commandText = "SELECT agen_id, agen_nama FROM GLB_M_Agen WHERE agen_aktifYN = 'Y' order by agen_nama ASC"
    set agen = agen_cmd.execute

    set user_id = Server.CreateObject("ADODB.Command")
    user_id.activeConnection = MM_Cargo_string

    user_id.commandText = "SELECT username, ServerID FROM webLogin"
    set user = user_id.execute

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akses Login</title>
     <!-- #include file='../layout/header.asp' -->
    <style>
        .btn{
            border:1px solid black;
        }
        .my-custom-scrollbar {
            position: relative;
        height: 500px;
        overflow: auto;
        font-size:14px;
        }
        .table-wrapper-scroll-y {
            display: block;
        }
        input[type=text]:focus {
            border-color: rgba(82, 168, 236, 0.8);
            outline: 0;
            outline: thin dotted \9;
            /* IE6-9 */

            -webkit-box-shadow: none; 
            -moz-box-shadow: none; 
            box-shadow: none; 
        }
    </style>
</head>

<body>
<div class='container'>
    <div class='row mt-3'>
        <div class='col-sm text-center'>
            <h3>HAK AKSES USER</h3>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <h3>DAFTAR USER BARU</h3>
            <form action="usernamenew_add.asp" method="post">
                <div class='input-group input-group-sm mb-3'>
                    <span class="input-group-text" id="inputGroup-sizing-sm"><i class="fa fa-user-o" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="username" id="username" placeholder="Username" required>
                </div>
            <div class='input-group input-group-sm mb-3'>
                    <span class="input-group-text" id="inputGroup-sizing-sm"><i class="fa fa-unlock" aria-hidden="true"></i></span>
                    <input type="password" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="password" id="password" placeholder="Password" required>
            </div>
                <div class='input-group input-group-sm mb-3'>
                    <span class="input-group-text" id="inputGroup-sizing-sm"><i class="fa fa-puzzle-piece" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="aktifyn" id="aktifyn" placeholder="aktifyn" required>
                </div>
                <div class='input-group input-group-sm mb-3'>
                    <span class="input-group-text" id="inputGroup-sizing-sm"><i class="fa fa-id-card" aria-hidden="true"></i></span>
                    <select class="form-select form-select-sm" aria-label=".form-select-sm example" name="serverid" id="serverid">
                        <option selected>Pilih</option>
                        <% 
                        do until agen.eof
                        %>
                        <option value="<%=agen("agen_id")%>"><%=agen("agen_nama")%></option>
                        <% 
                        agen.movenext
                        loop
                        %>
                    </select>
                </div>
                <div class='input-group input-group-sm mb-3'>
                    <span class="input-group-text" id="inputGroup-sizing-sm"><i class="fa fa-tags" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" name="realname" id="realname" placeholder="Surename" required>
                </div>
                
                <input class="btn btn-primary" type="submit" name="submit" id="submit" value="Submit">
            </form>
        </div>
        <div class='col'>
            <h3 class="text-center">DAFTAR USER</h3>
            <div class='row mb-2 p-0 text-center' style="border:1px solid #000;border-radius:50px;">
                <div class='col-5'>
                    <input class="form-control form-control-sm mb-2" type='text' name='cariuser' id='cariuser' placeholder="cari berdasarkan username" style="border:none;background-color:none;margin-top:7px;margin-left:10px;" autocomplete="off">
                </div>
                <div class='col-3 loaderHakAkses'>
                    <img src="../loader/newloader.gif" style="width: 70%;margin-top:15px;margin-left:-50px;display:none;" id="loaderHakAkses">
                </div>
            </div>
            <div class="table-wrapper-scroll-y my-custom-scrollbar">
                <table class="table table-bordered table-striped mb-0 tableHakakses">
                    <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Username</th>
                        <th scope="col">ServerID</th>
                        <th scope="col">Update</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% 
                    i = 0
                    do until user.eof 
                    i = i + 1
                    %>
                    <tr>
                        <th scope="row"><%= i %></th>
                        <td><%=user("username")%></td>
                        <td><%=user("ServerID")%></td>
                        <td><a href="<%=url%>/hakakses/checkakses.asp?username=<%=user("username")%>&serverid=<%=user("serverID")%>"><span class="badge rounded-pill bg-primary">Update</span></td>
                    </tr>
                    <% 
                    user.movenext
                    loop
                     %>
                    </tbody>
                </table>

            </div>
        </div>
        </div>
    </div>
</div>

</body>
<!-- #include file='../layout/footer.asp' -->