<!-- #include file='../connection.asp' -->
<% 
key = Request.QueryString("key")

set karyawan = Server.CreateObject("ADODB.Command")

karyawan.ActiveConnection = MM_cargo_STRING

karyawan.commandText = "SELECT HRD_M_Karyawan.Kry_Nama, HRD_M_karyawan.Kry_nip, HRD_M_karyawan.Kry_TglMasuk, GLB_M_Agen.Agen_Nama, GLB_M_Agen.Agen_ID, HRD_M_Jabatan.Jab_Code, HRD_M_Jabatan.Jab_Nama,HRD_M_Divisi.Div_Code, HRD_M_Divisi.Div_Nama, HRD_M_Jenjang.JJ_ID, HRD_M_Jenjang.JJ_Nama FROM HRD_M_Karyawan LEFT OUTER JOIN GLB_M_Agen ON HRD_M_Karyawan.Kry_ActiveAgenID = GLB_M_Agen.Agen_ID LEFT OUTER JOIN HRD_M_Jabatan ON HRD_M_Karyawan.Kry_JabCode = HRD_M_Jabatan.Jab_Code LEFT OUTER JOIN HRD_M_Divisi ON HRD_M_Karyawan.Kry_DDBID = HRD_M_Divisi.Div_Code LEFT OUTER JOIN HRD_M_Jenjang ON HRD_M_Karyawan.Kry_JJID = HRD_M_Jenjang.JJ_ID WHERE HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' AND HRD_M_karyawan.Kry_Nip NOT LIKE '%A%' AND HRD_M_Karyawan.Kry_Nip NOT LIKE '%H%' ORDER BY HRD_M_karyawan.Kry_Nama ASC"

set karyawan = karyawan.execute

 %>
    <div class='mb-3 row justify-content-end'>
        <% if karyawan.eof then %>
        <div class='col-sm-10 text-center'>
            <h3>Data tidak ditemukan</h3>
        </div>
        <% else %>
        <div class='col-sm-10'>
            <table class="table table-sm">
                <thead class="bg-secondary text-light">
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">NIP</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Masuk</th>
                        <th scope="col">Agen</th>
                        <th scope="col">Divisi</th>
                        <th scope="col">Jenjang</th>
                        <th scope="col">Jabatan</th>
                    </tr>
                </thead>
                <tbody>
                    <% do until karyawan.eof %>
                    <tr>
                        <th class="text-center">
                            <button type="button" class="btn btn-primary btn-sm" onclick="getName('<%=karyawan("Kry_Nip")%>','<%= karyawan("Kry_Nama") %>','<%= karyawan("Kry_tglMasuk") %>','<%= karyawan("Agen_Nama") %>','<%= karyawan("JJ_Nama") %>','<%= karyawan("Jab_Nama") %>','<%= karyawan("Div_nama") %>','<%= karyawan("Agen_id") %>','<%= karyawan("JJ_ID") %>','<%= karyawan("Jab_code") %>','<%= karyawan("Div_Code") %>')" style="background:transparent;color:blue;border:none;">Pilih</button>
                        </th>
                        <th scope="row"><%= karyawan("Kry_Nip") %></th>
                        <td><%= karyawan("Kry_Nama") %></td>
                        <td><%= karyawan("Kry_tglMasuk") %></td>
                        <td><%= karyawan("Agen_Nama") %></td>
                        <td><%= karyawan("JJ_Nama") %></td>
                        <td><%= karyawan("Jab_Nama") %></td>
                        <td><%= karyawan("Div_Nama") %></td>
                    </tr>
                    <% 
                    karyawan.movenext
                    loop
                    %>
                </tbody>
            </table>
        </div>
        <% end if %>
    </div>

