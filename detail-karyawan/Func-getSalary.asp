<%
function FuncgetSalary(nip)

set kryn = Server.CreateObject("ADODB.Command")
kryn.activeConnection = MM_Cargo_String

kryn.commandText = "SELECT * FROM HRD_M_Karyawan WHERE Kry_NIP ='"& nip &"'"

set kry = kryn.execute

'set getsalary
set getsalary = server.createObject("ADODB.Command")
getsalary.activeConnection = MM_Cargo_String

getsalary.commandText = "SELECT * FROM HRD_T_Salary_COnvert WHERE Sal_NIP = '"& nip &"' and year(sal_startDate) = YEAR(getdate()) ORDER BY Sal_StartDate DESC "

set getsalary = getsalary.execute

                nomor = 0
                hasilgajisatutahun = 0               
                do until getsalary.eof 
                nomor = nomor + 1

                bpjsp = (getsalary("Sal_gapok") / 100) * 4
                bpjsk = (getsalary("Sal_gapok") / 100) * Cdbl(0.89)

                if kry("Kry_BPJSKesYN") = "N" then 
                    'make atribut to round or ceil number
                    rbpjsp = 0
                    rbpjsk = 0
                else
                    'make atribut to round or ceil number
                    rbpjsp = round(bpjsp)
                    rbpjsk = Round(bpjsk)
                end if

                
           
                            bpjsp2 = 4 / 100 * getsalary("Sal_gapok")
                            bpjsk2 = 1 / 100 * getsalary("Sal_gapok")

                            totaltnj = Cdbl(getsalary("Sal_Gapok")) + Cdbl(getsalary("Sal_Insentif")) + Cdbl(getsalary("Sal_THR")) + Cdbl(getsalary("Sal_TunjTransport")) + bpjsp2 + Cdbl(getsalary("Sal_TunjKesehatan")) + Cdbl(getsalary("Sal_TunjKeluarga")) + Cdbl(getsalary("Sal_TunjJbt")) + Cdbl(getsalary("Sal_Asuransi"))

                            totalpot = Cdbl(getsalary("Sal_Jamsostek")) + bpjsp2 + Cdbl(getsalary("Sal_koperasi")) + Cdbl(getsalary("Sal_Klaim")) + Cdbl(getsalary("Sal_Pph21")) + Cdbl(getsalary("Sal_Asuransi")) + Cdbl(getsalary("Sal_Absen")) + Cdbl(getsalary("Sal_Lain")) + bpjsk2
                            
                            total = totaltnj - totalpot
                            hasilgajisatutahun = hasilgajisatutahun + total
                            ' Response.Write total & "<br>"
                            
                getsalary.movenext
                if getsalary.eof  = true then
                    lasgaji = total
                end if
                loop
           
    sisagaji = ( 12 - nomor ) * lasgaji
    ' Response.Write "<hr>" & "<br>"
    ' Response.Write sisagaji & "<br>"
    ' Response.Write hasilgajisatutahun & "<br>"
    gajisekeluruhan = sisagaji + hasilgajisatutahun
    Response.Write gajisekeluruhan
end function
 %>
