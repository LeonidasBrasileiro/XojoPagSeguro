#tag Class
Protected Class PagSeguro
Inherits WebControlWrapper
	#tag Event
		Function ExecuteEvent(Name as String, Parameters() as Variant) As Boolean
		  Select Case Name
		    
		  Case "SetSession"
		    RaiseEvent SetSession(Parameters(0))
		    
		  Case "GeraIDUsuario"
		    RaiseEvent GeraIDUsuario(Parameters(0))
		    
		  Case "BuscaBandeira"
		    RaiseEvent BuscaBandeira(Parameters(0))
		    
		  Case "Parcelamento"
		    RaiseEvent Parcelamento(Parameters)
		    
		  Case "CriaToken"
		    RaiseEvent CriaToken(Parameters(0))
		    
		  Case "ListaMeiosDisponiveis"
		    RaiseEvent ListaMeiosDisponiveis(Parameters)
		    
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub SetupCSS(ByRef Styles() as WebControlCSS)
		  Styles(0).Value("visibility") = "visible"
		End Sub
	#tag EndEvent

	#tag Event
		Function SetupHTML() As String
		  Return "<div id=""" + self.ControlID + """>" + html + "</div>"
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Aciona(params() As String)
		  self.HTML = join(params, "|*|")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HTMLHeader(CurrentSession as WebSession) As String
		  If Not IsLibraryRegistered(CurrentSession, JavascriptNamespace, "PagSeguroDirectPayment") Then
		    RegisterLibrary(CurrentSession, JavascriptNamespace, "PagSeguroDirectPayment")
		    Dim sa() As String
		    
		    sa.Append Session.Pag_Seguro_JS_Source
		    
		    sa.Append "<script>"
		    sa.Append a_SetSession
		    sa.Append a_GeraIDUsuario
		    sa.Append a_BuscaBandeira
		    sa.Append a_Parcelamento
		    sa.Append a_CriaToken
		    sa.Append a_ListaMeiosDisponiveis
		    sa.Append "</script>"
		    
		    Dim kp As String
		    kp = Join(sa, EndOfLine.UNIX)
		    
		    Return join(sa,EndOfLine.UNIX)
		    
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BuscaBandeira(dado As Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CriaToken(dado As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GeraIDUsuario(dado As Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ListaMeiosDisponiveis(dado As Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Parcelamento(dado As Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SetSession(dado As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Timeout()
	#tag EndHook


	#tag Note, Name = Card BIN
		
		
		BIN = 6 primeiros dígitos do cartão
		http://tefway.com.br/cartao-de-credito/o-que-significa-o-numero-bin-do-cartao-de-credito/
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mHTML
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHTML = value
			  If ControlAvailableInBrowser() Then
			    
			    Dim pars() As String
			    Dim s As String
			    pars = Split(value, "|*|")
			    s = pars(0) + "("
			    
			    pars.Remove(0)
			    
			    For ik As Integer = 0 to pars.Ubound
			      pars(ik) = "'" + pars(ik) + "'"
			    Next
			    
			    s = s + Join(pars, ", ")
			    
			    If s.InStr(0, "'") = 0 Then '= "GeraIDUSuario(" Then
			      s = s + "'" + self.ControlID + "');"
			    Else
			      s = s + ", '" + self.ControlID + "');"
			    End If
			    
			    ExecuteJavaScript(s)
			    
			  End If
			End Set
		#tag EndSetter
		HTML As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHTML As String
	#tag EndProperty


	#tag Constant, Name = a_BuscaBandeira, Type = String, Dynamic = False, Default = \"function BuscaBandeira(bin\x2C Controle) {\r\tPagSeguroDirectPayment.getBrand({\r\t\tcardBin: bin\x2C\r\t\tcomplete: function(response) {\r\t\t\tXojo.triggerServerEvent(Controle\x2C \'BuscaBandeira\'\x2C Object.values(response[\'brand\']));\r\t\t\t//console.log(response);\r\t\t}\r\t});\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = a_CriaToken, Type = String, Dynamic = False, Default = \"function CriaToken(numCartao\x2C cvvCartao\x2C expiracaoMes\x2C expiracaoAno\x2C Controle) {\r\tPagSeguroDirectPayment.createCardToken({\r\t\tcardNumber: numCartao\x2C\r\t\tcvv: cvvCartao\x2C\r\t\texpirationMonth: expiracaoMes\x2C\r\t\texpirationYear: expiracaoAno\x2C\r\t\tcomplete: function(response) {\r\t\t\tvar res \x3D [];\r\t\t\tif (Object.values(response)[\'error\'] \x3D\x3D \'true\') {\r\t\t\t\tres \x3D Object.values(response)[\'errors\'] ;\r\t\t\t} else {\r\t\t\t\tres \x3D Object.values(response[\'card\'])\r\t\t\t}\r\t\t\tXojo.triggerServerEvent(Controle\x2C \'CriaToken\'\x2C res);\r\t\t\tconsole.log(response);\r\t\t}\r\t});\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = a_GeraIDUsuario, Type = String, Dynamic = False, Default = \"function GeraIDUsuario(Controle) {\r\tPagSeguroDirectPayment.onSenderHashReady(function(response){\r\t\tif(response.status \x3D\x3D \'error\') {\r\t\t\tconsole.log(response.message);\r\t\t\treturn false;\r\t\t} else {\r\t\t\tconsole.log(response);\r\t\t}\r\tXojo.triggerServerEvent(Controle\x2C \'GeraIDUsuario\'\x2C Object.values(response));\r\t});\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = a_ListaMeiosDisponiveis, Type = String, Dynamic = False, Default = \"function ListaMeiosDisponiveis(valor\x2C Controle) {\r\tPagSeguroDirectPayment.getPaymentMethods({\r\t\tamount: valor\x2C\r\t\tcomplete: function(response) {\r\t\t\tXojo.triggerServerEvent(Controle\x2C \'ListaMeiosDisponiveis\'\x2C Object.keys(response[\'paymentMethods\']));\r\t\t\tconsole.log(response[\'paymentMethods\']);\r\r\t\t}\r\t});\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = a_Parcelamento, Type = String, Dynamic = False, Default = \"function Parcelamento(valor\x2C parc_sem_juros\x2C bandeira\x2C Controle) {\r\tPagSeguroDirectPayment.getInstallments({\r\t\tamount: valor\x2C\r\t\tmaxInstallmentNoInterest: parc_sem_juros\x2C\r\t\tbrand: bandeira\x2C\r\t\tcomplete: function(response) {\r\t\t\tvar res \x3D [];\r\t\t\tlet iterable \x3D Object.entries(response[\'installments\'][bandeira]);\r\t\t\tfor (let item of iterable) {\r\t\t\t\tlet iter2 \x3D item;\r\t\t\t\tfor (let inner of iter2) {\t\t\r\t\t\t\t\tif (typeof inner \x3D\x3D\x3D \'object\') {\r\t\t\t\t\t\tvar inres \x3D Object.values(inner);\r\t\t\t\t\t\tres.push(inres.join(\' | \'));\r\t\t\t\t\t}\r\t\t\t\t}\r\t\t\t}\r\t\t\tXojo.triggerServerEvent(Controle\x2C \'Parcelamento\'\x2C res);\r\t\t}\r\t});\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = a_SetSession, Type = String, Dynamic = False, Default = \"function SetSession(dado\x2C Controle) {\r\tPagSeguroDirectPayment.setSessionId(dado);\r\tvar resultado \x3D new Array(dado\x2C Controle);\r\tXojo.triggerServerEvent(Controle\x2C \'SetSession\'\x2C resultado);\r}", Scope = Public
	#tag EndConstant

	#tag Constant, Name = JavascriptNamespace, Type = String, Dynamic = False, Default = \"lbmdata.PagSeguro", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LayoutEditorIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NavigatorIcon, Type = String, Dynamic = False, Default = \"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", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Cursor"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Automatic"
				"1 - Standard Pointer"
				"2 - Finger Pointer"
				"3 - IBeam"
				"4 - Wait"
				"5 - Help"
				"6 - Arrow All Directions"
				"7 - Arrow North"
				"8 - Arrow South"
				"9 - Arrow East"
				"10 - Arrow West"
				"11 - Arrow Northeast"
				"12 - Arrow Northwest"
				"13 - Arrow Southeast"
				"14 - Arrow Southwest"
				"15 - Splitter East West"
				"16 - Splitter North South"
				"17 - Progress"
				"18 - No Drop"
				"19 - Not Allowed"
				"20 - Vertical IBeam"
				"21 - Crosshair"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="400"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HorizontalCenter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabOrder"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalCenter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ZIndex"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_DeclareLineRendered"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_HorizontalPercent"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_IsEmbedded"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_Locked"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_NeedsRendering"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_OfficialControl"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_OpenEventFired"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_VerticalPercent"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTML"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
