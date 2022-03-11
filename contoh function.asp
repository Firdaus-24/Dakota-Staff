<%
function formatNoMobil(nomobil)

	'dim nomobil
	dim ganti
	
		for i = 1 to len(nomobil)
		if IsNumeric(mid(nomobil,i,1)) = false then
			
			if NomorHabis = true then
				NomorHabis = false
				noMobilSpace = noMobilSpace & " " & mid(nomobil,i,1)
			else
				noMobilSpace = noMobilSpace & mid(nomobil,i,1)
				ganti = true
			end if
			
			
		else
			if ganti=true then
				noMobilSpace = noMobilSpace & " " & mid(nomobil,i,1)
				ganti = false
			else
				noMobilSpace = noMobilSpace & mid(nomobil,i,1)
			end if
			nomorHabis = true
		
		end if
	
	next
	
	
	formatNoMobil = noMobilSpace
	
end function

%>