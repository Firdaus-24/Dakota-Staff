<!-- #include file='../connection.asp' -->
<% 
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "content-disposition", "filename=Gaji Karyawan "& monthname(month(Request.QueryString("tgla"))) &"-"& Year(Request.QueryString("tgla")) &".xls"

dim tahun, bulan, pegawai, status, agen, gaji_cmd, gaji

tgla = Request.QueryString("tgla")
area = Request.QueryString("area")
if tgla <> "" then
    bulan = month(tgla)
    tahun = year(tgla)
end if
  		
if area <> "" then
	filterArea = " AND Agen_ID = "& area 
    Else
    filterArea = " "

end if

set agen = Server.CreateObject("ADODB.COmmand")
agen.ActiveConnection = MM_Cargo_string

agen.commandText = "SELECT dbo.GLB_M_Agen.Agen_ID, dbo.GLB_M_Agen.Agen_Nama FROM dbo.HRD_M_Karyawan LEFT OUTER JOIN dbo.GLB_M_Agen ON dbo.HRD_M_Karyawan.Kry_AgenID = dbo.GLB_M_Agen.Agen_ID left OUTER JOIN dbo.HRD_T_Salary_convert ON dbo.HRD_M_Karyawan.Kry_NIP = dbo.HRD_T_Salary_convert.Sal_NIP WHERE (dbo.GLB_M_Agen.Agen_AktifYN = 'Y') AND month(HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"' and (dbo.GLB_M_Agen.Agen_Nama NOT LIKE '%XXX%') " & filterArea & "  GROUP BY dbo.GLB_M_Agen.Agen_ID, dbo.GLB_M_Agen.Agen_Nama ORDER BY dbo.GLB_M_Agen.Agen_Nama" 
'Response.Write agen.commandText & "<br>"
set agen = agen.execute


set karyawan_cmd = Server.CreateObject("ADODB.COmmand")
karyawan_cmd.ActiveConnection = MM_Cargo_string

