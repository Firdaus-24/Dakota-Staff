<!-- #include file='../../connection.asp' -->
<% 
    dim mutasi_cmd, mutasi
    dim bulan, tahun, nip, nama, area, radio, saldoakhir, tpinjaman, tbayar

    bulan = trim(Request.Form("bulan"))
    tahun = trim(Request.Form("tahun"))
    nama = trim(Request.Form("nama"))
    area = trim(Request.Form("area"))
    radio = Request.Form("option")

    set mutasi_cmd = Server.CreateObject("ADODB.Command")
    mutasi_cmd.activeConnection = mm_cargo_string

    if radio = "detail" then
        if nama = "" then
            if bulan = "1" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal , HRD_M_Karyawan.Kry_nama order by HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "2" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01) - (SAPK_Bayar01)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01) - (SAPK_Bayar01)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "3" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "4" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "5" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "6" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "7" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "8" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "9" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "10" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "11" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "12" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            end if
        else
            if bulan = "1" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal , HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "2" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01) - (SAPK_Bayar01)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01) - (SAPK_Bayar01)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "3" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "4" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "5" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "6" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "7" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "8" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "9" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "10" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP, sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "11" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "12" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"

                set mutasi = mutasi_cmd.execute
            end if
        end if
    else
        if nama = "" then
            if bulan = "1" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal , HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama ASC"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "2" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01) - (SAPK_Bayar01)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01) - (SAPK_Bayar01)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "3" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "4" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "5" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "6" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "7" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "8" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "9" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "10" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "11" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "12" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            end if
        else
            if bulan = "1" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal , HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "2" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01) - (SAPK_Bayar01)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01) - (SAPK_Bayar01)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"
                ' Response.Write mutasi_cmd.commandText & "<br>"
                set mutasi = mutasi_cmd.execute
            elseIf bulan = "3" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02) - (SAPK_Bayar01+SAPK_Bayar02)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "4" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "5" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "6" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "7" then 
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "8" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "9" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"') and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "10" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "11" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            elseIf bulan = "12" then
                mutasi_cmd.commandText = "SELECT SAPK_NIP,  sapk_awal +  ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)) as saldoawal, HRD_M_Karyawan.Kry_nama FROM HRD_T_SA_PK LEFT OUTER JOIN HRD_M_Karyawan ON HRD_T_SA_PK.SAPK_Nip = HRD_M_Karyawan.Kry_Nip WHERE (SAPK_Tahun = '"& tahun &"')and isnull(sapk_nip,'')<>'' AND HRD_M_Karyawan.Kry_nama LIKE '%"& nama &"%' GROUP BY SAPK_NIP,  sapk_awal + ((SAPK_Pinjam01 + SAPK_Pinjam02 + SAPK_Pinjam03 + SAPK_Pinjam04 + SAPK_Pinjam05 + SAPK_Pinjam06 + SAPK_Pinjam07 + SAPK_Pinjam08 + SAPK_Pinjam09 + SAPK_Pinjam10 + SAPK_Pinjam11) - (SAPK_Bayar01+SAPK_Bayar02+SAPK_Bayar03+SAPK_Bayar04 + SAPK_Bayar05 + SAPK_Bayar06 + SAPK_Bayar07 + SAPK_Bayar08 + SAPK_Bayar09 + SAPK_Bayar10 + SAPK_Bayar11)), HRD_M_Karyawan.Kry_nama ORDER BY HRD_M_Karyawan.Kry_Nama"

                set mutasi = mutasi_cmd.execute
            end if
        end if
    end if
 %>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MUTASI PINJAMAN</title>
    <!-- #include file='../../layout/header.asp' -->
    <style>
        .form-mutasi{
            padding:10px;
            background-color:#fff;
            border-radius:10px;
            margin-top:10px;
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(210,220,222,1) 0%, rgba(255,255,255,1) 100%);
        }
        .form-mutasi input[type="text"]{
            background: transparent;
            border:none;
        }
        .form-mutasi input[type="number"]{
            background: transparent;
            border:none;
        }
        .form-mutasi hr{
            margin-top:-1px;
        }
        </style>
        <script>
        function validasiMutasi(){

        }
    </script>
