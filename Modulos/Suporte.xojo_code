#tag Module
Protected Module Suporte
	#tag Method, Flags = &h0
		Function Data_Formatada_String(dataini As Date) As String
		  Dim d As String = dataini.SQLDate
		  
		  Dim d2(2) As String
		  
		  d2(0) = d.Mid(9,2)
		  d2(1) = d.Mid(6,2)
		  d2(2) = d.Left(4)
		  
		  d = Join(d2, "/")
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load_Sale_Dictionary(Lista As WebListBox)
		  For i As Integer = 0 to Lista.RowCount -1
		    Dim qtde As Int64 = CLong(Lista.Cell(i, 3))
		    
		    Session.saleitem.Value("itemId" + Trim(Lista.Cell(i, 0))) = Lista.Cell(i, 1)
		    Session.saleitem.Value("itemDescription" + Trim(Lista.Cell(i, 0))) = Lista.Cell(i, 2)
		    Session.saleitem.Value("itemQuantity" + Trim(Lista.Cell(i, 0))) = qtde
		    Session.saleitem.Value("itemAmount" + Trim(Lista.Cell(i, 0))) = ReplaceAll(Lista.Cell(i, 4), ",", ".")
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Load_Specific_Value(Key As String) As String
		  If Session.saleitem.HasKey(Key) Then
		    Return Session.saleitem.Value(Key)
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnLoad_Sale_Dictionary(Lista As WebListBox)
		  For i As Integer = 0 to Lista.RowCount -1
		    Session.saleitem.Remove("ItemId" + Lista.Cell(i, 0))
		    Session.saleitem.Remove("ItemDescription" + Lista.Cell(i, 0))
		    Session.saleitem.Remove("ItemQuantity" + Lista.Cell(i, 0))
		    Session.saleitem.Remove("ItemAmount" + Lista.Cell(i, 0))
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variant_to_String(dado() As Variant) As String()
		  Dim uk As Integer = dado.Ubound
		  Dim ret() As String
		  
		  For i As Integer = 0 to uk
		    ret.Append dado(i)
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Module
#tag EndModule