set mutasibpjs_cmd = Server.CreateObject("ADODB.Command")
mutasibpjs_cmd.ActiveConnection = MM_Cargo_string

 %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAPORAN GAJI KARYAWAN 3</title>
    <!-- #include file='../layout/header.asp' -->
    <style>
        span{
            font-size:14px;
        }
        tr {
            width: 1%;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<table>
        <tr>
            <td colspan="3">PT.Dakota Buana Semesta</td>
        </tr>
        <tr>
            <td colspan="3">JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</td>
        </tr>
        <tr>
            <td colspan="3">BEKASI</td>
        </tr>
        <tr>
            <td colspan="5" style="text-align:center;">LAPORAN GAJI KARYAWAN 3</td></br>
        </tr>
        <tr>
            <td colspan="5" style="text-align:center;">PERIODE <b><%= Ucase(MonthName(bulan)) & " " & tahun %></b></td>
        </tr>
        <tr>
            <td colspan="5" style="font-size:10px;">Tanggal Cetak <%= (Now) %></td>
        </tr>
        <% 
        thnlalu = cdate("10/31/2021")

        do while not agen.eof
		
		karyawan_cmd.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_karyawan.Kry_Nama, HRD_M_Karyawan.Kry_BPJSKesYN, HRD_M_karyawan.Kry_NoRekening  FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip WHERE month(HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"' and HRD_M_Karyawan.Kry_AgenID = '"& agen("agen_ID") &"' AND HRD_T_Salary_COnvert.Sal_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' ORDER BY HRD_M_Karyawan.Kry_Nama"
        'Response.Write karyawan_cmd.commandText & "<br>"
        set karyawan = karyawan_cmd.execute
		%>
        
            <tr>
			    <td colspan="5"><%=agen("agen_nama")%></td>
            </tr>
                <tr>
                    <th>No Rekening</th>
                    <th>Total Gaji</th>
                    <th>No</th>
                    <th>Nip</th>
                    <th>Nama</th>
                </tr>
            <%
            k = 0
            subTotGapok = 0
            subTotInsentif = 0
            subTotTHR = 0
            subTotTransport = 0
            subtotbpjsp = 0
            subTotkesehatan = 0
            subTotkeluarga = 0
            subTotjabatan = 0
            subTotasuransi = 0
            subPendapatan = 0
            subTotjamsostek = 0
            subTotpph21 = 0
            subTotkoperasi = 0
            subTotKlaim = 0
            subTotabsen = 0
            subtotbpjsk = 0
            subTotlain = 0
            subPotongan = 0
            subtotgaji = 0
            subtotalpengembalian = 0
            subtotalpphdtp = 0

            do while not karyawan.eof
            k = k + 1
            'set format rupiah
            gapok = formatCurrency(round(karyawan("Sal_Gapok")))
            insentif = formatCurrency(round(karyawan("Sal_Insentif")))
            thr = formatCurrency(round(karyawan("Sal_THR")))
            transport = formatCurrency(round(karyawan("Sal_TunjTransport")))
            kesehatan = formatCurrency(round(karyawan("Sal_TunjKesehatan")))
            keluarga = formatCurrency(round(karyawan("Sal_TunjKeluarga")))
            jabatan = formatCurrency(round(karyawan("Sal_TunjJbt")))
            asuransi = formatCurrency(round(karyawan("Sal_Asuransi")))
            jamsostek = formatCurrency(round(karyawan("Sal_jamsostek")))
            pph21 = formatCurrency(round(karyawan("Sal_pph21")))
            koperasi = formatCurrency(round(karyawan("Sal_Koperasi")))
            klaim = formatCurrency(round(karyawan("Sal_Klaim")))
            absen = formatCurrency(round(karyawan("Sal_Absen")))
            lain = formatCurrency(round(karyawan("Sal_Lain")))

            pgapok = replace(gapok,"$","")
            insentif = replace(insentif,"$","")
            thr = replace(thr,"$","")
            transport = replace(transport,"$","")
            kesehatan = replace(kesehatan,"$","")
            keluarga = replace(keluarga,"$","")
            jabatan = replace(jabatan,"$","")
            asuransi = replace(asuransi,"$","")
            jamsostek = replace(jamsostek,"$","")
            pph21 = replace(pph21,"$","")
            koperasi = replace(koperasi,"$","")
            klaim = replace(klaim,"$","")
            absen = replace(absen,"$","")
            lain = replace(lain,"$","")

            ' cek aktifasi bpjsyn
            mutasibpjs_cmd.commandText = "SELECT TOP 1 Mut_BPJSKes, Mut_BPJSKet, Mut_Tanggal FROM HRD_T_MutasiBPJS WHERE Mut_KryNip = '"& karyawan("Sal_Nip") &"' ORDER BY Mut_Tanggal DESC "

            set mutasibpjs = mutasibpjs_cmd.execute

            if not mutasibpjs.eof then
                if mutasibpjs("mut_tanggal") <= karyawan("Sal_StartDate") then
                    if mutasibpjs("Mut_BPJSKes") = "Y" then
                        bpjsp = Round((pgapok / 100) * 4)
                        bpjsk = Round((gapok / 100) * 1)
                    else
                        bpjsp = 0 
                        bpjsk = 0 
                    end if
                else
                    if karyawan("Kry_BPJSKesYN") = "Y" then 
                    'make atribut to round or ceil number
                        bpjsp = Round((pgapok / 100) * 4)
                        bpjsk = Round((gapok / 100) * 1)
                    else
                        bpjsp = 0
                        bpjsk = 0
                    end if
                end if
            else
                if thnlalu >= karyawan("Sal_StartDate") then
                    if karyawan("Kry_BPJSKesYN") = "Y" then 
                        'make atribut to round or ceil number
                        bpjsp = Round((pgapok / 100) * 4)
                        bpjsk = Round((gapok / 100) * 1)
                    else
                        bpjsp = 0
                        bpjsk = 0
                    end if
                else
                    bpjsp = 0
                    bpjsk = 0
                    Response.Write "<tr><td colspan='26' style='color:red;'>MOHON UNTUK UPDATE AKTIFASI BPJS TERLEBIH DAHULU</td></tr>"
                end if
            end if
            'hidun pendapatan
            Hpendapatan = CLng(pgapok) + bpjsp + CLng(insentif) + CLng(THR) + CLng(transport) + CLng(kesehatan) + CLng(keluarga) + CLng(jabatan) + CLng(asuransi) + Clng(karyawan("Sal_InsentifPPh21DTP")) + Clng(karyawan("Sal_pengembalianPot"))
            ' Response.Write bpjsp & "<br>"
            ppendapatan = formatCurrency(Hpendapatan)
            pendapatan = replace(ppendapatan,"$","")

            'hitung potongan
            Hpotongan = CLng(jamsostek) + CLng(pph21) + bpjsp + CLng(koperasi) + CLng(klaim) + bpjsk + CLng(absen) + CLng(lain) +  CLng(asuransi)

            ppotongan = formatCurrency(Hpotongan)
            potongan = replace(ppotongan,"$","")

            'total gaji perkaryawan
            Htotalgaji = pendapatan - potongan
            ptotalgaji = formatCurrency(Htotalgaji)
            totalgaji = replace(ptotalgaji,"$","")

            'total gaji pernama
            subtotgaji = subtotgaji + Clng(totalgaji)
            %>
                <tr>
                    <td style="mso-number-format:\@;"><%= karyawan("Kry_Norekening") %></td>
                    <td><%= totalgaji %></td>
                    <td><%= k %></td>
                    <td style="mso-number-format:\@;"><%= karyawan("Sal_Nip") %></td>
                    <td><%= karyawan("Kry_Nama") %></td>
                </tr>
            <%
            response.flush
            karyawan.movenext
            loop
            
            %>
                <tr>
                    <td>SUBTOTAL</td>
                    <td  style="color:#fff;background-color:gray;" colspan="4"><%= replace(formatCurrency(subtotgaji),"$","") %></td>
                </tr>
        <% 
        response.flush
        agen.movenext
        i = i + 1
        loop
        %>         
</table>