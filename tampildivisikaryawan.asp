<!-- #include file="connection.asp"-->
<% 
  if session("username") = "" then
      Response.Redirect("login.asp")
  end if

  dim id, karyawanDiv

  id = request.queryString("id")
  agen = request.queryString("agen")
  'koneksi karyawan berdasarkan divisi
  set karyawanDiv = server.createobject("ADODB.Command")
  karyawanDiv.activeConnection = MM_Cargo_string

  karyawanDiv.commandText ="SELECT Kry_Nip, Kry_Nama FROM HRD_M_Karyawan WHERE HRD_M_Karyawan.Kry_DDBID = '"& id &"' and Kry_AktifYN = 'Y' AND Kry_Nip NOT LIKE '%H%' AND Kry_Nip NOT LIKE '%A%' AND Kry_AgenID = '"& agen &"' ORDER BY Kry_Nama ASC"

  set karyawan = karyawanDiv.execute

 %> 
<script>
// button ceklis nama karyawan di tampil divisi
  $('#selectAll').on('click', function () {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var checkbox of checkboxes) {
      checkbox.checked = this.checked;
    }
  });
  $("input[type=checkbox]").click(function() {
    if (!$(this).prop("checked")) {
      $("#selectAll").prop("checked", false);
    }
  });
</script>
<!--#include file="layout/header.asp"-->
<div class="container" name="tampil_karyawan" id="tampil_karyawan">
      <table class="table table-striped table-hover">
        <thead>
        <tr>
          <td class="text-center">
            <input class="form-check-input" id="selectAll" type="checkbox"> <label for='selectAll'>Select All</label>
          </td>
          <td>
            <label>Nip</label>
          </td>
          <td>
            <label>Nama</label>
          </td>
        </tr>
        </thead>
        <tbody>
      <% do until karyawan.eof %> 
        <tr>
          <td class="text-center">
            <input class="form-check-input" type="checkbox" name="karyawan" id="karyawan" value="<%= karyawan("Kry_Nip") %> ">
          </td>
          <td >
            <label><%= karyawan("Kry_Nip") %></label>
          </td>
          <td >
            <label><%= karyawan("Kry_Nama") %></label>
          </td>
        <tr>
      <% karyawan.movenext
      loop %> 
        <tbody>
      </table>                   
</div>

