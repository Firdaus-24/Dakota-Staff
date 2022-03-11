<!-- #include file="../connection.asp"-->

<% 
dim nip, x

nip = Request.QueryString("nip")

Set pendidikan_cmd = Server.CreateObject ("ADODB.Command")
pendidikan_cmd.ActiveConnection = MM_cargo_STRING

pendidikan_cmd.commandText = "SELECT * FROM HRD_M_JenjangDidik"
set pendidikan = pendidikan_cmd.execute

x = 0
 
 %> 

    <title>pendidikan</title>
</head>
<body>
<div clas="container">
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Hubungan</th>
                        <th scope="col">Tempat Lahir</th>
                        <th scope="col">Tanggal Lahir</th>
                        <th scope="col">Jenis Kelamin</th>
                    </tr>
                </thead>
                <tbody>
                <% 
                do until pendidikan.EOF
                %> 
                    <tr>
                        <th scope="row"><% x = x + 1 %> </th>
                        <td><%= pendidikan("JDdk_Nama") %> </td>
                        <td><%= pendidikan("JDdk_AktifYN") %> </td>
                        <td><%= pendidikan("JDdk_UpdateID") %> </td>
                        <td><%= pendidikan("JDdk_UpdateTime") %> </td>
                        <td><%= pendidikan("JDdk_ID") %> </td>
                    </tr>
                <% 
                pendidikan.movenext
                loop
                %> 
                </tbody>
            </table>
        </div>
    </div>

