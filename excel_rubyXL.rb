# Read Excel File
workbook = RubyXL::Parser.parse('./facturacion.xlsx')

# Write Excel File
workbook.write('./facturacion.xlsx')

# Obtener el Worksheet
worksheet = workbook['WorkSheetName']

# Export Excel File
send_data(
    workbook.stream.read,　:disposition => 'attachment', :type => 'application/excel', :filename => "FileName.xlsx"
)