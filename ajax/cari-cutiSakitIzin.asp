<!-- #include file='../connection.asp' -->
<% 
dim nip, data, cuti, cuti_cmd

nip = Request.QueryString("nip")    
data = Request.QueryString("data")
' Response.Write data & "<br>"
set cuti_cmd = Server.CreateObject("ADODB.Command")
cuti_cmd.activeconnection = MM_Cargo_String

cuti_cmd.commandText = "SELECT * FROM HRD_T_IzinCutiSakit WHERE ICS_Nip = '"& nip &"' and year(ICS_StartDate) = '"& data &"' and year(ICS_EndDate) = '"& data &"' AND ICS_aktifYN = 'Y' ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"
' Response.Write cuti_cmd.commandText
set cuti = cuti_cmd.execute

cuti_cmd.commandText = "SELECT Kry_Nama, Kry_JmlCuti FROM HRD_M_Karyawan WHERE Kry_nip = '"& nip &"'"
set karyawan = cuti_cmd.execute

' sisa cuti tahun ini
cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS jharicuti FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& data &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& data &"' AND HRD_T_IzinCutiSakit.ICS_PotongCuti <> '' AND HRD_T_IzinCutiSakit.ICS_PotongCuti = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
' Response.Write cuti_cmd.commandText & "<br>"
set saldo = cuti_cmd.execute

jharicuti = 0
do while not saldo.eof
    jharicuti = jharicuti + (saldo("jharicuti") + 1)
saldo.movenext
loop

sisacuti = int(karyawan("Kry_JmlCuti")) - int(jharicuti)

' potongan gaji tahun ini
cuti_cmd.commandText = "SELECT HRD_T_IzinCutiSakit.ICS_ID, SUM(DATEDIFF(day,HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate)) AS pgaji FROM HRD_T_IzinCutiSakit WHERE HRD_T_IzinCutiSAkit.ICS_Nip = '"& nip &"' and year(HRD_T_IzinCutiSakit.ICS_StartDate) = '"& data &"' AND Year(HRD_T_IzinCutiSakit.ICS_EndDate) = '"& data &"' AND HRD_T_IzinCutiSakit.ICS_PotongGaji <> '' AND HRD_T_IzinCutiSakit.ICS_Potonggaji = 'Y' AND HRD_T_IzinCutiSakit.ICS_AktifYN = 'Y' AND ICS_AtasanApproveYN = 'Y' AND ICS_AtasanUpperApproveYN = 'Y' GROUP BY HRD_T_IzinCutiSakit.ICS_ID, HRD_T_IzinCutiSakit.ICS_StartDate,HRD_T_IzinCutiSakit.ICS_EndDate ORDER BY HRD_T_IzinCutiSakit.ICS_StartDate DESC"  
' Response.Write cuti_cmd.commandText & "<br>"
set saldogaji = cuti_cmd.execute

' total potongan gaji
tgaji = 0
do while not saldogaji.eof
    tgaji = tgaji + (saldogaji("pgaji") + 1)
saldogaji.movenext
loop
 %>
<% if cuti.eof then %>
<div class='row text-center mt-3'>
    <div class='col-lg'>
        <h5>DATA TIDAK DI TEMUKAN</h5>
    </div>
