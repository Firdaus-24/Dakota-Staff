<!-- #include file="../../connection.asp"-->
<%
    key = Request.QueryString("key")
    n = Request.QueryString("n")

    set karyawan_cmd = Server.CreateObject("ADODB.Command")
    karyawan_cmd.ActiveConnection = MM_cargo_STRING

    karyawan_cmd.commandText = "SELECT TOP 10 Kry_Nip,Kry_Nama FROM HRD_M_Karyawan WHERE (Kry_Nama LIKE '%"& key &"%' OR Kry_Nip = '"& key &"' ) AND kry_nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%' ORDER BY Kry_Nama"

    set karyawan = karyawan_cmd.execute
%>
<table class="table">
    <thead>
        <tr>
            <td>Pilih</td>
            <td>Nip</td>
            <td>Nama</td>
        </tr>
    </thead>
    <tbody>
        <%do while not karyawan.eof%>
        <tr>
            <td class="text-center">
                <button class="btn btn-primary btn-sm" type="button" onclick="getAtasan('<%= karyawan("Kry_Nip") %>','<%= n %>')">Pilih</button>
            </td>
            <td>
                <%= karyawan("Kry_Nip") %>
            </td>
            <td>
                <%= karyawan("Kry_Nama") %>
            </td>
        </tr>
        <%karyawan.movenext 
        loop%>
    </tbody>
</table>