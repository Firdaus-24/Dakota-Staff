<% 
function getNameDay(el)
	select case el
		Case 1
			response.write("Minggu")
		Case 2
			response.write("Senin")
		Case 3
			response.write("Selasa")
		Case 4
			response.write("Rabu")
		Case 5
			response.write("Kamis")
		Case 6
			response.write("Jum'at")
		Case Else
			response.write("Sabtu")
	End Select
End function

 %>