<!-- #include file='../connection.asp' -->
<% 
dim key
key = Request.QueryString("key")

set mutasi = Server.CreateObject("ADODB.Command")
mutasi.ActiveConnection = MM_cargo_STRING

mutasi.commandText = "SELECT HRD_T_Mutasi.*, HRD_M_Karyawan.Kry_Nip, HRD_M_Karyawan.Kry_Nama FROM HRD_T_Mutasi INNER JOIN HRD_M_Karyawan ON HRD_T_Mutasi.Mut_Nip = HRD_M_Karyawan.Kry_Nip WHERE HRD_M_Karyawan.Kry_Nama LIKE '%"& key &"%' AND HRD_T_Mutasi.Mut_AktifYN = 'Y' ORDER BY HRD_M_karyawan.Kry_Nama ASC"
' Response.Write mutasi.commandText & "<Br>"
set karyawan = mutasi.execute

 %>

 <div class='mb-3 row table'>
        <% if karyawan.eof then %>
        <div class='col-sm-12 text-center'>
            <h3>Data tidak ditemukan</h3>
        </div>
        <% else %>
        <div class='col-sm-12'>
            <table class="table table-sm">
                <thead class="bg-secondary text-light">
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Nomor</th>
                        <th scope="col">NIP</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Agen Lama</th>
                        <th scope="col">Agen Baru</th>
                        <th scope="col">Divisi Lama</th>
                        <th scope="col">Divisi Baru</th>
                        <th scope="col">Jenjang Lama</th>
                        <th scope="col">Jenjang Baru</th>
                        <th scope="col">Jabatan Lama</th>
                        <th scope="col">Jabatan Baru</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    status = ""
                    do until karyawan.eof 
                    'agenlama
                    mutasi.commandText = "SELECT Agen_Nama, Agen_ID FROM GLB_M_agen WHERE Agen_ID = '"& karyawan("Mut_asalAgenID") &"'"
                    set agenlama = mutasi.execute

                    if agenlama.eof = false then    
                        lagen1 = agenlama("agen_nama")
                        idagen1 = agenlama("Agen_ID")
                    else
                        lagen1 = ""
                        lagen1 = ""
                    end if  
                                    
                    'deskripsi agenbaru
                    mutasi.commandText = "SELECT Agen_Nama, Agen_ID FROM GLB_M_agen WHERE Agen_ID = '"& karyawan("Mut_tujAgenID") &"'"
                    set agenbaru = mutasi.execute
                    
                    if agenbaru.eof = false  then
                        lagen2 = agenbaru("Agen_Nama")
                        idagen2 = agenbaru("Agen_ID")
                    else
                        lagen2 = ""
                        idagen2 = ""
                    end if

                    'divisilama
                    mutasi.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi WHERE Div_Code = '"& karyawan("Mut_AsalDDBID") &"'"
                    ' Response.Write mutasi.commandText & "<br>"
                    set divisilama = mutasi.execute
                    
                    if divisilama.eof = false then  
                        ldivisi1 = divisilama("Div_Nama")
                        iddivisi1 = divisilama("Div_Code")
                    else
                        ldivisi1 = ""
                        iddivisi1 = ""
                    end if

                    'divisibaru
                    mutasi.commandText = "SELECT Div_Code, Div_Nama FROM HRD_M_Divisi WHERE Div_Code = '"& karyawan("Mut_TujDDBID") &"'"
                    set divisi = mutasi.execute

                    if divisi.eof = false then
                        ldivisi2 = divisi("Div_Nama")
                        iddivisi2 = divisi("Div_Code")
                    else
                        ldivisi2 = ""
                        iddivisi2 = ""
                    end if

                    'jenjanglama
                    mutasi.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_ID = '"& karyawan("Mut_asalJJID") &"'"
                    set jenjanglama = mutasi.execute

                    if jenjanglama.eof = false then
                        ljenjang1 = jenjanglama("JJ_Nama")
                        idjenjang1 = jenjanglama("JJ_ID")
                    else
                        ljenjang1 = ""
                        idjenjang1 = ""
                    end if

                    'deskripsi jenjang baru
                    mutasi.commandText = "SELECT JJ_ID, JJ_Nama FROM HRD_M_Jenjang WHERE JJ_ID = '"& karyawan("Mut_TujJJID") &"'"
                    set jenjangbaru = mutasi.execute

                     if jenjangbaru.eof = false then
                        ljenjang2 = jenjangbaru("JJ_Nama")
                        idjenjang2 = jenjangbaru("JJ_ID")
                    else
                        ljenjang2 = ""
                        idjenjang2 = ""
                    end if


                    'jabatanlama
                    mutasi.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE JAb_Code = '"& karyawan("Mut_AsalJabCode") &"'"
                    set jabatanlama = mutasi.execute

                    if jabatanlama.eof = false then
                        ljabatan1 = jabatanlama("Jab_Nama")
                        idjabatan1 = jabatanlama("Jab_Code")
                    else
                        ljabatan1 = ""
                        idjabatan1 = ""
                    end if

                    'jabatanbaru 
                    mutasi.commandText = "SELECT Jab_Code, Jab_Nama FROM HRD_M_Jabatan WHERE JAb_Code = '"& karyawan("Mut_TujJabCode") &"'"
                    set jabatan = mutasi.execute
                    
                    if jabatan.eof = false then
                        ljabatan2 = jabatan("Jab_Nama")
                        idjabatan2 = jabatan("Jab_Code")
                    else
                        ljabatan2 = ""
                        idjabatan2 = ""
                    end if


                    'status in table
                    If karyawan("Mut_status") = 1 then
                        status = "Demosi"
                    elseIf karyawan("Mut_status") = 2 then
                        status = "Rotasi"
                    elseIf karyawan("Mut_status") = 3 then
                        status = "Promorsi"
                    elseIf karyawan("Mut_status") = 4 then
                        status = "Pensiun"
                    elseIf karyawan("Mut_status") = 5 then
                        status = "Keluar Tanpa Kabar"
                    else 
                        status = "Mutasi"
                    end if
                    %>
                    <tr>
                        <th class="text-center">
                            <button type="button" class="btn btn-primary btn-sm" onclick="getName('<%=karyawan("Kry_Nip")%>','<%= karyawan("Kry_Nama") %>','<%= lagen1 %>','<%= ljenjang1 %>','<%= ljabatan1 %>','<%= ldivisi1 %>','<%= idagen1 %>','<%= idjenjang1 %>','<%= idjabatan1 %>','<%= iddivisi1 %>','<%= idagen2 %>','<%= iddivisi2 %>','<%= idjenjang2 %>','<%= idjabatan2 %>','<%= karyawan("Mut_Nosurat") %>','<%= karyawan("Mut_Status") %>','<%= karyawan("Mut_Tanggal") %>','<%= karyawan("Mut_Memo") %>','<%= karyawan("Mut_Id") %>')" style="background:transparent;color:blue;border:none;">Pilih</button>
                        </th>
                        <th scope="row"><%= karyawan("Mut_Nosurat") %></th>
                        <th scope="row"><%= karyawan("Kry_Nip") %></th>
                        <td><%= karyawan("Kry_Nama") %></td>
                        <td><%= lagen1 %></td>
                        <td><%= lagen2 %></td>
                        <td><%= ldivisi1 %></td>
                        <td><%= ldivisi2 %></td>
                        <td><%= ljenjang1 %></td>
                        <td><%= ljenjang2 %></td>
                        <td><%= ljabatan1 %></td>
                        <td><%= ljabatan2 %></td>
                        <td><%= status %></td>
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