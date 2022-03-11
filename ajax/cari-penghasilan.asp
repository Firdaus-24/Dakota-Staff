<!--#include file="../connection.asp"-->
<!-- #include file='../constend/constanta.asp' -->
<!-- #include file='../layout/header.asp' -->
<% 
' keharusan user login sebelum masuk ke menu utama aplikasi
if session("username") = "" then
response.Redirect("../login.asp")
end if
response.Buffer=true
server.ScriptTimeout=1000000000
 
dim tahun, gaji, nip, bpjsjkk, hasilbpjsjkk

nip = Request.QueryString("nip")
tahun = request.queryString("tahun")


'query gaji
set gaji_cmd = server.createObject("ADODB.Command")
gaji_cmd.activeConnection = MM_Cargo_String

gaji_cmd.commandText = "SELECT  HRD_T_Salary_Convert.*, HRD_M_Karyawan.Kry_BpjsYN, HRD_M_Karyawan.Kry_BpjsKesYN FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_Convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip WHERE Sal_NIP = '"& nip &"' and year(Sal_StartDate) = '"& tahun &"' ORDER BY Sal_StartDate DESC "
'Response.Write gaji_cmd.commandText &"<br>"
set gaji = gaji_cmd.execute

gaji_cmd.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_NIP ='"& nip &"'"

set kry = gaji_cmd.execute

' cek aktifasi bpjs 
gaji_cmd.commandText = "SELECT TOP 1 Mut_BPJSKes, Mut_BPJSKet,Mut_tanggal FROM HRD_T_MutasiBPJS WHERE Mut_Krynip = '"& nip &"' ORDER BY Mut_tanggal DESC"
' Response.Write gaji_cmd.commandTExt & "<br>"
set mutbpjs = gaji_cmd.execute 

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REPORT GAJI KARYAWAN</title>
    <style>
        tr {
            width: 1%;
            white-space: nowrap;
        }
        #aktif-penghasilan{
            text-decoration:none;
        }
        #no-penghasilan{
            text-decoration:none;
        }
        span{cursor:pointer;}
    </style>

</head>
<body>
<% 
if gaji.eof then
 %>
<div class='text-center bg-secondary p-2 text-white bg-opacity-25 mt-2'>
    <div class='notiv-header'>
        <label>WARNING !!!</label>
    </div>
    <div class='content-pernama'>
        <p>DATA TIDAK DI TEMUKAN</p>
        <p>MOHON HUBUNGI BAGIAN IT / TUNGGU UPDATE DATA BESOK</p>
    </div>
