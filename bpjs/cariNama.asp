<!-- #include file='../connection.asp' -->
<% 
nama = Request.QueryString("nama")
set karyawan = Server.CreateObject("ADODB.COmmand")
karyawan.activeConnection = mm_cargo_string

karyawan.commandText = "SELECT TOP 10 HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama, GLB_M_Agen.Agen_ID, GLB_M_Agen.AGen_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_AgenID = GLB_M_AGen.Agen_ID WHERE HRD_M_Karyawan.Kry_Nama LIKE '%"& nama &"%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND (ISNULL(Kry_Nip, '') <> '') ORDER BY HRD_M_KAryawan.Kry_Nama ASC"
' Response.Write karyawan.commandText & "<br>"
set nama = karyawan.execute

 %>
<% if not nama.eof then %>
<table class="table" style="font-size:12px;color:#fff;">
  <thead>
    <tr>
      <th scope="col"></th>
      <th scope="col">Nip</th>
      <th scope="col">Nama</th>
      <th scope="col">Agen/Cabang</th>
    </tr>
  </thead>
  <tbody>
    <% do until nama.eof %>
    <tr>
      <th scope="row"><button class="badge rounded-pill bg-warning" style="border:none;color:black;" onclick="return getNip('<%= nama("Kry_Nip") %>','<%= nama("Kry_Nama") %>','<%= nama("Agen_ID") %>')">Pilih</button></th>
      <td><%= nama("Kry_Nip") %></td>
      <td><%= nama("Kry_Nama") %></td>
      <td><%= nama("agen_Nama") %></td>
    </tr>
    <% 
    nama.movenext
    loop
     %>
  </tbody>
</table>
<% else %>
    <div class="alert alert-secondary" role="alert" style="background-color:#3A4A76;color:#fff;">
        DATA TIDAK TERDAFTAR!!!
    </div>
<% end if %>