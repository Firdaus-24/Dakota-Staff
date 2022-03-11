
<%
uname = request.QueryString("uname")
rname =Request.QueryString("rname")
cabang = request.QueryString("cabang")
kodeagen = request.QueryString("kodeagen")
%>


<body>
    <div style="position: absolute; left: 50%; top : 30%; bottom:30%;">
        <div style="position: relative; left: -50%; border: 0px; text-align:center;">
        <b><u>KONFIRMASI PENGHAPUSAN USER</b></u><br /><hr />
           Anda akan menghapus user <b> <%=uname %> </b><br /> dengan Nama Lengkap : <b> <%=rname%> </b><br /> Untuk area kerja region kantor <b><%=cabang%></b>  <br />
            <input type="button" value="BATAL" onClick="window.open('user_manager.asp','_Self');" /> | <input type="button" value="HAPUS USER"onClick="window.open('user_manager_RMV.asp?uname=<%=uname%>&rname=<%=rname%>&cabang=<%=cabang%>&kodeagen=<%=kodeagen%>','_Self');" />
        </div>
    </div>
</body>