</head>
<div class='container'>
    <div class='form-mutasi'>
        <div class='row mb-3'>
            <div class='col text-center'>
                <h3>MUTASI PINJAMAN KARYAWAN</h3>
            </div>
        </div>
        <form action="index.asp" method="post" name="form-mutasi">
        <div class='row'>
            <div class='col-sm-2 mt-2'>
                <label>Priode Bulan</label>
            </div>
            <div class='col-sm-2'>
                <input type="number" id="bulan" name="bulan" class="form-control" autocomplete="off" min="1" max="12" required>
                <hr>
            </div>
            <div class='col-auto mt-2'>
                <label>Tahun</label>
            </div>
            <div class='col-sm-2'>
                <input type="number" id="tahun" name="tahun" class="form-control" autocomplete="off" required>
                <hr>
            </div>
            <div class='col'>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="option" id="detail" value="detail" required>
                    <label class="form-check-label" for="detail">Detail</label>
                </div>
                <div class="form-check form-check-inline align-self-end">
                    <input class="form-check-input" type="radio" name="option" id="rekap" value="rekap">
                    <label class="form-check-label" for="rekap">Rekapitulasi</label>
                </div>
            </div>
        </div>
        <div class='row mt-2'>
            <div class='col-sm-2 mt-2'>
                <label>Nama Karyawan</label>
            </div>
            <div class='col-sm-7'>
                <input type="text" id="nama" name="nama" class="form-control" autocomplete="off">
                <hr>
            </div>
            <div class='col'>
                <button type="submit" class="btn btn-primary btn-sm">Proses</button>
                <button type="button" class="btn btn-danger btn-sm" onclick="window.location.href='../index.asp'">Kembali</button>
                <% if bulan <> "" OR tahun <> "" then%>
                <button type="button" class="btn btn-success btn-sm" onclick="window.location.href='exportXls-proses.asp?bulan=<%=bulan%>&tahun=<%=tahun%>&nama=<%=nama%>&radio=<%=radio%>'">Convert</button>
                <% end if %>
            </div>
        </div>
        </form>
    </div>
    <!--kontent -->
    <div class='header' <% if bulan = "" then %> style="display: none;" <% end if %>>
        <div class='row mt-2 '>
            <div class='col'>
                <ul style="list-style:none;">
                    <li>PT Dakota Buana Semesta</li>
                    <li>JL.WIBAWA MUKTI II NO 8.JATI ASIH BEKASI</li>
                    <li>BEKASI</li>
                </ul>
            </div>
        </div>
    <% if radio = "detail" then  %>
        <div class='row'>
            <div class='col text-center'>
                <label><b><u>MUTASI PINJAMAN KARYAWAN DETAIL</u></b></label></br>
                <label>Priode Bulan <%= MonthName(bulan) &" Tahun "& tahun%></label>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <label>Tanggal Cetak</label>
                <label><%= month(now) &"/"& day(now) &"/"& year(now) %></label>
            </div>
        </div>
    </div>
    <div class='row' <% if bulan = "" then %> style="display: none;" <% end if %>>
        <div class='col'>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Tanggal</th>
                        <th scope="col">No Transaksi</th>
                        <th scope="col">Keterangan</th>
                        <th scope="col">Pinjaman</th>
                        <th scope="col">Pembayaran</th>
                        <th scope="col">Saldo Akhir</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if bulan <> "" And nama = "" then

                        tpinjaman = 0
                        tbayar = 0
                        saldoakhir = 0
                        do until mutasi.eof 
                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_PK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"
                            ' Response.Write mutasi_cmd.commandText & "<br>"
                            set pk = mutasi_cmd.execute

                            mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_BK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                            set bk = mutasi_cmd.execute                        
                    %>
                            <tr>
                                <th colspan="2">
                                    Nama/Nip : <%= mutasi("SAPK_Nip") %>
                                </th>
                                <th colspan="4">
                                    <%= mutasi("Kry_Nama") %>
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>Saldo Awal</td>
                                <td colspan="3"><%= replace(formatCurrency(mutasi("saldoawal")),"$","") %></td>
                            </tr>   
                            <tr>
                                <% 
                                if not pk.eof then
                                ' set subtotal
                                tpinjaman = mutasi("saldoawal") + pk("TPK_PP")
                                %>
                                    <td><%= pk("TPK_Tanggal") %></td>
                                    <td><%= pk("TPK_ID") %></td>
                                    <td><%= pk("TPK_Ket") %></td>   
                                    <td><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>   
                                <%
                                else
                                    tpinjaman = mutasi("saldoawal")
                                end if 
                                %>
                            </tr>   
                            <tr>
                                <% 
                                if not bk.eof then
                                ' total pinjaman
                                tbayar = bk("TPK_PP")
                                %>
                                <td><%= bk("TPK_Tanggal") %></td>
                                <td><%= bk("TPK_ID") %></td>
                                <td><%= bk("TPK_Ket") %></td>   
                                <td></td>
                                <td  colspan="2"><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td>   
                                <% 
                                else
                                tbayar = 0
                                end if 

                                    ' cek jika nilainya minus
                                    if tpinjaman > 0 then
                                        saldoakhir = tpinjaman - tbayar
                                    else
                                        saldoakhir = tpinjaman + tbayar
                                    end if
                                %>
                            </tr>   
                            <tr>
                                <td></td>
                                <td></td>
                                <th>Subtotal</th>   
                                <th><%= replace(formatCurrency(tpinjaman),"$","") %></th>   
                                <th><%= replace(formatCurrency(tbayar),"$","") %></th>   
                                <th>
                                    <% if saldoakhir = 0 then 
                                        Response.Write "LUNAS"
                                    else
                                        Response.Write  replace(formatCurrency(saldoakhir),"$","") 
                                    end if %>
                                </th>   
                            </tr>   
                        <% 
                            response.flush
                            mutasi.movenext 
                            loop  

                        else
                            if mutasi.eof then 
                        %>
                            <th colspan="6" rowspan="3" class="text-center" data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h5>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h5></th>
                        <% 
                            else

                            tpinjaman = 0
                            tbayar = 0
                            saldoakhir = 0
                                mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_PK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"
                                ' Response.Write mutasi_cmd.commandText & "<br>"
                                set pk = mutasi_cmd.execute

                                mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_BK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                                set bk = mutasi_cmd.execute                        
                    %>
                            <tr>
                                <th colspan="2">
                                    Nama/Nip : <%= mutasi("SAPK_Nip") %>
                                </th>
                                <th>
                                    <%= mutasi("Kry_Nama") %>
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>Saldo Awal</td>
                                <td><%= replace(formatCurrency(mutasi("saldoawal")),"$","") %></td>
                            </tr>   
                            <tr>
                                <% 
                                if not pk.eof then
                                ' set subtotal
                                tpinjaman = mutasi("saldoawal") + pk("TPK_PP")
                                %>
                                <td><%= pk("TPK_Tanggal") %></td>
                                <td><%= pk("TPK_ID") %></td>
                                <td><%= pk("TPK_Ket") %></td> 
                                <td><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>   
                                <%
                                else
                                tpinjaman = mutasi("saldoawal")
                                end if 
                                %>
                            </tr>   
                            <tr>
                                <% 
                                if not bk.eof then
                                ' total pinjaman
                                tbayar = bk("TPK_PP")
                                %>
                                <td><%= bk("TPK_Tanggal") %></td>
                                <td><%= bk("TPK_ID") %></td>
                                <td><%= bk("TPK_Ket") %></td>   
                                <td></td>
                                <td><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td>  
                                <% 
                                else
                                tbayar = 0
                                end if 

                                    ' cek jika nilainya minus
                                    if tpinjaman > 0 then
                                        saldoakhir = tpinjaman - tbayar
                                    else
                                        saldoakhir = tpinjaman + tbayar
                                    end if
                                %>
                            </tr>   
                            <tr>
                                <td></td>
                                <td></td>
                                <th>Subtotal</th>   
                                <th><%= replace(formatCurrency(tpinjaman),"$","") %></th>   
                                <th><%= replace(formatCurrency(tbayar),"$","") %></th>   
                                <th>
                                    <% if saldoakhir = 0 then 
                                        Response.Write "LUNAS"
                                    else
                                        Response.Write  replace(formatCurrency(saldoakhir),"$","") 
                                    end if %>
                                </th>   
                            </tr>   
                        <% 
                            end if
                        end if
                        %>
                </tbody>
            </table>
        </div>
    </div>
    <% else %>
    <div class='row'>
        <div class='row'>
            <div class='col text-center'>
                <label><b><u>MUTASI PINJAMAN KARYAWAN REKAPITULASI</u></b></label></br>
                <label>Priode Bulan <%= MonthName(bulan) &" Tahun "& tahun%></label>
            </div>
        </div>
        <div class='row'>
            <div class='col'>
                <label>Tanggal Cetak</label>
                <label><%= month(now) &"/"& day(now) &"/"& year(now) %></label>
            </div>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">NIP</th>
                        <th scope="col">Nama Karyawan</th>
                        <th scope="col">Saldo Awal</th>
                        <th scope="col">Pinjaman</th>
                        <th scope="col">Pembayaran</th>
                        <th scope="col">Saldo Akhir</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if bulan <> "" And nama = "" then

                        nol = 0 'untuk value yang tidak ada isinya
                        tsaldoawal = 0 'totalkeseluruhan saldo awal
                        tsaldoakhir = 0 'totalsaldo akhir
                        tpinjaman = 0
                        tbayar = 0
                        pinjam = 0
                        bayar = 0
                        do until mutasi.eof 
                        saldoakhir = 0

                            if mutasi("saldoawal") > 0 then
                                tsaldoawal = tsaldoawal + mutasi("saldoawal")
                            else
                                tsaldoawal = tsaldoawal + Abs(mutasi("saldoawal"))
                            end if

                            mutasi_cmd.commandText = "SELECT TPK_PP FROM HRD_T_PK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"
                            ' Response.Write mutasi_cmd.commandText & "<br>"
                            set pk = mutasi_cmd.execute

                            mutasi_cmd.commandText = "SELECT TPK_PP FROM HRD_T_BK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                            set bk = mutasi_cmd.execute                        
                    %>
                            <tr>
                                <td><%= mutasi("SAPK_Nip") %></td>
                                <td><%= mutasi("Kry_Nama") %></td>
                                <td><%= replace(formatCurrency(mutasi("saldoawal")),"$","") %></td>
                                <% 
                                if not pk.eof then 
                                    tpinjaman = tpinjaman + pk("TPK_PP")
                                    pinjam = pk("TPK_PP")
                                %>
                                    <td><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>
                                <%else%>
                                    <td><%= replace(formatcurrency(nol),"$","") %></td>
                                <% 
                                    tpinjaman = tpinjaman + nol
                                    pinjam = 0
                                end if 
                                ' bk 
                                if not bk.eof then
                                    tbayar = tbayar + bk("TPK_PP")
                                    bayar = bk("TPK_PP")
                                %>
                                    <td><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td> 
                                <% else%>
                                    <td><%= replace(formatcurrency(nol),"$","") %></td> 
                                <% 
                                    tbayar = tbayar 
                                    bayar = 0
                                end if 

                                    ' cek jika nilainya minus
                                    if mutasi("saldoawal") > 0 then
                                        saldoakhir = mutasi("saldoawal") + pinjam - bayar 
                                    elseIf mutasi("saldoawal") = 0 then
                                        saldoakhir = pinjam - bayar
                                    else
                                        saldoakhir = mutasi("saldoawal") - pinjam + bayar
                                    end if
                                %>
                                <td>
                                    <%= replace(formatCurrency(saldoakhir),"$","") %>
                                </td>   
                            </tr>
                        <% 
                                'hitung saldo akhir 
                                if saldoakhir > 0 then
                                    tsaldoakhir = tsaldoakhir + saldoakhir
                                else
                                    tsaldoakhir = tsaldoakhir + Abs(saldoakhir)
                                end if
                            mutasi.movenext 
                            loop  
                        %>
                            <tr>
                                <td></td>
                                <th>Total keseluruhan</th>
                                <th><%= replace(formatcurrency(tsaldoawal),"$","") %></th>
                                <th><%= replace(formatcurrency(tpinjaman),"$","") %></th>
                                <th><%= replace(formatcurrency(tbayar),"$","") %></th>
                                <th><%= replace(formatcurrency(tsaldoakhir),"$","") %></th>
                            </tr>
                        <%
                        else
                            if mutasi.eof then 
                        %>
                            <th colspan="6" rowspan="3" class="text-center" data-aos="zoom-out" data-aos-duration="1500" id="notifPinjaman"><h5>DATA TIDAK TERDAFTAR ATAU ANDA SALAH MEMASUKAN KEYWORD MOHON COBA KEMBALI</h5></th>
                        <% 
                            else

                            tpinjaman = 0
                            tbayar = 0
                            saldoakhir = 0
                            pinjam = 0
                            bayar = 0

                                mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_PK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"
                                ' Response.Write mutasi_cmd.commandText & "<br>"
                                set pk = mutasi_cmd.execute

                                mutasi_cmd.commandText = "SELECT TPK_Tanggal, TPK_ID, TPK_Ket, TPK_PP FROM HRD_T_BK WHERE Month(TPK_Tanggal) = '"& bulan &"' AND Year(TPK_Tanggal) = '"& tahun &"' AND TPK_AktifYN = 'Y' AND TPK_Nip = '"& mutasi("SAPK_Nip") &"'"

                                set bk = mutasi_cmd.execute                        
                    %>
                            <tr>
                                <td><%= mutasi("SAPK_Nip") %></td>
                                <td><%= mutasi("Kry_Nama") %></td>
                                <td><%= replace(formatCurrency(mutasi("saldoawal")),"$","") %></td>
                                <% 
                                if not pk.eof then 
                                tpinjaman = Abs(mutasi("saldoawal")) + pk("TPK_PP")
                                pinjam = pk("TPK_PP")
                                %>
                                    <td><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>
                                <%else%>
                                    <td><%= replace(formatcurrency(nol),"$","") %></td>
                                <% 
                                tpinjaman = Abs(mutasi("saldoawal"))
                                end if 
                                ' bk 
                                if not bk.eof then
                                tbayar = bk("TPK_PP")
                                bayar = bk("TPK_PP")
                                %>
                                    <td><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td> 
                                <% else%>
                                    <td><%= replace(formatcurrency(nol),"$","") %></td> 
                                <% 
                                tbayar = 0
                                bayar = 0
                                end if 

                                    ' cek jika nilainya minus
                                    if mutasi("saldoawal") > 0 then
                                        saldoakhir = mutasi("saldoawal") + pinjam - bayar 
                                    elseIf mutasi("saldoawal") = 0 then
                                        saldoakhir = pinjam - bayar
                                    else
                                        saldoakhir = mutasi("saldoawal") - pinjam + bayar
                                        saldoakhir = Abs(saldoakhir)
                                    end if
                                    
                                %>
                                <td>
                                    <%= replace(formatCurrency(saldoakhir),"$","") %>
                                </td>   
                            </tr>
                            <tr>
                                <td></td>
                                <th>Total keseluruhan</th>
                                <td><%= replace(formatCurrency(mutasi("saldoawal")),"$","") %></td>
                                <% if not pk.eof then%>
                                    <td><%= replace(formatCurrency(pk("TPK_PP")),"$","") %></td>
                                <% else %>
                                    <td><%= replace(formatCurrency(nol),"$","") %></td>
                                <% end if %>
                                <% if not bk.eof then %>
                                    <td><%= replace(formatCurrency(bk("TPK_PP")),"$","") %></td>
                                <% else %>
                                    <td><%= replace(formatCurrency(nol),"$","") %></td>
                                <% end if %>
                                <td>
                                    <% if saldoakhir <> "LUNAS" then 
                                        Response.Write  replace(formatCurrency(saldoakhir),"$","") 
                                    else
                                        Response.Write saldoakhir
                                    end if %>
                                </td>   
                            </tr>
                        <% 
                            end if
                        end if
                        %>
                </tbody>
            </table>
        </div>
    </div>
    <% end if %>
    <!--end kontent -->
</div>

<!-- #include file='../../layout/footer.asp' -->