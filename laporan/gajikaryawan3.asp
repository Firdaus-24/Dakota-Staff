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
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
    <div class="btn-group" role="group" aria-label="Basic outlined example">
    <button type="button" class="btn btn-outline-primary btn-sm" onClick=" window.location.href = 'index.asp'">KEMBALI</button>
    </div>
    <div class="btn-group" role="group" aria-label="Basic outlined example">
    <button type="button" class="btn btn-outline-primary btn-sm" onclick="window.open('exportXls-gajikaryawan3.asp?urut=<%=urut%>&tgla=<%=tgla%>&area=<%=area%>','_self')">EXPORT</button>
    </div>
</div>
<div class="container">
    <div class='row'>
        <div class='col text-sm-start mt-2 header' style="font-size: 12px; line-height:0.3;">
            <p>PT.Dakota Buana Semesta</p>
            <p>JL.WIBAWA MUKTI II NO.8 JATIASIH BEKASI</p>
            <p>BEKASI</p>
        </div>
    </div>
    <div class='row'>
        <div class='col text-center judul'>
            <label class="text-center">LAPORAN GAJI KARYAWAN 3</label></br>
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
        thnlalu = cdate("10/31/2021")

        do while not agen.eof
		
		karyawan_cmd.commandText = "SELECT HRD_T_Salary_Convert.*, HRD_M_karyawan.Kry_Nama, HRD_M_Karyawan.Kry_BPJSKesYN, HRD_M_karyawan.Kry_NoRekening  FROM HRD_T_Salary_Convert LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_Salary_convert.Sal_Nip = HRD_M_Karyawan.Kry_Nip WHERE month(HRD_T_Salary_Convert.Sal_StartDate) = '"& bulan &"' and year(HRD_T_Salary_Convert.Sal_StartDate) = '"& tahun &"' and HRD_M_Karyawan.Kry_AgenID = '"& agen("agen_ID") &"' AND HRD_T_Salary_COnvert.Sal_AktifYN = 'Y' AND HRD_M_Karyawan.Kry_AktifYN = 'Y' ORDER BY HRD_M_Karyawan.Kry_Nama"
        'Response.Write karyawan_cmd.commandText & "<br>"
        set karyawan = karyawan_cmd.execute
		%>
        
        <table class="table">
			<label><%=agen("agen_nama")%></label>
            <thead width="100%">
                <tr>
                    <th scope="col">No Rekening</th>
                    <th scope="col">Total Gaji</th>
                    <th scope="col">No</th>
                    <th scope="col">Nama</th>
                    <th scope="col">Nip</th>
                </tr>
            </thead>
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
                    <td><%= karyawan("Kry_Norekening") %></td>
                    <td><%= totalgaji %></td>
                    <td><%= k %></td>
                    <td><%= karyawan("Sal_Nip") %></td>
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
            </tbody>
        </table>
        </div>
    </div>
</div>
<!-- #include file='../layout/footer.asp' -->