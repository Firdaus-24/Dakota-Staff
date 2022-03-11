<!-- #include file='../connection.asp' -->
<%
dim p, user_id, user
p = Request.QueryString("p")

set user_id = Server.CreateObject("ADODB.Command")
user_id.activeConnection = MM_Cargo_string

user_id.commandText = "SELECT TOP 10 username, ServerID FROM webLogin WHERE username LIKE '%"& p &"%' ORDER BY username"
' Response.Write user_id.commandText
set user = user_id.execute
 %>
 <!-- #include file='../layout/header.asp' -->
<% if user.eof then %>
<div class='text-center bg-secondary p-2 text-white bg-opacity-25 mt-2'>
    <div class='notiv-header'>
        <label>WARNING !!!</label>
    </div>
    <div class='content-pernama'>
        <p>DATA TIDAK DI TEMUKAN</p>
    </div>
</div>
<% else %>
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
            dim i
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
<% end if %>
<!-- #include file='../layout/footer.asp' -->