</div>
<% else %>
<div class="col mt-2" style="overflow-x: auto; overflow:y auto;">
    <table class="table table-striped tblpenghasilan">
       
            <tr class="text-center">
                <th scope="col" class="text-center">Aksi</th> 
                <th scope="col">No</th>
                <th scope="col">Tanggal</th>
                <th scope="col">Gaji Pokok</th>
                <th scope="col">Insentif</th>
                <th scope="col">THR/Bonus</th>
                <th scope="col">BPJS.P</th>
                <th scope="col">Tunj.Trasport</th>
                <th scope="col">Tunj.Kesehatan</th>
                <th scope="col">Tunj.Keluarga</th>
                <th scope="col">Tunj.Jabatan</th>
                <th scope="col">Asuransi</th>
                <th scope="col">Jamsostek</th>
                <th scope="col">Pot.PPh21</th>
                <th scope="col">Pot.Koperasi</th>
                <th scope="col">Pot.Klaim</th>
                <th scope="col">BPJS.K</th>
                <th scope="col">Pot.Absen</th>
                <th scope="col">Pot.Lain</th>
                <th scope="col">Kerterangan</th>
                <th scope="col">Aktif</th>     
                <th scope="col">User Upload</th>     
            </tr>
            <% 
            thnlalu = cdate("10/31/2021")
            thndepan = dateAdd("d",1, thnlalu)
            notivbpjs = ""
            do until gaji.eof
            bpjsp = (gaji("Sal_gapok") / 100) * 4
            bpjsk = (gaji("Sal_GaPok") / 100) * 1

            ' cek aktifasi bpjs 
            if thnlalu <= gaji("Sal_StartDate") then
                if not mutbpjs.eof then
                    if mutbpjs("mut_tanggal") <= gaji("Sal_StartDate") then
                        if mutbpjs("Mut_BPJSKes") = "Y" then
                            rbpjsp = Round(bpjsp)
                            rbpjsk = Round(bpjsk)
                        else
                            rbpjsp = 0 
                            rbpjsk = 0 
                        end if
                    else
                        rbpjsp = 0
                        rbpjsk = 0
                    end if
                else
                    rbpjsp = 0
                    rbpjsk = 0
                    Response.Write "<tr><td colspan='22' style='color:red;'>MOHON UNTUK UPDATE AKTIFASI BPJS TERLEBIH DAHULU</td></tr>" & "<br>"
                end if
            else
                if kry("Kry_BPJSKesYN") = "N" then 
                    rbpjsp = 0
                    rbpjsk = 0
                else
                    rbpjsp = Round(bpjsp)
                    rbpjsk = Round(bpjsk)
                end if
            end if
            %>
                <tr>
                    <td>
                        <div class="penghasilan-aktif text-center">
                                <div class="btn-group">
                            <% 
                            ' cek session
                            if session("HA7") = true then
                                if session("HA7A") = true then %>      
                                    <% if not mutbpjs.eof then %>                      
                                        <% if month(gaji("Sal_StartDate")) = month(date) And year(gaji("Sal_StartDate")) = year(date) then%>
                                            <span class="badge rounded-pill bg-primary updatePenghasilan" data-bs-toggle="modal" data-bs-target="#modalTambahGaji" onclick="return updatePenghasilan('<%=gaji("Sal_ID")%>', '<%= mutbpjs("Mut_BPJSKet") %>','<%= mutbpjs("Mut_BPJSKes") %>','<%= kry("Kry_Nip") %>')">Update</span>
                                        <% else %>
                                            <span></span>
                                        <% end if %>
                                    <% end if %>
                                <% end if %>
                            <% end if %>
                            
                            <%' cek session
                            if session("HA7") = true then
                                if session("HA7B") = true then %>  
                                    <% if gaji("Sal_AktifYN") = "N" then %>
                                        <span class="badge rounded-pill bg-primary"><a href="<%= url %>/detail-karyawan/penghasilanAktif.asp?id=<%= gaji("Sal_ID") %>&aktif=<%= gaji("Sal_AktifYN") %>&nip=<%=nip%>" id="aktif-penghasilan" style="text-decoration:none;color:#fff;">AKTIF</a></span> 
                                    <% else %>
                                        <span class="badge rounded-pill bg-danger"><a href="<%= url %>/detail-karyawan/penghasilanAktif.asp?id=<%= gaji("Sal_ID") %>&aktif=<%= gaji("Sal_AktifYN") %>&nip=<%=nip%>" id="no-penghasilan" style="text-decoration:none;color:#fff;">NON AKTIF</a> </span> 
                                        <span class="badge rounded-pill bg-info"><a href="<%= url %>/detail-karyawan/slipgaji.asp?id=<%= gaji("Sal_ID") %>&nip=<%=nip%>" id="slipgaji" style="text-decoration:none;color:#fff;">SLIPGAJI</a></span> 
                                    <% end if %>
                                <% end if %>
                            <% end if %>
                            </div>
                    </td>
                    <td scope="row"><%= gaji("Sal_ID") %> </td>
                    <td><%= gaji("Sal_StartDate") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_gapok")),"$","") %></td>
                    <td><%= replace(formatCurrency(gaji("Sal_Insentif")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_THR")),"$","") %> </td>
                    <td><%= replace(formatCurrency(rbpjsp),"$","") %></td>
                    <td><%= replace(formatCurrency(gaji("Sal_TunjKesehatan")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_TunjTransport")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_TunjKeluarga")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_TunjJbt")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_Asuransi")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_Jamsostek")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_PPh21")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_Koperasi")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_Klaim")),"$","") %> </td>
                    <td><%= replace(formatCurrency(rbpjsk),"$","") %></td>
                    <td><%= replace(formatCurrency(gaji("Sal_Absen")),"$","") %> </td>
                    <td><%= replace(formatCurrency(gaji("Sal_Lain")),"$","") %> </td>
                    <td><%= gaji("Sal_Catatan") %> </td>
                    <td><%= gaji("Sal_AktifYN") %> </td>
                    <td><%= session("username") %></td>
                </tr>
            <% 
            gaji.movenext
            loop 
            %>
    </table>
</div>
<% end if %>
<!-- #include file='../layout/footer.asp' -->



