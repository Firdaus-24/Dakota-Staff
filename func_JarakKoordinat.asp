<%


const pi = 3.14159265358979323846

Function distance(lat1, lon1, lat2, lon2, unit)
  Dim theta, dist
  If lat1 = lat2 And lon1 = lon2 Then
    distance = 0
  Else
    theta = lon1 - lon2
    dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
    dist = acos(dist)
    dist = rad2deg(dist)
    distance = dist * 60 * 1.1515
    Select Case ucase(unit)
      Case "K"
        distance = Round(((distance * 1.609344)* 1000),3)
      Case "N"
        distance = distance * 0.8684
    End Select
  End If
End Function


'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function get the arccos function from arctan function    :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function acos(rad)
  If Abs(rad) <> 1 Then
    acos = pi/2 - Atn(rad / Sqr(1 - rad * rad))
  ElseIf rad = -1 Then
    acos = pi
  End If
End function


'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function converts decimal degrees to radians             :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function deg2rad(Deg)
  deg2rad = cdbl(Deg * pi / 180)
End Function

'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function converts radians to decimal degrees             :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function rad2deg(Rad)
  rad2deg = cdbl(Rad * 180 / pi)
End Function

'response.write distance(32.9697, -96.80322, 29.46786, -98.53506, "M") & " Miles<br>"
'response.write distance(-6.296938,106.958028,-6.4285,106.8045813, "K") & " Kilometers<br>"
'response.write distance(32.9697, -96.80322, 29.46786, -98.53506, "N") & " Nautical Miles<br>"
%>