</div>
<% else %>
<table class="table table-striped table-hover cari-izin">
    <thead class="text-center ">
        <tr>
            <th scope="col">No</th>
            <th scope="col">Mulai</th>
            <th scope="col">Berakhir</th>
            <th scope="col">Status</th>
            <th scope="col">Keterangan</th>
            <th scope="col">Potong</th>
            <th scope="col">Biaya Pengobatan</th>
            <th scope="col">Aktif</th>
            <th scope="col">Tanpa Form</th>
            <th scope="col">Atasan 1</th>
            <th scope="col">Atasan 2</th>
            <th scope="col">Surat Dokter</th>
            <% 'if Cint(data) = year(date) then %>
            <th scope="col" class="text-center">Aksi</th>
            <%' end if %>
        </tr>
    </thead>
    <tbody>
        <% 
        jumlahcuti = 0 
        status = ""
        aktif = ""
        surat = ""
        dokter = ""
        sisaklaim = 0
        sisaklaimpotgaji = 0
        sisaalfa = 0
        sisaalfapotgaji = 0
        sisaizin = 0
        sisaizinpotgaji = 0
        do until cuti.eof
        'status
        if cuti("ICS_status") = "A" then
            status = "Alfa"
        elseIf cuti("ICS_status") = "B" then
            status = "Cuti Bersama"
        elseIf cuti("ICS_status") = "C" then
            status = "Cuti"
        elseIf cuti("ICS_status") = "G" then
            status = "Dispensasi"
        elseIf cuti("ICS_status") = "I" then
            status = "Izin"
        elseIf cuti("ICS_status") = "K" then
            status = "Klaim Obat"
        elseIf cuti("ICS_status") = "S" then
            status = "Sakit"
        else
            status = ""
        end if

        'aktif
        if cuti("ICS_AktifYN") = "Y" then
            aktif = "Aktif"
        else 
            aktif = "Tidak"
        end if
        'form
        if cuti("ICS_FormYN") = "Y" then
            surat = "Ya"
        else
            surat = "Tidak"
        end if
         %>
        <tr>
            <td><%= cuti("ICS_ID")%></td> 
            <td><%= cuti("ICS_StartDate")%></td> 
            <td><%= cuti("ICS_EndDate")%></td> 
            <td><%= status %></td> 
            <td><%= cuti("ICS_Keterangan")%></td> 
            <td>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="inlineCheckbox3" disabled <% if cuti("ICS_potongGaji") = "Y" then %>checked <% end if %>>
                    <label class="form-check-label" for="inlineCheckbox3">Gaji</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="inlineCheckbox3" disabled <% if cuti("ICS_potongCuti") = "Y" then %>checked <% end if %>>
                    <label class="form-check-label" for="inlineCheckbox3">Cuti</label>
                </div>
            </td>
            <td><%=cuti("ICS_Obat")%></td>
            <td class="text-center"><%=aktif%></td>
            <td class="text-center"><%=surat%></td>
            <% 
            if cuti("ICS_AtasanApproveYN") = "Y" then
             %>
                <td class="text-center">ACC</td>
            <% else %>
                <td class="text-center" style="color:red;">Belum ACC</td>
            <% end if %>
            <% 
            if cuti("ICS_AtasanUpperApproveYN") = "Y" then
             %>
                <td class="text-center">ACC</td>
            <% else %>
                <td class="text-center" style="color:red;">Belum ACC</td>
            <% end if %>

            <td class="text-center">
			<%
			
					if isNull(cuti("ICS_SuratDokterYN")) = true or len(cuti("ICS_SuratDokterYN")) < 1 then %>
						Tidak Ada
			<%else%>
						
					<a href="../suratdokter/<%=cuti("ICS_SuratDokterYN")%>.jpg">Ya (Klik Detail)</a> <%	end if%>
			
			</td>
            <% 'if Cint(data) = year(date) then %>
                <td>
                    <div class="btn-group btnNavCuti">
                        <button type="button" class="btn btn-primary btn-sm py-0 px-2 modalUbah" data-bs-toggle="modal" data-bs-target="#formModal" onclick="return modalubahcuti('<%=cuti("ICS_ID")%>','<%= cuti("ICS_Nip") %>')">
                            Edit
                        </button>
                        <% 
                        dim aktif
                        aktif = cuti("ICS_AktifYN")
                        nomor = cuti("ICS_ID")
                        if aktif = "Y" then
                        %>
                            <button type="button" class="btn btn-warning btn-sm py-0 px-2" onclick="return ubahStatusCuti('<%=aktif%>','<%=nip%>','<%=nomor%>')">
                                aktif
                            </button>
                        <% 
                        else 
                        %>
                            <button type="button" class="btn btn-danger btn-sm py-0 px-2" onclick="return ubahStatusCuti('<%=aktif%>','<%=nip%>','<%=nomor%>')">
                                NoAktif
                            </button>
                        <% end if %>
                        <button type="button" class="btn btn-info btn-sm" onclick="window.location.href='cuti-sakit/suratdokter.asp?nip=<%= nip %>&id=<%= cuti("ICS_ID")%>'"><i class="fa fa-picture-o" aria-hidden="true"></i></button>
                    </div>
                
                </td>
            <% 'end if %>
        </tr> 
        <% 
       
        cuti.movenext
        loop
         %>
            
    </tbody>
</table>
 <% end if %>
<input type="hidden" id="hcuti" value="<%=sisacuti%>">
<input type="hidden" id="tpotgaji" value="<%=tgaji%>">


<!-- #include file='../layout/footer.asp' -->