<!-- #include file='../../connection.asp' -->
<% 
  dim key 
  dim karyawan

  key = Request.QueryString("key")

  set tpk_cmd = Server.CreateObject("ADODB.COmmand")
  tpk_cmd.activeConnection = mm_cargo_string

  set karyawan = Server.CreateObject("ADODB.COmmand")
  karyawan.activeConnection = mm_cargo_string

  ' karyawan.commandText = "SELECT HRD_T_PK.TPK_ID, HRD_T_PK.TPK_NIP, HRD_T_PK.TPK_Ket, HRD_T_PK.TPK_PP, HRD_T_PK.TPK_Lama, ISNULL(SUM(HRD_T_BK.TPK_PP), 0) AS terbayar, HRD_T_PK.TPK_PP - ISNULL(SUM(HRD_T_BK.TPK_PP), 0) AS utang, HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_Tanggal FROM HRD_T_PK LEFT OUTER JOIN HRD_T_BK ON HRD_T_PK.TPK_Ket = HRD_T_BK.TPK_Ket AND HRD_T_PK.TPK_NIP = HRD_T_BK.TPK_NIP LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_PK.TPK_NIP = HRD_M_Karyawan.Kry_Nip WHERE (HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%') AND HRD_T_PK.TPK_AktifYN = 'Y' GROUP BY HRD_T_PK.TPK_ID, HRD_T_PK.TPK_NIP, HRD_T_PK.TPK_Ket, HRD_T_PK.TPK_PP, HRD_M_Karyawan.Kry_Nama, HRD_T_PK.TPK_Tanggal, HRD_T_PK.TPK_Lama HAVING (HRD_T_PK.TPK_PP - ISNULL(SUM(HRD_T_BK.TPK_PP), 0) > 0) ORDER BY HRD_T_PK.TPK_Tanggal DESC"
  karyawan.commandText = "SELECT HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN HRD_T_PK ON HRD_M_Karyawan.Kry_Nip = HRD_T_PK.TPK_Nip WHERE HRD_T_PK.TPK_aktifYN = 'Y' AND HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%' GROUP BY HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama ORDER BY Kry_Nama ASC "
  ' Response.Write karyawan.commandText & "<br>"
  set karyawan = karyawan.execute
 %>
    <style>
    .table-carikaryawan{
      display: block;
      width:auto;
      height: 200px;
      overflow-y: scroll;
      font-size:12px;
    }
    </style>
      <% 
      if karyawan.eof then 
       %>
      <div class='row'>
        <div class='col'>
          <p style="color:red;">DATA NAMA TIDAK DI TEMUKAN</p>
        </div>
      </div>
      <% else %>
      <table class="table table-carikaryawan">
        <thead>
            <tr>
                <th scope="col">Pilih</th>
                <th scope="col">NIP</th>
                <th scope="col">NAMA</th>
            </tr>
        </thead>
        <tbody class="tr-table">
            <% 
            no = 0
            do until karyawan.eof 
            
            %>
            <tr>
                <th><input class="form-check-input" type="radio" name="resultCari" id="resultCari" onclick="return clickRadio('<%= karyawan("Kry_Nama") %>', '<%= karyawan("Kry_Nip") %>')"></th>
                <td id="cariNip"><%= karyawan("Kry_Nip") %></td>
                <td id="cariNama"><%= karyawan("Kry_Nama") %></td>
            </tr>
            <% 
            karyawan.movenext
            loop
            %>
        </tbody>
    </table>
    <% end if %>