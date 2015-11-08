
 'cand1 termina ramane motor cu 2 faze aprinse
 'in do loop am pus portc si portd pe 0 ... cand termina

$regfile = "m328pdef2.dat"                                   ' specify the used micro
$crystal = 16000000                                         ' used crystal frequency
$baud = 9600



 Dim X As Byte , Y As Byte , Contor As Integer , Costyy As Byte , Costyx As Byte
 Dim Inchar As Byte , Temp As Byte , Sensx As Byte , Sensy As Byte
 Dim Valoare As Byte , Valoare1 As Byte , Valoare2 As Byte
 Dim Jogx As Byte , Jogy As Byte , Jx As Byte , Jy As Byte
 Dim Step_pixel As Byte , Val_timer As Byte , Viteza As Byte , Repet As Byte
 'On Timer0 Pulse
 On Urxc Getchar

'Config Timer0 = Timer , Prescale = 256
Enable Interrupts
'Enable Timer0
Enable Urxc
'Set Ddrb.5
'PD2-PD5  PC0-PC3  in opozitie, primele 4 libere
Ddrd = &B00111100
Ddrc = &B00001111
'**************************
ldi r30,$00
ldi r31,6
mov r8,r30
mov r9,r31
Read Step_pixel
'Print "Step_pixel=" ; Step_pixel

Read Jogx
'Print "Jogx=" ; Jogx
Read Jogy
'Print "Jogy=" ; Jogy
Read Viteza


Print "costycnc 3.07"

Do
   Sus:
       If Contor = 0 Then
       If Valoare1 = 1 Then
       Else
       Read Valoare
       End If
          Contor = 10 + Step_pixel
          End If


    Gosub Scrie
    Waitms 1
Loop

Scrie:


          Sensx = 0
          Sensy = 0
      If Valoare = 65 Then
      Sensx = 2
      Elseif Valoare = 66 Then
      Sensx = 1
      Elseif Valoare = 67 Then
      Sensy = 1
      Elseif Valoare = 68 Then
      Sensy = 2


      Elseif Valoare = 49 Then
      Sensx = 2
      Sensy = 1
      Elseif Valoare = 50 Then
      Sensx = 2
      Sensy = 2
      Elseif Valoare = 51 Then
      Sensx = 1
      Sensy = 1
      Elseif Valoare = 52 Then
      Sensx = 1
      Sensy = 2
      Else

         Portc = 0
         Portd = 0
         Valoare1 = 1
         Valoare = 0

      End If

      If Sensx = 1 Then
      Incr X
      Elseif Sensx = 2 Then
      Decr X
      End If
      Gosub Estex
      If Sensy = 1 Then
      Incr Y
      Elseif Sensy = 2 Then
      Decr Y
      End If
      Gosub Estey
      Decr Contor
      If Contor < 0 Then Contor = 0


Return

 Estex:
 Costyx = X And 7
If Costyx = 0 Then
Portd = &B00000100
Elseif Costyx = 1 Then
Portd = &B00001100
Elseif Costyx = 2 Then
Portd = &B00001000
Elseif Costyx = 3 Then
Portd = &B00011000
Elseif Costyx = 4 Then
Portd = &B00010000
Elseif Costyx = 5 Then
Portd = &B00110000
Elseif Costyx = 6 Then
Portd = &B00100000
Elseif Costyx = 7 Then
Portd = &B00100100
End If
Return

Estey:
Costyy = Y And 7
 If Costyy = 0 Then
Portc = &B00000001
Elseif Costyy = 1 Then
Portc = &B00000011
Elseif Costyy = 2 Then
Portc = &B00000010
Elseif Costyy = 3 Then
Portc = &B00000110
Elseif Costyy = 4 Then
Portc = &B00000100
Elseif Costyy = 5 Then
Portc = &B00001100
Elseif Costyy = 6 Then
Portc = &B00001000
Elseif Costyy = 7 Then
Portc = &B00001001
End If
Return



Pulse:
Timer0 = Viteza
Decr Contor
If Contor < 0 Then Contor = 0
If Sensx = 1 Then Incr X Else Decr X
If Sensy = 1 Then Incr Y Else Decr Y
Return

Getchar:
  Valoare = Inkey()
'nano and pro mini
'15360
If Valoare = "E" Then Jmp &H3C00
 '  atmega8 &HF000



Return




End
