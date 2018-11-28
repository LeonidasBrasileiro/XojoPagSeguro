#tag Class
Protected Class Session
Inherits WebSession
	#tag Event
		Sub Open()
		  Load_payment_options
		  
		  Self.window_Cart = New Carrinho
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Load_payment_options()
		  valid_payment_options = new Dictionary
		  
		  valid_payment_options.Value("CREDIT_CARD") = "creditCard"
		  valid_payment_options.Value("BOLETO") = "boleto"
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		saleitem As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		valid_payment_options As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		window_Cart As Carrinho
	#tag EndProperty

	#tag Property, Flags = &h0
		window_Payment As Pagamento
	#tag EndProperty


	#tag Constant, Name = ErrorDialogCancel, Type = String, Dynamic = True, Default = \"Do Not Send", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogMessage, Type = String, Dynamic = True, Default = \"This application has encountered an error and cannot continue.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogQuestion, Type = String, Dynamic = True, Default = \"Please describe what you were doing right before the error occurred:", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogSubmit, Type = String, Dynamic = True, Default = \"Send", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorThankYou, Type = String, Dynamic = True, Default = \"Thank You", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorThankYouMessage, Type = String, Dynamic = True, Default = \"Your feedback helps us make improvements.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NoJavascriptInstructions, Type = String, Dynamic = True, Default = \"To turn Javascript on\x2C please refer to your browser settings window.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NoJavascriptMessage, Type = String, Dynamic = True, Default = \"Javascript must be enabled to access this page.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Content_Type, Type = String, Dynamic = False, Default = \"application/x-www-form-urlencoded; charset\x3DISO-8859-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Currency, Type = String, Dynamic = False, Default = \"BRL", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_email, Type = String, Dynamic = False, Default = \"YOUR_EMAIL", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Imagem_Cartao_Credito, Type = String, Dynamic = False, Default = \"https://stc.pagseguro.uol.com.br/public/img/payment-methods-flags/68x30/", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_JS_Source, Type = String, Dynamic = False, Default = \"<script type\x3D\"text/javascript\" src\x3D\"https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js\"></script>", Scope = Public
	#tag EndConstant

	#tag Constant, Name = pag_Seguro_Payment_Mode, Type = String, Dynamic = False, Default = \"default", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Reference, Type = String, Dynamic = False, Default = \"Referencia da compra", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Registered_email, Type = String, Dynamic = False, Default = \"yourmail@sandbox.pagseguro.com.br", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Sem_Juros, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Sessions_URL, Type = String, Dynamic = False, Default = \"https://ws.sandbox.pagseguro.uol.com.br/v2/sessions", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Shipping_Adress_Required, Type = String, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Timeout, Type = Double, Dynamic = False, Default = \"3000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_token, Type = String, Dynamic = False, Default = \"YOUR_TOKEN", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Pag_Seguro_Transactions_URL, Type = String, Dynamic = False, Default = \"https://ws.sandbox.pagseguro.uol.com.br/v2/transactions", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ActiveConnectionCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Browser"
			Group="Behavior"
			Type="BrowserType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Safari"
				"2 - Chrome"
				"3 - Firefox"
				"4 - InternetExplorer"
				"5 - Opera"
				"6 - ChromeOS"
				"7 - SafariMobile"
				"8 - Android"
				"9 - Blackberry"
				"10 - OperaMini"
				"11 - Epiphany"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="BrowserVersion"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Connection"
			Group="Behavior"
			Type="ConnectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - AJAX"
				"1 - WebSocket"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GMTOffset"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HashTag"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeaderCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Group="Behavior"
			Type="PlatformType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Macintosh"
				"2 - Windows"
				"3 - Linux"
				"4 - Wii"
				"5 - PS3"
				"6 - iPhone"
				"7 - iPodTouch"
				"8 - Blackberry"
				"9 - WebOS"
				"10 - iPad"
				"11 - AndroidTablet"
				"12 - AndroidPhone"
				"13 - RaspberryPi"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Protocol"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RenderingEngine"
			Group="Behavior"
			Type="EngineType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - WebKit"
				"2 - Gecko"
				"3 - Trident"
				"4 - Presto"
				"5 - EdgeHTML"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StatusMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Timeout"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_Expiration"
			Group="Behavior"
			InitialValue="-1"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_hasQuit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mConnection"
			Group="Behavior"
			Type="ConnectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - AJAX"
				"1 - WebSocket"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
