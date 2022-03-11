<script language="JScript" runat="server" src="../json/json2.js"></script>


 <%
					 url = "http://192.168.50.8/api/api_glb_m_agen.asp?key=15f6a51696a8b034f9ce366a6dc22138&id=11022019000001"
					 
					 'response.write url
					 
					 Set HttpReq = Server.CreateObject("MSXML2.ServerXMLHTTP")
						HttpReq.open "POST", url , false
						HttpReq.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
						HttpReq.Send("Foo=bar")
				
						Set myJSON = JSON.parse(HttpReq.responseText)
						
						for each i in MyJson
							response.write [i].Agen_ID & "<BR>"
							response.write [i].Agen_Nama & "<BR>"
							response.write [i].Agen_CabangID & "<BR>"
							response.write [i].Agen_TLC & "<BR>"
							response.write [i].Agen_Kode & "<BR>"
							response.write [i].Agen_Alamat & "<BR>"
							
							
							response.write "<HR>"
						next

						
					
					
					
					 %>