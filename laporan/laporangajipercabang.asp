<!-- #include file='../connection.asp' -->

<% 
dim area, bulan, tahun
dim karyawan, agen

area = Request.form("laparea")
tgla = Request.Form("tgla")

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
    <title>LAPORAN GAJI PERCABANG</title>
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
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
    <div class="btn-group" role="group" aria-label="Basic outlined example">
    <button type="button" class="btn btn-outline-primary btn-sm" onClick=" window.location.href = 'index.asp'">KEMBALI</button>
    </div>
    <div class="btn-group" role="group" aria-label="Basic outlined example">
    <button type="button" class="btn btn-outline-primary btn-sm" onClick="window.open('exportXls-laporanpercabang.asp?tgla=<%=tgla%>','_self')">EXPORT</button>
    </div>
</div>
<div class='row'>
        <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
            <p>PT.Dakota Buana Semesta</p>
            <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
            <p>BEKASI</p>
        </div>
    </div>
    <div class='row'>
        <div class='col text-center judul'>
            <label class="text-center">LAPORAN GAJI PERCABANG</label></br>
            <label class="text-center">PERIODE <b><%= Ucase(MonthName(bulan)) & " " & tahun %></b></label>
        </div>
    </div>
    <div class='row'>
        <div class='col col-sm' style="font-size: 10px;">
            <p>Tanggal Cetak <%= (Now) %></p>
        </div>
    </div>
    <div class='row'>
        <div class='col col-md' >
        <% 
        tgajipercabang = 0
        tinsentifpercabang = 0
        tthrpercabang = 0
        tbpjsppercabang = 0
        ttransport = 0
        tkesehatan = 0 
        tkeluarga = 0 
        tjabatan = 0 
        tasuransi = 0
        tpendapatan = 0 
        tjamsostek = 0 
        tpph21 = 0
        tkoperasi = 0 
        tklaim = 0 
        tbpjskpercabang = 0
        tabsen = 0 
        tlain = 0 
        tpotongan = 0 
        ttotgaji = 0 

        tpengembalianpot = 0
        tpph21dtp = 0

        thnlalu = cdate("10/31/2021")

		%>
        
            <table class="table" style="font-size: 10px; display: block;width: 100%;overflow: scroll;">
                <tr class="table-active">
                    <th scope="col" colspan="3">Cabang</th>
                    <th scope="col">Gaji Pokok</th>
                    <th scope="col">Insentif</th>
                    <th scope="col">THR/Bonus</th>
                    <th scope="col">Pengembalian.Pot</th>
                    <th scope="col">insentifPPh21 DTP</th>
                    <th scope="col">BPJS P.</th>
                    <th scope="col">Transport</th> 
                    <th scope="col">Kesehatan</th>
                    <th scope="col">Keluarga</th>
                    <th scope="col">Jabatan</th>
                    <th scope="col">Asuransi</th>
                    <th scope="col">Pendapatan</th>
                    <th scope="col">Jamsostek</th>
                    <th scope="col">PPH21</th>
                    <th scope="col">BPJS P.</th>
                    <th scope="col">Koperasi</th>
                    <th scope="col">Klaim</th>
                    <th scope="col">BPJS K.</th>
                    <th scope="col">Absen</th>
                    <th scope="col">Lain-Lain</th>
                    <th scope="col">Asuransi</th>
                    <th scope="col">Potongan</th>
                    <th scope="col">Total Gaji</th>
                </tr>
            <%
                do while not agen.eof
		
                karyawan_cmd.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_karyawan.Kry_Nama, HRD_M_Karyawan.Kry_BPJSKesYN FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip WHERE month(HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"' and HRD_M_Karyawan.Kry_AgenID = '"& agen("agen_ID") &"' AND HRD_T_Salary_COnvert.Sal_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' ORDER BY HRD_M_Karyawan.Kry_Nama"
                'Response.Write karyawan_cmd.commandText & "<br>"
                set karyawan = karyawan_cmd.execute
            %>
            <tbody>      
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
                    nonBPJS = nonBPJS + 1
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
            subTotGapok = subTotGapok + CLng(pgapok)
			subTotInsentif = subTotInsentif + CLng(insentif)
			subTotTHR = subTotTHR + CLng(thr)
			subtotbpjsp = subtotbpjsp + Clng(bpjsp)
            subTotTransport = subTotTransport + CLng(transport)
			subTotkesehatan = subTotkesehatan + CLng(kesehatan)
			subTotkeluarga = subTotkeluarga + CLng(keluarga)
			subTotjabatan = subTotjabatan + CLng(jabatan)
			subTotasuransi = subTotasuransi+ CLng(asuransi)
			subPendapatan = subPendapatan + CLng(pendapatan)
			subTotjamsostek = subTotjamsostek + CLng(jamsostek)
			subTotpph21 = subTotpph21 + CLng(pph21)
			subTotkoperasi = subTotkoperasi + CLng(koperasi)
			subTotKlaim = subTotKlaim + CLng(klaim)
			subTotabsen = subTotabsen + CLng(absen)
			subTotlain = subTotlain + CLng(lain)
            subtotbpjsk = subtotbpjsk + Clng(bpjsk)
            subPotongan = subPotongan + Clng(potongan)
            subtotgaji = subtotgaji + Clng(totalgaji)

            subtotalpengembalian = subtotalpengembalian + Clng(karyawan("Sal_pengembalianPot"))
            subtotalpphdtp = subtotalpphdtp + Clng(karyawan("Sal_InsentifPPh21DTP"))
			'total gaji sluruh cabang
            tgajipercabang = tgajipercabang + round(karyawan("Sal_Gapok"))
            tinsentifpercabang = tinsentifpercabang + round(karyawan("Sal_Insentif"))
            tthrpercabang = tthrpercabang + round(karyawan("Sal_THR"))
             
            tpengembalianpot = tpengembalianpot + round(karyawan("Sal_pengembalianPot"))
            tpph21dtp = tpph21dtp + round(karyawan("Sal_InsentifPPh21DTP"))

            tbpjsppercabang = tbpjsppercabang + round(bpjsp)
            ttransport = ttransport + round(karyawan("Sal_TunjTransport"))
            tkesehatan = tkesehatan + round(karyawan("Sal_TunjKesehatan")) 
            tkeluarga = tkeluarga + round(karyawan("Sal_TunjKeluarga"))
            tjabatan = tjabatan + round(karyawan("Sal_TunjJbt"))
            tasuransi = tasuransi + round(karyawan("Sal_Asuransi"))
            tjamsostek = tjamsostek + round(karyawan("Sal_Jamsostek"))
            tpph21 = tpph21 + round(karyawan("Sal_Pph21")) 
            tkoperasi = tkoperasi + round(karyawan("Sal_Koperasi"))
            tklaim = tklaim + round(karyawan("Sal_Klaim"))
            tbpjskpercabang = tbpjskpercabang + round(bpjsk)
            tabsen = tabsen + round(karyawan("Sal_Absen"))
            tlain = tlain + round(karyawan("Sal_Lain")) 

            
			tpotongan = tpotongan + Hpotongan 
            ttotgaji = ttotgaji + Htotalgaji
            tpendapatan = tpendapatan + Hpendapatan
			
            response.flush
            karyawan.movenext
            loop

            ptgajipercabang = formatCurrency(tgajipercabang)
            ptinsnetifpercabang = formatCurrency(tinsentifpercabang)
            ptthrpercabang = formatCurrency(tthrpercabang)
            ptbpjsppercabang = formatCurrency(tbpjsppercabang)
            pttransport = formatCurrency(ttransport)
            ptkesehatan = formatCurrency(tkesehatan)
            ptkeluarga = formatCurrency(tkeluarga)
            ptjabatan = formatCurrency(tjabatan)
            ptasuransi = formatCurrency(tasuransi)
            ptjamsostek = formatCurrency(tjamsostek)
            ptpph21 = formatCurrency(tpph21)
            ptkoperasi = formatCurrency(tkoperasi)
            ptklaim = formatCurrency(tklaim)
            ptabsen = formatCurrency(tabsen)
            ptlain = formatCurrency(tlain)
            ptpotongan = formatCurrency(tpotongan)
            pttotgaji = formatCurrency(ttotgaji)
            ptbpjskpercabang = formatCurrency(tbpjskpercabang)
            ptpendapatan = formatCurrency(tpendapatan)
            

            tgajipercabang = replace(ptgajipercabang,"$","")
            tinsentifpercabang = replace(ptinsnetifpercabang,"$","")
            tthrpercabang = replace(ptthrpercabang,"$","")
            tbpjsppercabang = replace(ptbpjsppercabang,"$","")
            ttransport = replace(pttransport,"$","")
            tkesehatan = replace(ptkesehatan,"$","")
            tkeluarga = replace(ptkeluarga,"$","")
            tjabatan = replace(ptjabatan,"$","")
            tasuransi = replace(ptasuransi,"$","")
            tjamsostek = replace(ptjamsostek,"$","")
            tpph21 = replace(ptpph21,"$","")
            tkoperasi = replace(ptkoperasi,"$","")
            tklaim = replace(ptklaim,"$","")
            tabsen = replace(ptabsen,"$","")
            tlain = replace(ptlain,"$","")
            tpotongan = replace(ptpotongan,"$","")
            ttotgaji = replace(pttotgaji,"$","")
            tbpjskpercabang = replace(ptbpjskpercabang,"$","")
            tpendapatan = replace(ptpendapatan,"$","")
            
             %>
                <tr>
                    <% if nonBPJS >= 1 then %>
                    <td  colspan="3"><%=agen("agen_nama")%> <span style="color:red;font-size:12px;"> <%=nonBPJS%> karyawan belum diupdate BPJS</span></td>
                    <%else %>
                    <td  colspan="3"><%=agen("agen_nama")%></td>
                    <%end if %>
                    <% nonBPJS = 0 %>
                    <td ><%= replace(formatCurrency(subTotGapok),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotInsentif),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotTHR),"$","")  %></td>
                    <td ><%= replace(formatCurrency(subtotalpengembalian),"$","")  %></td>
                    <td ><%= replace(formatCurrency(subtotalpphdtp),"$","")  %></td>
                    <td ><%= replace(formatCurrency(subtotbpjsp),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotTransport),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotkesehatan),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotkeluarga),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotjabatan),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotasuransi),"$","") %></td>
                    <td ><%= replace(formatCurrency(subPendapatan),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotjamsostek),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotpph21),"$","") %></td>
                    <td ><%= replace(formatCurrency(subtotbpjsp),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotkoperasi),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotKlaim),"$","") %></td>
                    <td ><%= replace(formatCurrency(subtotbpjsk),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotabsen),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotlain),"$","") %></td>
                    <td ><%= replace(formatCurrency(subTotasuransi),"$","") %></td>
                    <td ><%= replace(formatCurrency(subPotongan),"$","") %></td>
                    <td ><%= replace(formatCurrency(subtotgaji),"$","") %></td>
                </tr>
        <% 
         
        response.flush
        agen.movenext
        i = i + 1
        loop
        %>         
                <tr class="table-active">
                    <td colspan="3">TOTAL KESELURUHAN</td>
                    <td><%= tgajipercabang %></td>
                    <td><%= tinsentifpercabang %></td>
                    <td><%= tthrpercabang %></td>
                    <td><%= replace(formatCurrency(tpengembalianpot),"$","") %></td>
                    <td><%= replace(formatCurrency(tpph21dtp),"$","") %></td>
                    <td><%= tbpjsppercabang %></td>
                    <td><%= ttransport %></td>
                    <td><%= tkesehatan %></td>
                    <td><%= tkeluarga %></td>
                    <td><%= tjabatan %></td>
                    <td><%= tasuransi %></td>
                    <td><%= tpendapatan %></td>
                    <td><%= tjamsostek %></td>
                    <td><%= tpph21 %></td>
                    <td><%= tbpjsppercabang %></td>
                    <td><%= tkoperasi %></td>
                    <td><%= tklaim %></td>
                    <td><%= tbpjskpercabang %></td>
                    <td><%= tabsen %></td>
                    <td><%= tlain %></td>
                    <td><%= tasuransi %></td>
                    <td><%= tpotongan %></td>
                    <td><%= ttotgaji %></td>
                </tr>
            </tbody>
        </table>
<!-- #include file='../layout/footer.asp' -->